class CharacterEntity {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  LocationEntity? origin;
  LocationEntity? location;
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

class LocationEntity {
  String? name;
  String? url;

  LocationEntity({this.name, this.url});
}
