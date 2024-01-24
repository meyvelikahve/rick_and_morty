import 'package:rick_morty_api/feature/location/domain/model/location_model.dart';

abstract class ILocationService {
  Future<List<Location>> getLocationList();
}
