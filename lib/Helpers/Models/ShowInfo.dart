class Similars {
  late String Id;
  late String Title;
  late String Image;
  late String IMDbRating;

  Similars({
    required this.Id,
    required this.Title,
    required this.Image,
    required this.IMDbRating,
  });

  factory Similars.fromJson(Map<String, dynamic> json) {
    return Similars(
      Id: json['id'].toString(),
      Title: json['title'].toString(),
      Image: json['image'].toString(),
      IMDbRating: json['imDbRating'].toString(),
    );
  }
}

class ShowInfo {
  late String Id;
  late String FullTitle;
  late String Image;
  late String ReleaseDate;
  late String RunTimeMins;
  late String RunTimeStr;
  late String Title;
  late String Plot;
  late String Directors;
  late String Genres;
  late String Companies;
  late String ContentRating;
  late String Tagline;
  late List<Similars>? SimilarsList;

  ShowInfo({
    required this.Id,
    required this.FullTitle,
    required this.Image,
    required this.ReleaseDate,
    required this.RunTimeMins,
    required this.RunTimeStr,
    required this.Title,
    required this.Plot,
    required this.Directors,
    required this.Genres,
    required this.Companies,
    required this.ContentRating,
    required this.Tagline,
    this.SimilarsList,
  });

  factory ShowInfo.fromJson(Map<String, dynamic> json) {
    return ShowInfo(
      Id: json['id'].toString(),
      FullTitle: json['fullTitle'].toString(),
      Image: json['image'].toString(),
      ReleaseDate: json['releaseDate'].toString(),
      RunTimeMins: json['runtimeMins'].toString(),
      RunTimeStr: json['runtimeStr'].toString(),
      Title: json['title'].toString(),
      Plot: json['plot'].toString(),
      Directors: json['directors'].toString(),
      Genres: json['genres'].toString(),
      Companies: json['companies'].toString(),
      ContentRating: json['contentRating'].toString(),
      Tagline: json['tagline'].toString(),
    );
  }
}
