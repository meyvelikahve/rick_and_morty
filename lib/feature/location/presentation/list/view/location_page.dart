import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/location/presentation/list/controller/location_page_controller.dart';
import 'package:rick_morty_api/feature/location/presentation/list/controller/location_page_state.dart';
import 'package:rick_morty_api/feature/location/presentation/list/view/widget/location_list_item.dart';
import 'package:rick_morty_api/feature/location/presentation/list/view_model/location_list_view_model.dart';
import 'package:rick_morty_api/feature/shared_widgets/list_header_widget.dart';

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
        : const LocationListView();
  }
}

class LocationListView extends ConsumerStatefulWidget {
  const LocationListView({
    super.key,
  });

  @override
  ConsumerState<LocationListView> createState() => __ContentState();
}

class __ContentState extends LocaitonListViewModel {
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
            controller: scrollController,
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
              return index == 0
                  ? Column(
                      children: [
                        const ListHeaderWidget(
                          titleText: 'All Locations',
                        ),
                        LocationListItem(
                          item: item,
                          onTap: (location) {
                            goToDetailsPage(context, ref, location);
                          },
                        ),
                      ],
                    )
                  : LocationListItem(
                      item: item,
                      onTap: (location) {
                        goToDetailsPage(context, ref, location);
                      },
                    );
            },
          );
        },
      ),
    );
  }
}
