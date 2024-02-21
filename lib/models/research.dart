// To parse this JSON data, do
//
//     final zakatexplore = zakatexploreFromJson(jsonString);

import 'dart:convert';

Zakatresearch zakatexploreFromJson(String str) =>
    Zakatresearch.fromJson(json.decode(str));

String zakatexploreToJson(Zakatresearch data) => json.encode(data.toJson());

class Zakatresearch {
  String id;
  String img_src;
  String title;
  String description;

  Zakatresearch({
    required this.id,
    required this.img_src,
    required this.title,
    required this.description,
  });

  factory Zakatresearch.fromJson(Map<String, dynamic> json) => Zakatresearch(
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
