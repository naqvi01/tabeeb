// To parse this JSON data, do
//
//     final zakatexplore = zakatexploreFromJson(jsonString);

import 'dart:convert';

Zakatexplore zakatexploreFromJson(String str) =>
    Zakatexplore.fromJson(json.decode(str));

String zakatexploreToJson(Zakatexplore data) => json.encode(data.toJson());

class Zakatexplore {
  String id;
  String img_src;
  String title;
  String description;

  Zakatexplore({
    required this.id,
    required this.img_src,
    required this.title,
    required this.description,
  });

  factory Zakatexplore.fromJson(Map<String, dynamic> json) => Zakatexplore(
        id: json["id"],
        img_src: json["img_src"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "img_src": img_src,
        "title": title,
        "description": description,
      };
}
