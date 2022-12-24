import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/Components/AppBar.dart';
import 'package:movies_app/Controllers/FavoritesCon.dart';
import 'package:movies_app/Helpers/Constants/myColors.dart';
import 'package:movies_app/Screens/Details/index.dart';
import 'package:provider/provider.dart';

class Favorites extends StatelessWidget {
  Widget ShowContainer() {
    return Builder(
      builder: (context) {
        var favProv = Provider.of<FavoritesProv>(context);
        return Expanded(
          child: ListView.separated(
            itemCount: favProv.getFavListLength,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(favProv.getFavList[index].Id!),
                onDismissed: (direction) {
                  favProv.removeFav(favProv.getFavList[index]);
                  Get.snackbar('Removed from Favourites', '');
                },
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 35,
                          ),
                          Icon(
                            Icons.clear,
                            color: Colors.white,
                            size: 38,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Remove\nfrom Fav',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.jockeyOne(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                child: GestureDetector(
                  onTap: () async {
                    await Get.to(() => Details(),
                        arguments: favProv.getFavList[index],
                        duration: Duration(milliseconds: 700),
                        transition: Transition.leftToRightWithFade);
                  },
                  child: Container(
                    color: greyBG,
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 185,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Image(
                                    image: NetworkImage(
                                        favProv.getFavList[index].Image!),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        favProv.getFavList[index].Title!,
                                        style: GoogleFonts.jockeyOne(
                                            fontSize: 20, color: white),
                                      ),
                                      Text(
                                        favProv.getFavList[index].Year!,
                                        style: GoogleFonts.jockeyOne(
                                            fontSize: 18, color: white),
                                      ),
                                      Text(
                                        favProv.getFavList[index].Crew!,
                                        style: GoogleFonts.jockeyOne(
                                            fontSize: 15, color: white),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: yellow,
                                            size: 23,
                                          ),
                                          favProv.getFavList[index].IMDbRating!
                                                  .isNotEmpty
                                              ? Text(
                                                  ' ' +
                                                      favProv.getFavList[index]
                                                          .IMDbRating!,
                                                  style: GoogleFonts.jockeyOne(
                                                      fontSize: 18,
                                                      color: white),
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
                      ],
                    ),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyBG,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(54),
        child: NamedAppBar("Favourites"),
      ),
      body: Column(
        children: [
          ShowContainer(),
        ],
      ),
    );
  }
}
