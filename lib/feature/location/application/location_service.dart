import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/location/application/ilocation_service.dart';
import 'package:rick_morty_api/feature/location/data/dto/location_response.dart';
import 'package:rick_morty_api/feature/location/data/repository/ilocation_respository.dart';
import 'package:rick_morty_api/feature/location/data/repository/location_repository.dart';
import 'package:rick_morty_api/feature/location/domain/entities/location_model.dart';

final locationServiceProvider = Provider<ILocationService>((ref) {
  var locationRepository = ref.watch(locationRepositoryProvider);
  return LocationService(locationRepository);
});

class LocationService implements ILocationService {
  ILocationRepository locationRepository;

  LocationService(this.locationRepository);

  @override
  Future<List<Location>> getLocationList() async {
    LocationResponse locationResponse =
        await locationRepository.getLocationResponse();
    List<Location> locationList = responseToModel(locationResponse);

    return locationList;
  }

  List<Location> responseToModel(LocationResponse locationResponse) {
    List<Location> locationList = [];

    var results = locationResponse.results;

    for (var result in results) {
      locationList.add(
        Location(
            id: result.id,
            name: result.name,
            type: result.type,
            dimension: result.dimension,
            residents: result.residents,
            url: result.url,
            created: result.created),
      );
    }

    return locationList;
  }
}
