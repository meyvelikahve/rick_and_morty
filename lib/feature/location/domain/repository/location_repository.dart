import 'package:rick_morty_api/feature/location/domain/entities/location_entity.dart';

abstract class LocationRepository {
  Future<List<LocationEntity>> getAllLocations({int? page});
}
