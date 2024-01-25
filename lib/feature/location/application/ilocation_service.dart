import 'package:rick_morty_api/feature/location/domain/entities/location_model.dart';

abstract class ILocationService {
  Future<List<Location>> getLocationList();
}
