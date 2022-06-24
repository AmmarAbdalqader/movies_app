import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/Helpers/Constants/API_Key.dart';
import 'package:movies_app/Helpers/Models/TopShows.dart';
import 'package:movies_app/Helpers/Constants/myColors.dart';
import 'package:movies_app/Helpers/Models/Poster.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:movies_app/Helpers/Models/ShowInfo.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var show = Get.arguments; // Object

  List<Poster> BackPosters = [];

  ShowInfo info = new ShowInfo(
      Id: '',
      FullTitle: '',
      Image: '',
      ReleaseDate: '',
      RunTimeMins: '',
      RunTimeStr: '',
      Title: '',
      Plot: '',
      Directors: '',
      Genres: '',
      Companies: '',
      ContentRating: '',
      Tagline: '',
      SimilarsList: new List<Similars>.generate(10,
          (index) => Similars(Id: '', Title: '', Image: '', IMDbRating: '')));

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    await getBackPosters();
    await getInfo();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getBackPosters() async {
    String url = "https://imdb-api.com/en/API/Posters/$api_key/${show.Id}";

    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    setState(() {
      Map data = json.decode(utf8.decode(response.bodyBytes));

      BackPosters =
          (data['backdrops'] as List).map((e) => Poster.fromJson(e)).toList();
      print(BackPosters.length);
    });
  }

  Future<void> getInfo() async {
    String url = "https://imdb-api.com/en/API/Title/$api_key/${show.Id}";

    print(url);

    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    setState(() {
      Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));

      info = ShowInfo.fromJson(data);
      info.SimilarsList =
          (data['similars'] as List).map((e) => Similars.fromJson(e)).toList();
    });
  }

  Widget PosterSlider() {
    return ImageSlideshow(
      width: MediaQuery.of(context).size.width,
      height: 222,
      initialPage: 0,
      indicatorColor: Colors.deepPurple,
      indicatorBackgroundColor: Colors.grey,
      children: [
        Image(image: NetworkImage(BackPosters[0].Link)),
        Image(image: NetworkImage(BackPosters[1].Link)),
        Image(image: NetworkImage(BackPosters[2].Link)),
        if (BackPosters.length > 4)
          Image(image: NetworkImage(BackPosters[3].Link)),
        if (BackPosters.length > 6)
          Image(image: NetworkImage(BackPosters[5].Link)),
      ],
      autoPlayInterval: 5000,
      isLoop: true,
    );
  }

  Widget ShowsSliderWidget(List<dynamic> myList) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 230,
      child: Row(
        children: [
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: myList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Get.to(() => Details(),
                    //     arguments: myList[index],
                    //     duration: Duration(milliseconds: 700),
                    //     transition: Transition.leftToRightWithFade);
                  },
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(myList[index].Image),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            width: 55,
                            height: 25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: black54),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: yellow,
                                  size: 19,
                                ),
                                myList[index].IMDbRating.toString().isNotEmpty
                                    ? Text(
                                        myList[index].IMDbRating,
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 14,
                                        ),
                                      )
                                    : Text(
                                        'TBA',
                                        style: TextStyle(
                                          color: white,
                                          fontSize: 14,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: 150,
                            height: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                color: black54),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      myList[index].Title.toString().length > 28
                                          ? myList[index]
                                                  .Title
                                                  .toString()
                                                  .substring(0, 28) +
                                              '...'
                                          : myList[index].Title.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 15),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyBG,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Column(
                  children: [
                    Container(
                      height: 310,
                      child: Stack(
                        children: [
                          BackPosters.length >= 3
                              ? PosterSlider()
                              : BackPosters.length == 0
                                  ? SizedBox()
                                  : Image(
                                      image: NetworkImage(BackPosters[0].Link)),
                          Positioned(
                              top: 5,
                              left: 5,
                              child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white70,
                                ),
                              )),
                          Positioned(
                            top: 130,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 115,
                                    height: 165,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(info.Image),
                                            fit: BoxFit.fill)),
                                  ),
                                  Container(
                                    width: 253,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 8),
                                          child: Container(
                                            padding: EdgeInsets.all(9.5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: .3,
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Text(
                                              info.Genres,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: 8, top: 5),
                                          child: Row(
                                            children: [
                                              info.RunTimeStr != 'null'
                                                  ? Text(
                                                      info.RunTimeStr,
                                                      style: TextStyle(
                                                          color: Colors.white54,
                                                          fontSize: 15),
                                                    )
                                                  : SizedBox(),
                                              info.RunTimeStr != 'null'
                                                  ? Expanded(child: SizedBox())
                                                  : SizedBox(),
                                              info.ContentRating != 'null'
                                                  ? Text(
                                                      'Rated : ' +
                                                          info.ContentRating,
                                                      style: TextStyle(
                                                          color: Colors.white54,
                                                          fontSize: 15),
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            show.Title,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Release Date :  ' + info.ReleaseDate,
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 15),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: yellow,
                                    size: 24,
                                  ),
                                  show.IMDbRating.toString().isNotEmpty
                                      ? Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            show.IMDbRating,
                                            style: TextStyle(
                                                color: Colors.white60,
                                                fontSize: 20),
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            "TBA",
                                            style: TextStyle(
                                                color: Colors.white60,
                                                fontSize: 20),
                                          ),
                                        ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    print(show.isFav);
                                    if (show.isFav == false) {
                                      setState(() {
                                        Provider.of<TopShows>(context,
                                                listen: false)
                                            .isFav = true;
                                        Provider.of<TopShows>(context,
                                                listen: false)
                                            .updateFav(show, true);
                                        Get.snackbar('Added To Favourites', '',
                                            duration:
                                                Duration(milliseconds: 1000));
                                      });
                                    } else {
                                      setState(() {
                                        Provider.of<TopShows>(context,
                                                listen: false)
                                            .isFav = false;
                                        Provider.of<TopShows>(context,
                                                listen: false)
                                            .updateFav(show, false);
                                        Get.snackbar(
                                            'Removed from Favourites', '',
                                            duration:
                                                Duration(milliseconds: 1000));
                                      });
                                    }
                                  },
                                  child: Text(!show.isFav
                                      ? 'Add to Favorites'
                                      : 'Remove from Favorites'),
                                  style: ElevatedButton.styleFrom(
                                      primary: deepPurple),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: Colors.white24,
                            endIndent: 35,
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            info.Plot,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: Colors.white24,
                            endIndent: 35,
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Directors : ' + info.Directors,
                            style:
                                TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Produced By : ' + info.Companies,
                            style:
                                TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: Colors.white24,
                            endIndent: 35,
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Similar Shows',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ShowsSliderWidget(info.SimilarsList!),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
