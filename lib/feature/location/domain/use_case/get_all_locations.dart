import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/core/use_case/use_case.dart';
import 'package:rick_morty_api/feature/location/data/repository/location_repository_impl.dart';
import 'package:rick_morty_api/feature/location/domain/entities/location_entity.dart';
import 'package:rick_morty_api/feature/location/domain/repository/location_repository.dart';

final getAllLocationProvider = Provider<GetAllLocations>((ref) {
  LocationRepository _locationRepository =
      ref.watch(locationRepositoryProvider);
  return GetAllLocations(_locationRepository);
});

class GetAllLocations extends UseCase<List<LocationEntity>, int> {
  final LocationRepository _locationRepository;
  GetAllLocations(this._locationRepository);
  @override
  Future<List<LocationEntity>?> call({int? params}) async {
    List<LocationEntity> locations =
        await _locationRepository.getAllLocations(page: params);
    return locations;
  }
}
