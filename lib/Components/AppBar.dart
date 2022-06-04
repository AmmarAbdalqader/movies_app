import 'package:flutter/material.dart';
import 'package:movies_app/Helpers/Constants/myColors.dart';

AppBar myAppbar = AppBar(
  title: Text('Movies App'),
  centerTitle: true,
  backgroundColor: deepPurple,
  actions: <Widget>[
    IconButton(
      icon: Icon(
        Icons.favorite,
        color: Colors.white,
      ),
      onPressed: () {
        // do something
      },
    )
  ],
);

Widget NamedAppBar(String _title) {
  return AppBar(
    title: Text(_title),
    // centerTitle: true,
    backgroundColor: deepPurple,
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.favorite,
          color: Colors.white,
        ),
        onPressed: () {
          // do something
        },
      )
    ],
  );
}
