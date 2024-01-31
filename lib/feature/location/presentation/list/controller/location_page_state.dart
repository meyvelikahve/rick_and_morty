import 'package:equatable/equatable.dart';
import 'package:rick_morty_api/feature/location/domain/entities/location_entity.dart';

enum LocationPageStatus { initial, loading, success, failure }

class LocationPageState extends Equatable {
  const LocationPageState({
    this.status = LocationPageStatus.initial,
    this.locations = const [],
    this.hasReachedEnd = false,
    this.currentPage = 1,
  });

  final LocationPageStatus status;
  final List<LocationEntity> locations;
  final bool hasReachedEnd;
  final int currentPage;

  LocationPageState copyWith({
    LocationPageStatus? status,
    List<LocationEntity>? locations,
    bool? hasReachedEnd,
    int? currentPage,
  }) {
    return LocationPageState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [
        status,
        locations,
        hasReachedEnd,
        currentPage,
      ];
}
