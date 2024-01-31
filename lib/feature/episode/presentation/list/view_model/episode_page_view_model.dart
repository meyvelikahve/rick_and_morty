import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_api/app/navigation/app_navigation.dart';
import 'package:rick_morty_api/feature/episode/domain/entities/episode.dart';
import 'package:rick_morty_api/feature/episode/presentation/list/controller/episode_page_controller.dart';
import 'package:rick_morty_api/feature/episode/presentation/list/view/episode_page.dart';

abstract class EpisodeListViewModel extends ConsumerState<EpisodeListView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
  }

  void goToDetailsPage(
      BuildContext context, WidgetRef ref, EpisodeEntity episode) {
    context.pushNamed(
      RoutePathEnum.episodeDetail.path,
      extra: episode,
      pathParameters: {'episodeId': episode.id.toString()},
    );
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(onScroll)
      ..dispose();
    super.dispose();
  }

  void onScroll() {
    if (_isBottom) {
      ref.read(episodePageStateProvider.notifier).fetchNextPage();
    }
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    return scrollController.offset >=
            scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange;
  }
}
