import 'package:flutter/material.dart';
import 'SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RojoTani',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashScreenPage(),
    );
  }
}
