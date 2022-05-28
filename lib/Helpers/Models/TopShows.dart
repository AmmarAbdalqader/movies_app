class TopShows {
  final String Id;
  final String FullTitle;
  final String Image;
  final String IMDbRating;
  final String Rank;
  final String Title;
  final String Year;
  final String Crew;
  final String IMDbRatingCount;

  TopShows({
    required this.Id,
    required this.FullTitle,
    required this.Image,
    required this.IMDbRating,
    required this.Rank,
    required this.Title,
    required this.Year,
    required this.Crew,
    required this.IMDbRatingCount,
  });

  factory TopShows.fromJson(Map<String, dynamic> json) {
    return TopShows(
      Id: json['id'].toString(),
      FullTitle: json['fullTitle'].toString(),
      Image: json['image'].toString(),
      IMDbRating: json['imDbRating'].toString(),
      Rank: json['rank'].toString(),
      Title: json['title'].toString(),
      Year: json['year'].toString(),
      Crew: json['crew'].toString(),
      IMDbRatingCount: json['imDbRatingCount'].toString(),
    );
  }
}
