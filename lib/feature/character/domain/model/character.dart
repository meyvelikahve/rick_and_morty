import 'package:rick_morty_api/feature/character/data/dto/character_response.dart';

class Character {
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

  Character({
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
}
