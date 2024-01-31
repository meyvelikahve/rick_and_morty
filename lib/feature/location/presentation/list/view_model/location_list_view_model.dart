import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_api/app/navigation/app_navigation.dart';
import 'package:rick_morty_api/feature/location/domain/entities/location_entity.dart';
import 'package:rick_morty_api/feature/location/presentation/list/controller/location_page_controller.dart';
import 'package:rick_morty_api/feature/location/presentation/list/view/location_page.dart';

abstract class LocaitonListViewModel extends ConsumerState<LocationListView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  void goToDetailsPage(
      BuildContext context, WidgetRef ref, LocationEntity location) {
    context.pushNamed(RoutePathEnum.locationDetail.path,
        pathParameters: {'locationId': location.id.toString()},
        extra: location);
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      ref.read(locationPageStateProvider.notifier).fetchNextPage();
    }
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    return scrollController.offset >=
            scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange;
  }
}
