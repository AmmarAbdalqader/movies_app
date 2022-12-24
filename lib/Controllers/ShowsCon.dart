import 'package:flutter/material.dart';
import 'package:movies_app/Helpers/Constants/MyLists.dart';
import 'package:movies_app/Helpers/Requests/API.dart';
import 'package:movies_app/Models/TopShows.dart';

class ShowsCon extends ChangeNotifier {
  bool isLoading = false;

  ShowsCon(context) {
    getData(context);
  }

  Future getData(context) async {
    Loading();
    top250Movies = await TopShows.getData(context, API.Top250Movies);
    top250Series = await TopShows.getData(context, API.Top250TVs);
    trendingMovies = await TopShows.getData(context, API.MostPopularMovies);
    trendingSeries = await TopShows.getData(context, API.MostPopularTVs);
    Loading();
    notifyListeners();
  }

  void Loading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  bool get getLoading => isLoading;
}
