class EpisodeResponse {
  Info info;
  List<EpisodeResult> results;

  EpisodeResponse({
    required this.info,
    required this.results,
  });

  factory EpisodeResponse.fromJson(Map<String, dynamic> json) =>
      EpisodeResponse(
        info: Info.fromJson(json["info"]),
        results: List<EpisodeResult>.from(
            json["results"].map((x) => EpisodeResult.fromJson(x))),
      );
}

class Info {
  int count;
  int pages;
  String? next;
  String? prev;

  Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );
}

class EpisodeResult {
  int id;
  String name;
  String airDate;
  String episode;
  List<String> characters;
  String url;
  DateTime created;

  EpisodeResult({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  factory EpisodeResult.fromJson(Map<String, dynamic> json) => EpisodeResult(
        id: json["id"],
        name: json["name"],
        airDate: json["air_date"],
        episode: json["episode"],
        characters: List<String>.from(json["characters"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
      );
}
