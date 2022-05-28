import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/Helpers/myColors.dart';
import 'package:movies_app/Screens/Home/index.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(milliseconds: 1500),
      () => Get.off(() => HomePage(),
          duration: Duration(milliseconds: 100), transition: Transition.fade),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black54,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
