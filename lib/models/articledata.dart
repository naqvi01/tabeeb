import 'dart:convert';

Zakatarticle zakatarticleFromJson(String str) =>
    Zakatarticle.fromJson(json.decode(str));

String zakatarticleToJson(Zakatarticle data) => json.encode(data.toJson());

class Zakatarticle {
  String id;
  String img_src;
  String description;
  String title;

  Zakatarticle({
    required this.id,
    required this.description,
    required this.img_src,
    required this.title,
  });

  factory Zakatarticle.fromJson(Map<String, dynamic> json) => Zakatarticle(
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
