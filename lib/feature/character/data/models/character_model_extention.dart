import 'package:rick_morty_api/feature/character/data/models/character_model.dart';
import 'package:rick_morty_api/feature/character/domain/entities/character_entity.dart';

extension CharacterModelExtention on CharacterDto {
  CharacterEntity toCharacterEntity() {
    return CharacterEntity(
        id: id,
        name: name,
        status: status,
        species: species,
        type: type,
        gender: gender,
        origin: origin!.toLocationEntity(),
        location: location!.toLocationEntity(),
        image: image,
        episode: episode,
        url: url,
        created: created);
  }
}

extension CharacterLocationExtention on CharacterLocation {
  LocationEntity toLocationEntity() {
    return LocationEntity(url: url, name: name);
  }
}
