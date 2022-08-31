import 'package:flutter/material.dart';
import 'dart:async';
import 'Awal/loginAs.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return loginAsPage();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  new Container(
        decoration: new BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/gambar/rojotani.png'),
            fit: BoxFit.cover
          ),
        ),
        child : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [ Container(
            height: 200.0,
            width: 300.0,)],
        )
      )
      );
  }
}
