import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/Components/AppBar.dart';
import 'package:movies_app/Helpers/Constants/myColors.dart';
import 'package:movies_app/Screens/Details/index.dart';

class More extends StatelessWidget {
  final List<dynamic> myList = Get.arguments;

  Widget ShowContainer() {
    return Expanded(
      child: ListView.separated(
        itemCount: myList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              await Get.to(() => Details(),
                  arguments: myList[index],
                  duration: Duration(milliseconds: 700),
                  transition: Transition.leftToRightWithFade);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 185,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Image(
                        image: NetworkImage(myList[index].Image),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            myList[index].Title,
                            style: GoogleFonts.jockeyOne(
                                fontSize: 20, color: white),
                          ),
                          Text(
                            myList[index].Year,
                            style: GoogleFonts.jockeyOne(
                                fontSize: 18, color: white),
                          ),
                          Text(
                            myList[index].Crew,
                            style: GoogleFonts.jockeyOne(
                                fontSize: 15, color: white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.star,
                                color: yellow,
                                size: 23,
                              ),
                              myList[index].IMDbRating.toString().isNotEmpty
                                  ? Text(
                                      ' ' + myList[index].IMDbRating,
                                      style: GoogleFonts.jockeyOne(
                                          fontSize: 18, color: white),
                                    )
                                  : Text(
                                      ' TBA',
                                      style: GoogleFonts.jockeyOne(
                                        color: white,
                                        fontSize: 16,
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.white54,
            indent: 8,
            endIndent: 8,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar,
      backgroundColor: greyBG,
      body: Column(
        children: [
          ShowContainer(),
        ],
      ),
    );
  }
}
