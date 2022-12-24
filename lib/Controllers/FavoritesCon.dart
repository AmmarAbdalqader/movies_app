import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/Models/TopShows.dart';

class FavoritesProv extends ChangeNotifier {
  List<TopShows> favoritesList = [];

  void addFav(TopShows show) {
    favoritesList.add(show);
    Get.snackbar('Added to Favourites', '');
    notifyListeners();
  }

  void removeFav(TopShows show) {
    favoritesList.removeWhere((element) => element.Id == show.Id);
    Get.snackbar('Removed from Favourites', '');
    notifyListeners();
  }

  void checkFav(TopShows show) {
    if (!getFavList.contains(show)) {
      addFav(show);
    } else {
      removeFav(show);
    }
    notifyListeners();
  }

  bool isFav(TopShows show) {
    return getFavList.contains(show);
  }

  List<TopShows> get getFavList => favoritesList;

  int get getFavListLength => favoritesList.length;
}
