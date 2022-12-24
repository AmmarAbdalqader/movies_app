import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/Components/LoadingWidget.dart';
import 'package:movies_app/Controllers/DetailsCon.dart';
import 'package:movies_app/Controllers/FavoritesCon.dart';
import 'package:movies_app/Helpers/Constants/myColors.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var show = Get.arguments;

  Widget PosterSlider(detailsProv) {
    return ImageSlideshow(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.26,
      initialPage: 0,
      indicatorColor: Colors.deepPurple,
      indicatorBackgroundColor: Colors.grey,
      children: [
        Image(image: NetworkImage(detailsProv.getBackPostersList[0].Link)),
        Image(image: NetworkImage(detailsProv.getBackPostersList[1].Link)),
        Image(image: NetworkImage(detailsProv.getBackPostersList[2].Link)),
        if (detailsProv.getBackPostersList.length > 4)
          Image(image: NetworkImage(detailsProv.getBackPostersList[3].Link)),
        if (detailsProv.getBackPostersList.length > 6)
          Image(image: NetworkImage(detailsProv.getBackPostersList[5].Link)),
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
                return Container(
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
                                      style: GoogleFonts.jockeyOne(
                                        color: white,
                                        fontSize: 14,
                                      ),
                                    )
                                  : Text(
                                      'TBA',
                                      style: GoogleFonts.jockeyOne(
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
                                    style: GoogleFonts.jockeyOne(
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
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 15),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailsCon>(
      create: (context) => DetailsCon(context, show.Id),
      builder: (context, child) {
        var detailsProv = Provider.of<DetailsCon>(context);
        var favProv = Provider.of<FavoritesProv>(context);
        return Scaffold(
          backgroundColor: greyBG,
          body: detailsProv.getLoading
              ? Center(child: LoadingWidget())
              : ListView(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 310,
                          child: Stack(
                            children: [
                              detailsProv.getBackPostersLength >= 3
                                  ? PosterSlider(detailsProv)
                                  : detailsProv.getBackPostersLength == 0
                                      ? SizedBox()
                                      : Image(
                                          image: NetworkImage(detailsProv
                                              .getBackPostersList[0].Link),
                                        ),
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
                                ),
                              ),
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
                                              image: NetworkImage(
                                                  detailsProv.getInfo!.Image),
                                              fit: BoxFit.fill),
                                        ),
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
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Text(
                                                  detailsProv.getInfo!.Genres,
                                                  style: GoogleFonts.jockeyOne(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 8,
                                                top: 5,
                                              ),
                                              child: Row(
                                                children: [
                                                  detailsProv.getInfo!
                                                              .RunTimeStr !=
                                                          'null'
                                                      ? Text(
                                                          detailsProv.getInfo!
                                                              .RunTimeStr,
                                                          style: GoogleFonts
                                                              .jockeyOne(
                                                                  color: Colors
                                                                      .white54,
                                                                  fontSize: 15),
                                                        )
                                                      : SizedBox(),
                                                  detailsProv.getInfo!
                                                              .RunTimeStr !=
                                                          'null'
                                                      ? Expanded(
                                                          child: SizedBox(),
                                                        )
                                                      : SizedBox(),
                                                  detailsProv.getInfo!
                                                              .ContentRating !=
                                                          'null'
                                                      ? Text(
                                                          'Rated : ' +
                                                              detailsProv
                                                                  .getInfo!
                                                                  .ContentRating,
                                                          style: GoogleFonts
                                                              .jockeyOne(
                                                                  color: Colors
                                                                      .white54,
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
                                style: GoogleFonts.jockeyOne(
                                    color: Colors.white, fontSize: 25),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Release Date :  ' +
                                        detailsProv.getInfo!.ReleaseDate,
                                    style: GoogleFonts.jockeyOne(
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
                                                style: GoogleFonts.jockeyOne(
                                                    color: Colors.white60,
                                                    fontSize: 20),
                                              ),
                                            )
                                          : Padding(
                                              padding: EdgeInsets.only(left: 5),
                                              child: Text(
                                                "TBA",
                                                style: GoogleFonts.jockeyOne(
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
                                        favProv.checkFav(show);
                                      },
                                      child: Text(favProv.isFav(show)
                                          ? 'Remove from Favorites'
                                          : 'Add to Favorites'),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: deepPurple),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                detailsProv.getInfo!.Plot,
                                style: GoogleFonts.jockeyOne(
                                    color: Colors.white, fontSize: 15),
                              ),
                              Divider(
                                color: Colors.white24,
                                indent: 20,
                                endIndent: 20,
                                thickness: 1.1,
                                height: 50,
                              ),
                              Text(
                                'Directors : ' + detailsProv.getInfo!.Directors,
                                style: GoogleFonts.jockeyOne(
                                    color: Colors.white70, fontSize: 14),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Produced By : ' +
                                    detailsProv.getInfo!.Companies,
                                style: GoogleFonts.jockeyOne(
                                    color: Colors.white70, fontSize: 13),
                              ),
                              Divider(
                                color: Colors.white24,
                                thickness: 1,
                                height: 50,
                              ),
                              Text(
                                'Similar Shows',
                                style: GoogleFonts.jockeyOne(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ShowsSliderWidget(
                                  detailsProv.getInfo!.SimilarsList!),
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
      },
    );
  }
}
