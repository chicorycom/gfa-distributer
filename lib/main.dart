import 'package:distributer_gfa/src/controllers/RequestController.dart';
import 'package:distributer_gfa/src/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main()  {
return runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => RequestController()),
        ],
        child:  MyApp(),
      )
  );
}

class MyApp extends StatefulWidget {

  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {

  @override
  void initState()  {
    SharedPreferences.setMockInitialValues({});
    context.read<RequestController>().configRequest(context);
    super.initState();
  }


    @override
    void dispose(){
      super.dispose();
    }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //context.read<RequestController>().getWaiting(socket);
    return MaterialApp(
      title: 'Distributeur',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     /* routes: {
        '/': (context) => MyHomePage(title: 'Distributeur GFA'),
        '/settings': (context) => Settings(title: 'Distributeur GFA'),
      },*/

      home: MyHomePage(title: 'Distributeur GFA')
    );
  }
}


