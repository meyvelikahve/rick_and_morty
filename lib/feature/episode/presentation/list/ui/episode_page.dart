import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_api/app/navigation/app_navigation.dart';
import 'package:rick_morty_api/feature/episode/domain/entities/episode.dart';
import 'package:rick_morty_api/feature/episode/presentation/detail/state/episode_detail_state.dart';
import 'package:rick_morty_api/feature/episode/presentation/list/state/episode_page_notifier.dart';
import 'package:rick_morty_api/feature/episode/presentation/list/state/episode_page_state.dart';
import 'package:rick_morty_api/feature/episode/presentation/list/ui/widget/episode_list_item.dart';

class EpisodePage extends ConsumerStatefulWidget {
  const EpisodePage({super.key});

  @override
  ConsumerState<EpisodePage> createState() => _EpisodePageState();
}

class _EpisodePageState extends ConsumerState<EpisodePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(episodePageStateProvider.notifier).fetchNextPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(
      episodePageStateProvider.select((p) => p.status),
    );

    return status == EpisodePageStatus.initial
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
          final state = ref.watch(episodePageStateProvider);
          final list = state.episodes;
          final hasEnded = state.hasReachedEnd;

          return ListView.builder(
            key: const ValueKey('episode_page_list_key'),
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
              return EpisodeListItem(
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
      BuildContext context, WidgetRef ref, EpisodeEntity episode) {
    ref.read(episodeDetailsPageProvider.notifier).setEpisode(episode);
    context.pushNamed(
      RoutePathEnum.episodeDetail.path,
      pathParameters: {'id': episode.id.toString()},
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
      ref.read(episodePageStateProvider.notifier).fetchNextPage();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    return _scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange;
  }
}
