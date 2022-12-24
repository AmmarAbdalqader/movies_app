import 'package:flutter/material.dart';
import 'package:movies_app/Models/Poster.dart';
import 'package:movies_app/Models/ShowInfo.dart';

class DetailsCon extends ChangeNotifier {
  DetailsCon(context, String showID) {
    getAllInfo(showID);
  }

  List<Poster> BackPosters = [];
  ShowInfo? Info = null;
  bool isLoading = false;

  Future getAllInfo(String showID) async {
    Loading();
    Info = await ShowInfo.getInfo(showID);
    notifyListeners();
    getBackPosters(showID);
  }

  Future getBackPosters(String showID) async {
    BackPosters = await Poster.getPoster(showID);
    Loading();
    notifyListeners();
  }

  void Loading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  bool get getLoading => isLoading;
  ShowInfo? get getInfo => Info!;
  List<Poster> get getBackPostersList => BackPosters;
  int get getBackPostersLength => BackPosters.length;
}
