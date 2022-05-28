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
}
