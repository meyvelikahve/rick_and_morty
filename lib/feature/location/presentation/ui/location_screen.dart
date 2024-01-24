import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/location/application/location_service.dart';
import 'package:rick_morty_api/feature/location/domain/model/location_model.dart';
import 'package:rick_morty_api/utils/api_future_builder.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var locationService = ref.watch(locationServiceProvider);
    return GeneralFutureBuilder(
      future: locationService.getLocationList(),
      builder: (context, data) {
        return myListView(data);
      },
    );
  }

  Widget myListView(List<Location> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(data[index].name),
        );
      },
    );
  }
}
