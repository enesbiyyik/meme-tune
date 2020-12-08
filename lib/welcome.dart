import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_splash/flutter_splash.dart';
import 'package:flutteray/main.dart';
import 'models/data.dart' as meme;

class Welcome extends StatefulWidget {
  @override
  _DenemeState createState() => _DenemeState();
}

class _DenemeState extends State<Welcome> {

  var mySharedPrefences;

  @override
  Widget build(BuildContext context) {
    return new Splash(
      title: new Text('Hoş Geldiniz',style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      loaderColor: Colors.blue,
      navigateAfterFuture: () => control(),
    );
  }
  Future<void> control() async {
    await meme.MemeSongData.getMemeData();
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => MyHomePage()));
    return FirebaseAdMob.instance.initialize(appId: "ca-app-pub-2344041854959623~3014047120");
  }
}