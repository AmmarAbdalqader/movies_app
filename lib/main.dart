import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/Screens/Home/index.dart';
import 'package:movies_app/Splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        '/': (context) => Splash(),
        '/home': (context) => HomePage(),
      },
      initialRoute: '/',
    );
  }
}
