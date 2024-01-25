import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/feature/episode/application/episode_service.dart';
import 'package:rick_morty_api/feature/episode/data/dto/episode_response.dart';
import 'package:rick_morty_api/feature/episode/domain/entities/episode.dart';
import 'package:rick_morty_api/feature/episode/presentation/state/page_index_provider.dart';
import 'package:rick_morty_api/utils/api_future_builder.dart';

class EpisodeScreen extends ConsumerStatefulWidget {
  const EpisodeScreen({super.key});

  @override
  ConsumerState<EpisodeScreen> createState() => _EpisodeScreenState();
}

class _EpisodeScreenState extends ConsumerState<EpisodeScreen> {
  String? url;
  @override
  Widget build(BuildContext context) {
    EpisodeService episodeService = ref.watch(episodeServiceProvider);
    return Scaffold(
      body: GeneralFutureBuilder(
        future: episodeService.getEpisodeResponse(url: url),
        builder: (context, data) {
          EpisodeResponse episodeResponse = data;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: episodeResponse.results.length,
                  itemBuilder: (context, index) {
                    var episode = episodeResponse.results[index];
                    return Card(
                      child: ListTile(
                        trailing: Text(episode.episode),
                        title: Text(episode.name),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  data.info.prev != null
                      ? IconButton(
                          onPressed: () {
                            url = data.info.prev;
                            setState(() {});
                          },
                          icon: const Icon(Icons.chevron_left),
                        )
                      : const SizedBox(),
                  data.info.next != null
                      ? IconButton(
                          onPressed: () {
                            url = data.info.next;
                            setState(() {});
                          },
                          icon: const Icon(Icons.chevron_right),
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget bodyColumn(WidgetRef ref, List<Episode> episodeList) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: episodeList.length,
            itemBuilder: (context, index) {
              Episode episode = episodeList[index];
              return ListTile(
                title: Text(episode.name),
              );
            },
          ),
        ),
        IconButton(
          onPressed: () {
            ref.read(pageIndexProvider.notifier).nextIndex();
          },
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
