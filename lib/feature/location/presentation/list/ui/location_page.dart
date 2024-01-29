import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_api/app/navigation/app_navigation.dart';
import 'package:rick_morty_api/feature/location/domain/entities/location_entity.dart';
import 'package:rick_morty_api/feature/location/presentation/detail/state/location_detail_page_notifier.dart';
import 'package:rick_morty_api/feature/location/presentation/list/state/location_page_notifier.dart';
import 'package:rick_morty_api/feature/location/presentation/list/state/location_page_state.dart';
import 'package:rick_morty_api/feature/location/presentation/list/ui/widget/location_list_item.dart';

class LocationPage extends ConsumerStatefulWidget {
  const LocationPage({super.key});

  @override
  ConsumerState<LocationPage> createState() => _EpisodePageState();
}

class _EpisodePageState extends ConsumerState<LocationPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(locationPageStateProvider.notifier).fetchNextPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(
      locationPageStateProvider.select((p) => p.status),
    );

    return status == LocationPageStatus.initial
        ? const Center(child: CircularProgressIndicator())
        : const _Content();
  }
}

class _Content extends ConsumerStatefulWidget {
  const _Content({
    super.key,
  });

  @override
  ConsumerState<_Content> createState() => __ContentState();
}

class __ContentState extends ConsumerState<_Content> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final state = ref.watch(locationPageStateProvider);
          final list = state.locations;
          final hasEnded = state.hasReachedEnd;

          return ListView.builder(
            key: const ValueKey('location_page_list_key'),
            controller: _scrollController,
            itemCount: hasEnded ? list.length : list.length + 1,
            itemBuilder: (context, index) {
              if (index >= list.length) {
                return !hasEnded
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const SizedBox();
              }
              final item = list[index];
              return LocationListItem(
                item: item,
                onTap: (entity) {
                  _goToDetailsPage(context, ref, entity);
                },
              );
            },
          );
        },
      ),
    );
  }

  void _goToDetailsPage(
      BuildContext context, WidgetRef ref, LocationEntity location) {
    ref.read(locationDetailPageProvider.notifier).setLocation(location);
    context.pushNamed(
      RoutePathEnum.locationDetail.path,
      pathParameters: {'id': location.id.toString()},
    );
  }

  @override
  void dispose() {
    _scrollController
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
    if (!_scrollController.hasClients) return false;
    return _scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange;
  }
}
