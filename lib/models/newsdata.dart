import 'dart:convert';

Zakatnews zakatnewsFromJson(String str) => Zakatnews.fromJson(json.decode(str));

String zakatnewsToJson(Zakatnews data) => json.encode(data.toJson());

class Zakatnews {
  String id;
  String img_src;
  String description;
  String title;

  Zakatnews({
    required this.id,
    required this.description,
    required this.img_src,
    required this.title,
  });

  factory Zakatnews.fromJson(Map<String, dynamic> json) => Zakatnews(
        id: json["id"],
        description: json["description"],
        img_src: json["img_src"],
        title: json['title'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "img_src": img_src,
        "title": title
      };
}
