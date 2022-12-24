import 'dart:convert';
import 'dart:developer';
import 'package:movies_app/Helpers/Requests/API.dart';
import 'package:movies_app/Helpers/Requests/HTTP.dart';

class Poster {
  final String Id;
  final String Link;

  Poster({
    required this.Id,
    required this.Link,
  });

  factory Poster.fromJson(Map<String, dynamic> json) {
    return Poster(
      Id: json['id'].toString(),
      Link: json['link'].toString(),
    );
  }

  static Future<List<Poster>> getPoster(String showID) async {
    List<Poster> list = [];
    var res = await HTTP.get(API.Posters, showID);
    log(res.statusCode.toString());
    if (res.statusCode == 200) {
      Map data = json.decode(utf8.decode(res.bodyBytes));

      list =
          (data['backdrops'] as List).map((e) => Poster.fromJson(e)).toList();
    }
    return list;
  }
}
