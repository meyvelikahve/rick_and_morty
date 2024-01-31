import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/episode/presentation/list/controller/episode_page_controller.dart';
import 'package:rick_morty_api/feature/episode/presentation/list/controller/episode_page_state.dart';
import 'package:rick_morty_api/feature/episode/presentation/list/view/widget/episode_list_item.dart';
import 'package:rick_morty_api/feature/episode/presentation/list/view_model/episode_page_view_model.dart';
import 'package:rick_morty_api/feature/shared_widgets/list_header_widget.dart';

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
        : const EpisodeListView();
  }
}

class EpisodeListView extends ConsumerStatefulWidget {
  const EpisodeListView({
    super.key,
  });

  @override
  ConsumerState<EpisodeListView> createState() => __ContentState();
}

class __ContentState extends EpisodeListViewModel {
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
            controller: scrollController,
            itemCount: hasEnded ? list.length : list.length + 1,
            itemBuilder: (context, index) {
              if (index >= list.length) {
                return !hasEnded
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox();
              }
              final item = list[index];
              return index == 0
                  ? Column(
                      children: [
                        const ListHeaderWidget(
                          titleText: 'All Episodes',
                        ),
                        EpisodeListItem(
                          item: item,
                          onTap: (character) {
                            goToDetailsPage(context, ref, character);
                          },
                        ),
                      ],
                    )
                  : EpisodeListItem(
                      item: item,
                      onTap: (character) {
                        goToDetailsPage(context, ref, character);
                      },
                    );
            },
          );
        },
      ),
    );
  }
}
