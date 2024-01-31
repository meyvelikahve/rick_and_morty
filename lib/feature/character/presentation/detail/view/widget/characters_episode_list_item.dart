import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_api/app/navigation/app_navigation.dart';
import 'package:rick_morty_api/feature/character/domain/entities/character_entity.dart';
import 'package:rick_morty_api/feature/episode/domain/use_cases/get_episode_detail.dart';
import 'package:rick_morty_api/utils/api_future_builder.dart';

class CharactersEpisodeListItem extends ConsumerWidget {
  const CharactersEpisodeListItem({super.key, required this.characterEntity});
  final CharacterEntity characterEntity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetEpisodeDetail getEpisodeDetail = ref.watch(getEpisodeProvider);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: characterEntity.episode?.length,
      itemBuilder: (context, index) {
        final episodes = characterEntity.episode;
        final characterId = episodes?[index].split('/').last;

        return GeneralFutureBuilder(
          future:
              getEpisodeDetail.call(params: int.tryParse(characterId ?? '1')),
          builder: (context, data) {
            return InkWell(
              onTap: () {
                context.goNamed(RoutePathEnum.characterEpisodeDetail.name,
                    pathParameters: {
                      'episodeId': episodes?[index] ?? '1',
                    },
                    extra: data);
              },
              child: _CharacterCardView(
                id: data.id,
                name: data.episode,
              ),
            );
          },
        );
      },
    );
  }
}

class _CharacterCardView extends StatelessWidget {
  const _CharacterCardView({
    super.key,
    required this.id,
    required this.name,
  });
  final int id;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        //  color: colorScheme.surfaceVariant,
      ),
      height: 150,
      width: 150,
      child: Card(
        child: Center(
          child: Text(
            name,
          ),
        ),
      ),
    );
  }
}
