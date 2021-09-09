import 'dart:convert';

import 'package:distributer_gfa/src/controllers/RequestController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:distributer_gfa/src/utiles/style.dart';



class SettingDialogue extends StatefulWidget {
  final String title;

  const SettingDialogue({Key? key, required this.title}) : super(key: key);

  @override
  _SettingDialogueDialogueState createState() => _SettingDialogueDialogueState();
}

class _SettingDialogueDialogueState extends State<SettingDialogue> {

  late String _ip;
  late String _port;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final ipClear = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // validate user name
  String? _validateIp(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  String? _validatePort(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final SharedPreferences prefs = await _prefs;
      await prefs.setString('settings', jsonEncode({'config': true, 'ip': _ip, 'port': _port}));
      await context.read<RequestController>().configRequest(context);
      Navigator.of(context).pop();
    }

  }



  Widget _buildValidateBtn() {
    return Container(
      width: double.infinity,
      child:  ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.blue,
          primary: Colors.blueAccent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "Valider",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        onPressed: _submit,
      ),
    );
  }

  Widget _buildIP() {
    return  Expanded(
      flex: 7,
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        cursorWidth: 1,
        controller: ipClear,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(
              Icons.settings_remote,
              color: Colors.black54,
            ),
            labelText: '192.168.1.21'
        ),
        validator: _validateIp,
        onSaved: (value) => _ip = value!
      ),
    );
  }

  Widget _buildPort() {
    return Expanded(
        flex: 3,
        child: TextFormField(
          keyboardType: TextInputType.number,
          obscureText: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '3000'
          ),
          validator: _validatePort,
          onSaved: (value) => _port = value!,
        ),
    );
  }


  @override
  Widget build(BuildContext context) {

     return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
              + Constants.padding, right: Constants.padding,bottom: Constants.padding
          ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Form(
              key: _formKey,
              child:  Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(widget.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                  SizedBox(height: 15,),
                  Row(
                    children: <Widget>[
                      _buildIP(),
                      _buildPort()
                    ],
                  ),
                  SizedBox(height: 22,),
                  _buildValidateBtn(),
                ],
              ),
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Icon(
                    Icons.settings,
                    size: 90,
                    color: Colors.black87,
                )
            ),
          ),
        ),
      ],
    );
  }

}