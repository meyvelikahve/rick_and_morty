import 'dart:convert';

class CharacterResponse {
  Info info;
  List<CharacterResult> results;

  CharacterResponse({
    required this.info,
    required this.results,
  });

  factory CharacterResponse.fromRawJson(String str) =>
      CharacterResponse.fromJson(json.decode(str));

  factory CharacterResponse.fromJson(Map<String, dynamic> json) =>
      CharacterResponse(
        info: Info.fromJson(json["info"]),
        results: List<CharacterResult>.from(
            json["results"].map((x) => CharacterResult.fromJson(x))),
      );
}

class Info {
  int count;
  int pages;
  String next;
  dynamic prev;

  Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory Info.fromRawJson(String str) => Info.fromJson(json.decode(str));

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );
}

class CharacterResult {
  int id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  CharacterLocation origin;
  CharacterLocation location;
  String image;
  List<String> episode;
  String url;
  DateTime created;

  CharacterResult({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory CharacterResult.fromRawJson(String str) =>
      CharacterResult.fromJson(json.decode(str));

  factory CharacterResult.fromJson(Map<String, dynamic> json) =>
      CharacterResult(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        species: json["species"],
        type: json["type"],
        gender: json["gender"],
        origin: CharacterLocation.fromJson(json["origin"]),
        location: CharacterLocation.fromJson(json["location"]),
        image: json["image"],
        episode: List<String>.from(json["episode"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
      );
}

class CharacterLocation {
  String name;
  String url;

  CharacterLocation({
    required this.name,
    required this.url,
  });

  factory CharacterLocation.fromRawJson(String str) =>
      CharacterLocation.fromJson(json.decode(str));

  factory CharacterLocation.fromJson(Map<String, dynamic> json) =>
      CharacterLocation(
        name: json["name"],
        url: json["url"],
      );
}
