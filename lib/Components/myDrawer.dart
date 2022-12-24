import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/Helpers/Constants/myColors.dart';
import 'package:movies_app/Screens/Favorites/index.dart';

Drawer myDrawer = Drawer(
  child: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.deepPurple, Colors.pink],
      ),
    ),
    child: Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Container(
          height: 120,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 28),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    CupertinoIcons.person_crop_circle,
                    color: Colors.white,
                    size: 55,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Text(
                      "Ammar",
                      style: GoogleFonts.jockeyOne(
                        color: white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.white,
          endIndent: 15,
          indent: 15,
        ),
        ListTile(
          leading: Icon(
            CupertinoIcons.heart_fill,
            color: Colors.white,
            size: 30,
          ),
          title: Text(
            'Favourites',
            style: GoogleFonts.jockeyOne(
              color: white,
              fontSize: 18,
            ),
          ),
          onTap: () async {
            await Get.to(
              () => Favorites(),
              duration: Duration(milliseconds: 850),
              transition: Transition.leftToRightWithFade,
            );
          },
        ),
        ListTile(
          tileColor: Colors.white.withOpacity(0.2),
          leading: Icon(
            CupertinoIcons.bitcoin,
            color: Colors.white,
            size: 30,
          ),
          title: Text(
            'Todo',
            style: GoogleFonts.jockeyOne(
              color: white,
              fontSize: 18,
            ),
          ),
          onTap: () {},
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Designed by AKA",
              style: GoogleFonts.jockeyOne(
                color: white,
                fontSize: 15,
              ),
            )
          ],
        )
      ],
    ),
  ),
);
