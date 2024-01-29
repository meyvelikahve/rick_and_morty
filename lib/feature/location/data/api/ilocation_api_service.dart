import 'package:rick_morty_api/feature/location/data/dto/location_dto.dart';

abstract class ILocationApiService {
  Future<List<LocationDto>> getAllLocations();
}
