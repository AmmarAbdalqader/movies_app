import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/Components/AppBar.dart';
import 'package:movies_app/Helpers/Models/TrendingShows.dart';
import 'package:movies_app/Helpers/myColors.dart';
import 'package:movies_app/Helpers/Models/TopShows.dart';
import 'package:get/get.dart';
import 'package:movies_app/Screens/Details/index.dart';
import 'package:movies_app/Screens/More/index.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _api_key = "k_34u2yim3";
  static const String seeAll = 'See All';

  List<TopShows> top250Movies = [];
  List<TopShows> top250Series = [];

  List<TrendingShows> trendingMovies = [];
  List<TrendingShows> trendingSeries = [];

  bool isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    await getTop250Movies();
    await getTop250Series();
    await getTrendingMovies();
    await getTrendingSeries();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getTop250Movies() async {
    String url = "https://imdb-api.com/en/API/Top250Movies/$_api_key";

    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    setState(() {
      Map data = json.decode(utf8.decode(response.bodyBytes));

      top250Movies =
          (data['items'] as List).map((e) => TopShows.fromJson(e)).toList();
    });
  }

  Future<void> getTop250Series() async {
    String url = "https://imdb-api.com/en/API/Top250TVs/$_api_key";

    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    setState(() {
      Map data = json.decode(utf8.decode(response.bodyBytes));

      top250Series =
          (data['items'] as List).map((e) => TopShows.fromJson(e)).toList();
    });
  }

  Future<void> getTrendingMovies() async {
    String url = "https://imdb-api.com/en/API/MostPopularMovies/$_api_key";

    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    setState(() {
      Map data = json.decode(utf8.decode(response.bodyBytes));

      trendingMovies = (data['items'] as List)
          .map((e) => TrendingShows.fromJson(e))
          .toList();
    });
  }

  Future<void> getTrendingSeries() async {
    String url = "https://imdb-api.com/en/API/MostPopularTVs/$_api_key";

    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    setState(() {
      Map data = json.decode(utf8.decode(response.bodyBytes));

      trendingSeries = (data['items'] as List)
          .map((e) => TrendingShows.fromJson(e))
          .toList();
    });
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
                    Get.to(() => Details(),
                        arguments: myList[index],
                        duration: Duration(milliseconds: 700),
                        transition: Transition.leftToRightWithFade);
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
                                Text(
                                  myList[index].IMDbRating,
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
                                              '... (${myList[index].Year})'
                                          : myList[index].Title.toString() +
                                              ' (${myList[index].Year})',
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
      appBar: myAppbar,
      backgroundColor: grey,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: ListView(
                children: [
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Movies',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => More(),
                              arguments: top250Movies,
                              duration: Duration(milliseconds: 700),
                              transition: Transition.leftToRightWithFade);
                        },
                        child: Text(seeAll),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  ShowsSliderWidget(top250Movies),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Series',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => More(),
                              arguments: top250Series,
                              duration: Duration(milliseconds: 700),
                              transition: Transition.leftToRightWithFade);
                        },
                        child: Text(seeAll),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  ShowsSliderWidget(top250Series),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Movies',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => More(),
                              arguments: trendingMovies,
                              duration: Duration(milliseconds: 700),
                              transition: Transition.leftToRightWithFade);
                        },
                        child: Text(seeAll),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  ShowsSliderWidget(trendingMovies),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Series',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => More(),
                              arguments: trendingSeries,
                              duration: Duration(milliseconds: 700),
                              transition: Transition.leftToRightWithFade);
                        },
                        child: Text(seeAll),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  ShowsSliderWidget(trendingSeries),
                  SizedBox(height: 5),
                ],
              ),
            ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
