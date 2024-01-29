import 'package:rick_morty_api/feature/location/data/dto/location_dto.dart';
import 'package:rick_morty_api/feature/location/domain/entities/location_entity.dart';

extension LocationDtoExtention on LocationDto {
  LocationEntity toLocationEntity() {
    return LocationEntity(
        id: id,
        name: name,
        type: type,
        dimension: dimension,
        residents: residents,
        url: url,
        created: created);
  }
}
