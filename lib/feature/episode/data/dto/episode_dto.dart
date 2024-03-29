class EpisodeDto {
  int id;
  String name;
  String airDate;
  String episode;
  List<String> characters;
  String url;
  DateTime created;

  EpisodeDto({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  factory EpisodeDto.fromJson(Map<String, dynamic> json) => EpisodeDto(
        id: json["id"],
        name: json["name"],
        airDate: json["air_date"],
        episode: json["episode"],
        characters: List<String>.from(json["characters"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
      );
}
