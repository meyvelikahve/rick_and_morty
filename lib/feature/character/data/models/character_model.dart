// To parse this JSON data, do
//
//     final CharacterModel = CharacterModelFromJson(jsonString);

import 'dart:convert';

CharacterModel characterModelFromJson(String str) =>
    CharacterModel.fromJson(json.decode(str));

class CharacterModel {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  // origin and location responses is same, we uses the same model
  CharacterLocation? origin;
  CharacterLocation? location;
  String? image;
  List<String>? episode;
  String? url;
  DateTime? created;

  CharacterModel({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        species: json["species"],
        type: json["type"],
        gender: json["gender"],
        origin: json["origin"] == null
            ? null
            : CharacterLocation.fromJson(json["origin"]),
        location: json["location"] == null
            ? null
            : CharacterLocation.fromJson(json["location"]),
        image: json["image"],
        episode: json["episode"] == null
            ? []
            : List<String>.from(json["episode"]!.map((x) => x)),
        url: json["url"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
      );
}

class CharacterLocation {
  String? name;
  String? url;

  CharacterLocation({
    this.name,
    this.url,
  });

  factory CharacterLocation.fromJson(Map<String, dynamic> json) =>
      CharacterLocation(
        name: json["name"],
        url: json["url"],
      );
}
