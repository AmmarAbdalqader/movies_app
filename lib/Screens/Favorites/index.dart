import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/Components/AppBar.dart';
import 'package:movies_app/Helpers/Models/TopShows.dart';
import 'package:movies_app/Helpers/Constants/myColors.dart';
import 'package:movies_app/Screens/Details/index.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  bool isLoading = false;

  TopShows _topShows = new TopShows();

  var list = [];

  Widget ShowContainer() {
    return Expanded(
      child: ListView.separated(
        itemCount: myFav.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(myFav[index].Id!),
            onDismissed: (direction) {
              setState(() {
                _topShows.updateFav(myFav[index], false);
                Get.snackbar('Removed from Favourites', '');
              });
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
                        style: TextStyle(
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
                    arguments: myFav[index],
                    duration: Duration(milliseconds: 700),
                    transition: Transition.leftToRightWithFade);
                setState(() {});
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
                                image: NetworkImage(myFav[index].Image!),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    myFav[index].Title!,
                                    style:
                                        TextStyle(fontSize: 20, color: white),
                                  ),
                                  Text(
                                    myFav[index].Year!,
                                    style:
                                        TextStyle(fontSize: 18, color: white),
                                  ),
                                  Text(
                                    myFav[index].Crew!,
                                    style:
                                        TextStyle(fontSize: 15, color: white),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: yellow,
                                        size: 23,
                                      ),
                                      myFav[index]
                                              .IMDbRating
                                              .toString()
                                              .isNotEmpty
                                          ? Text(
                                              ' ' + myFav[index].IMDbRating!,
                                              style: TextStyle(
                                                  fontSize: 18, color: white),
                                            )
                                          : Text(
                                              ' TBA',
                                              style: TextStyle(
                                                color: white,
                                                fontSize: 16,
                                              ),
                                            ),
                                    ],
                                  )
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyBG,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(54),
        child: NamedAppBar("Favourites"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                ShowContainer(),
              ],
            ),
    );
  }
}
