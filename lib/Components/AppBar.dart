import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/Helpers/Constants/myColors.dart';
import 'package:movies_app/Screens/Favorites/index.dart';

AppBar myAppbar = AppBar(
  title: Text('Movies App'),
  centerTitle: true,
  flexibleSpace: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.deepPurple, Colors.pink],
      ),
    ),
  ),
  actions: [
    IconButton(
      icon: Icon(
        Icons.favorite,
        color: Colors.white,
      ),
      onPressed: () async {
        await Get.to(
          () => Favorites(),
          duration: Duration(milliseconds: 1100),
          transition: Transition.rightToLeftWithFade,
        );
      },
    )
  ],
);

Widget NamedAppBar(String _title) {
  return AppBar(
    title: Text(_title),
    backgroundColor: deepPurple,
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.pink, Colors.deepPurple],
        ),
      ),
    ),
  );
}
