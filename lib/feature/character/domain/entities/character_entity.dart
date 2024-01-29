class CharacterEntity {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  CharacterLocationEntity? origin;
  CharacterLocationEntity? location;
  String? image;
  List<String>? episode;
  String? url;
  DateTime? created;

  CharacterEntity({
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
}

class CharacterLocationEntity {
  String? name;
  String? url;

  CharacterLocationEntity({this.name, this.url});
}
