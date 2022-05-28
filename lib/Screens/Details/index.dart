import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/Components/AppBar.dart';
import 'package:movies_app/Helpers/Models/Poster.dart';
import 'package:movies_app/Helpers/myColors.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String _api_key = "k_34u2yim3";

  var show = Get.arguments; // Object

  List<Poster> BackPosters = [];

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
  }

  Future<void> getBackPosters() async {
    String url = "https://imdb-api.com/en/API/Posters/$_api_key/${show.Id}";

    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    setState(() {
      Map data = json.decode(utf8.decode(response.bodyBytes));

      BackPosters =
          (data['backdrops'] as List).map((e) => Poster.fromJson(e)).toList();
      print(BackPosters.length);

      setState(() {
        isLoading = false;
      });
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
      ],
      autoPlayInterval: 3000,
      isLoop: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(58),
        child: NamedAppBar(show.Title),
      ),
      backgroundColor: Colors.grey[900],
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Container(
                  height: 555,
                  child: Stack(
                    children: [
                      BackPosters.length >= 3
                          ? PosterSlider()
                          : Image(image: NetworkImage(BackPosters[0].Link)),
                      Positioned(
                        top: 200,
                        left: 15,
                        child: Container(
                          width: 140,
                          height: 190,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(show.Image),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                      Positioned(
                        top: 250,
                        right: 50,
                        child: Container(
                          child: Text(
                            show.Title,
                            style: TextStyle(color: Colors.white, fontSize: 28),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
