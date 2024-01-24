import 'package:rick_morty_api/feature/location/data/dto/location_response.dart';

abstract class ILocationRepository {
  Future<LocationResponse> getLocationResponse();
}
