class CharacterEntity {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  //! fix this than
  OriginEntity? origin;
  LocationEntity? location;
  String? image;
  List<String>? episode;
  String? url;
  String? created;

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

class OriginEntity {
  String? name;
  String? url;

  OriginEntity({this.name, this.url});
}
