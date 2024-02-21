// To parse this JSON data, do
//
//     final zakatexplore = zakatexploreFromJson(jsonString);

import 'dart:convert';

ZakatSurveys zakatexploreFromJson(String str) =>
    ZakatSurveys.fromJson(json.decode(str));

String zakatexploreToJson(ZakatSurveys data) => json.encode(data.toJson());

class ZakatSurveys {
  String id;
  String img_src;
  String title;
  String description;

  ZakatSurveys({
    required this.id,
    required this.img_src,
    required this.title,
    required this.description,
  });

  factory ZakatSurveys.fromJson(Map<String, dynamic> json) => ZakatSurveys(
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
