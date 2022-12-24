import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:movies_app/Helpers/Requests/HTTP.dart';

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

  TopShows(
      {required this.Id,
      required this.FullTitle,
      required this.Image,
      required this.IMDbRating,
      required this.Rank,
      required this.Title,
      required this.Year,
      required this.Crew,
      required this.IMDbRatingCount});

  factory TopShows.fromJson(Map<String, dynamic> json) => TopShows(
        Id: json["id"],
        FullTitle: json["fullTitle"],
        Image: json["image"],
        IMDbRating: json["imDbRating"],
        Rank: json["rank"],
        Title: json["title"],
        Year: json["year"],
        Crew: json["crew"],
        IMDbRatingCount: json["imDbRatingCount"],
      );

  static Future<List<TopShows>> getData(context, String apiTarget) async {
    List<TopShows> list = [];
    var res = await HTTP.get(apiTarget, "");
    log(res.statusCode.toString());
    if (res.statusCode == 200) {
      Map data = json.decode(utf8.decode(res.bodyBytes));

      list = (data['items'] as List).map((e) => TopShows.fromJson(e)).toList();
    }
    return list;
  }
}
