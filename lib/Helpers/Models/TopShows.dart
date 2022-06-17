import 'package:flutter/material.dart';

List<TopShows> myFav = [];

class TopShows extends ChangeNotifier {
  final String? Id;
  final String? FullTitle;
  final String? Image;
  final String? IMDbRating;
  final String? Rank;
  final String? Title;
  final String? Year;
  final String? Crew;
  final String? IMDbRatingCount;
  bool isFav;

  TopShows(
      [this.Id,
      this.FullTitle,
      this.Image,
      this.IMDbRating,
      this.Rank,
      this.Title,
      this.Year,
      this.Crew,
      this.IMDbRatingCount,
      this.isFav = false]);

  factory TopShows.fromJson(Map<String, dynamic> json) {
    return TopShows(
      json['id'].toString(),
      json['fullTitle'].toString(),
      json['image'].toString(),
      json['imDbRating'].toString(),
      json['rank'].toString(),
      json['title'].toString(),
      json['year'].toString(),
      json['crew'].toString(),
      json['imDbRatingCount'].toString(),
    );
  }

  void addFav(TopShows show) {
    isFav = !isFav;
    myFav.add(show);
  }

  void removeFav(TopShows show) {
    isFav = !isFav;
    myFav.remove(show);
  }

  void updateFav(TopShows show, bool addRemove) {
    if (addRemove) {
      // true // add
      show.addFav(show);
    } else {
      // false // remove
      show.removeFav(show);
    }
    notifyListeners();
  }
}
