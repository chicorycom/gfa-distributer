import 'dart:ui';
import 'package:distributer_gfa/src/utiles/style.dart';
import 'package:distributer_gfa/src/widgets/dialogue.dart';
import 'package:provider/provider.dart';
import 'package:distributer_gfa/src/controllers/RequestController.dart';
import 'package:flutter/material.dart';




class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState(){
    super.initState();
    final bool config = context.read<RequestController>().config;
    if(!config){
      WidgetsBinding.instance?.addPostFrameCallback(
              (_) => _dialoShow(context, false)
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
     child: Scaffold(
       body: Container(
         decoration: BoxDecoration(
             gradient: LinearGradient(
                 colors: [Color(0xff1542bf), Color(0xff51a8ff)],
                 begin: FractionalOffset(0.5,1)
             )
         ),
         width: double.infinity,

         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             Padding(
               padding: EdgeInsets.all(18.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(
                       "GFA Distributer",
                       style: TextStyle(
                           color: Colors.white,
                           fontSize: 20.0
                       )
                   ),
                   IconButton(
                     icon: const Icon(Icons.settings_outlined),
                     color: Colors.white,
                     tooltip: 'Setting distributer',
                     onPressed: () {
                       _dialoShow(context, true);
                     },
                   ),

                 ],
               ),
             ),

             Expanded(
                 child: Consumer<RequestController>(
                   builder: (context, requestCtl, child)
                   => Stack(
                     children: [
                       Center(
                         child: Column(
                           children: <Widget>[
                             SizedBox(height: 10),
                             Text(
                               'Numéro',
                               style: TextStyle(
                                   fontSize: 30.0,
                                   color: Colors.white
                               ),
                             ),
                             Text(
                               '${requestCtl.numberCall}',
                               style: TextStyle(
                                   fontSize: 130.0,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.white
                               ),
                             ),
                           ],
                         ),
                       ),
                       Positioned(
                           right: 00.0,
                           bottom: 10.0,
                           child: new Container(
                             width: 170.0,
                             height: 80.0,

                             child: Row(
                               children: [
                                 Text(
                                   '${requestCtl.name}',
                                   style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                       fontSize: 28,
                                       color: Colors.white
                                   ),
                                 ),
                                 SizedBox(width: 5),
                                 Container(
                                   width: 50,
                                   height: 40,
                                   alignment: Alignment.center,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(5.0),
                                     color: requestCtl.color,
                                   ),
                                   child: Text(
                                     context.watch<RequestController>().caisse.toString(),
                                     style: TextStyle(
                                         fontSize: 28,
                                         color: Colors.white,
                                         fontWeight: FontWeight.bold
                                     ),
                                   ),
                                 )
                               ],
                             ),
                           )
                       ),
                     ],
                   ),
                 )
             ),

             Expanded(
               child: Container(
                 width: double.infinity,
                 decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.only(topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0))
                 ),
                 child: Padding(
                   padding: EdgeInsets.only(top: 30.0, right: 20.0),
                   child: Column(
                     children: <Widget>[
                       Expanded(
                           child: Row(
                             children: <Widget>[
                               Expanded(
                                   child: Column(
                                     children: <Widget>[
                                       Text(
                                         "Ticket",
                                         style: TextStyle(
                                             fontSize: 30.0
                                         ),
                                       ),
                                       Text(
                                         '${context.watch<RequestController>().number}',
                                         style: TextStyle(
                                             fontSize: 80.0
                                         ),
                                       )
                                     ],
                                   )
                               ),
                               Expanded(
                                 child: Column(
                                   children: <Widget>[
                                     Text(
                                       "En attente",
                                       style: TextStyle(
                                           fontSize: 30.0
                                       ),
                                     ),
                                     Text(
                                       '${context.watch<RequestController>().waiting}',
                                       key: const Key('waitingState'),
                                       style: TextStyle(
                                           fontSize: 80.0
                                       ),
                                     )
                                   ],
                                 ),
                               )
                             ],
                           )
                       ),
                       Padding(
                         padding: EdgeInsets.symmetric(vertical: 28.0),
                         child: ElevatedButton(
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
                               "Opération Caisse",
                               style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 20.0,
                                   fontWeight: FontWeight.bold
                               ),
                             ),
                           ),
                           onPressed: () {
                             Provider.of<RequestController>(context,listen:false).postRequest();
                           }
                           //print('context')
                           ,
                         ),
                       )
                     ],
                   ),
                 ),
               ),
             )
           ],
         ),
       ),
     ),
    );
  }

 void _dialoShow(BuildContext context, bool dismissible){
   showDialog(
        context: context,
       barrierDismissible: dismissible,
       builder: (BuildContext context){
          return SettingDialogue(
              title: "Server Address and Port"
          );
        }
    );
  }
}