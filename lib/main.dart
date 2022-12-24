import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/Controllers/FavoritesCon.dart';
import 'package:movies_app/Screens/Home/index.dart';
import 'package:movies_app/Screens/Splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoritesProv(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movies App',
        routes: {
          '/': (context) => Splash(),
          '/home': (context) => HomePage(),
        },
        initialRoute: '/',
      ),
    );
  }
}
