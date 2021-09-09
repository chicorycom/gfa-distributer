import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:soundpool/soundpool.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Controller.dart';

class RequestController extends Controller {

  int _waiting = 0;
  int _numberCall = 0;
  int _number = 0;
  int _caisse = 0;
  Color _color = HexColor('#aabbcc');
  String _name = 'Caisse';
  bool _config = false;
  late Socket socket;
  Soundpool pool = Soundpool(streamType: StreamType.notification);
  String _localPath = "assets/audio/sound.mp3";
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  int get waiting => _waiting;

  int get number => _number;

  int get numberCall => _numberCall;

  bool get config => _config;

  int get caisse => _caisse;

  Color get color => _color;

  String get name => _name;


  void getWaiting(data) {
    _waiting = data;
    notifyListeners();
  }

  void getCall(data){
    _numberCall = data['call'];
    _caisse = data['box']['number'];
    _color =  HexColor(data['box']['color']);
    _name = data['box']['name'];
    _loadSounds();
    notifyListeners();
  }

  void getInitial(data){
    _numberCall = data['call'];
    _number = data['ticket'];
    _waiting = data['ent'];
    _caisse = data['box']['number'];
    _color =  HexColor(data['box']['color']);
    _name = data['box']['name'];
    notifyListeners();
  }


  void _httpInit(Map<String, dynamic> set) async {
    final Uri uri = Uri(
        scheme: 'http',
        host: set['ip'],
        port: int.parse(set['port']),
        path: '/api/v1/initial'
    );

    final response = await  http.get(uri);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = json.decode(response.body);
        getInitial(data);
    }
  }

  void postRequest() async {
    final prefs = await SharedPreferences.getInstance();
    final set = jsonDecode((prefs.getString('settings') ?? '{}'));
    final Uri uri = Uri(
        scheme: 'http',
        host: set['ip'],
        port: int.parse(set['port']),
        path: '/api/v1/request'
    );

    final response = await  http.post(uri);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = json.decode(response.body);
      _number = data['number'];
      notifyListeners();
    }
  }


   configRequest(context) async {
     final SharedPreferences prefs = await _prefs;
     final set =  jsonDecode(prefs.getString('settings') ?? '{}');
     if(set.containsKey("config")) {
       _config = true;
       socket = io('ws://${set['ip']}:${set['port']}',
           <String, dynamic>{
             'transports': ['websocket'],
             'with_credentials': true,
             'extra_headers': {'my-custom-header': 'abcd'}
           });
       socket.onConnect((_) {
         print('connect');
         ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text('Connected to Server!!!')),
         );
       });
       socket.onConnectError((error) {
         print('ConnectError: $error');

       });
       socket.onConnectTimeout((error) {
         print('ConnectTimeout: $error');

       });
       socket.onError((_) {
         print('Error');

       });
       socket.onDisconnect((_) => print('disconnect'));
       socket.on('ent', (data) => {
         getWaiting(data['ent'])
       });

       socket.on('call', (data)  {
         getCall(data);
       });

       _httpInit(set);
     }
  }

  void _loadSounds() async {
    int soundId = await rootBundle.load(_localPath)
        .then((ByteData soundData) {
          return pool.load(soundData);
    });
    int streamId = await pool.play(soundId);
  }
}