import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:movies_app/Screens/Home/index.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 2750), vsync: this);
    animation = ColorTween(begin: Colors.pink, end: Colors.deepPurple)
        .animate(controller!);
    controller!.forward();
    controller!.addListener(() {
      setState(() {});
    });

    Timer(Duration(milliseconds: 3500), () {
      Get.off(
        () => HomePage(),
        duration: Duration(milliseconds: 100),
        transition: Transition.fade,
      );
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation!.value,
      body: Center(
        child: Stack(
          children: [
            Icon(
              CupertinoIcons.tv,
              color: Colors.white,
              size: 225,
            ),
            Positioned(
              right: 95,
              top: 85,
              child: Text(
                'TV',
                style: GoogleFonts.anton(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
