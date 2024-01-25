import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_api/feature/character/data/models/character_model.dart';
import 'package:rick_morty_api/feature/character/domain/use_cases/get_charactecter_detail.dart';
import 'package:rick_morty_api/utils/api_future_builder.dart';

import '../../domain/entities/character_entity.dart';

class CharacterDetailScreen extends ConsumerWidget {
  final String id;
  const CharacterDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetCharacterDetail characterModel = ref.watch(getCharacterDetailProvider);

    print(id);

    return GeneralFutureBuilder(
      // future: characterService.getCharacterWithId(
      //   int.parse(id),
      // ),
      future: characterModel.call(params: int.parse(id)),
      builder: (context, data) {
        if (data.data != null) {
          return myBody(context, data.data!);
        } else {
          return Center(
            child: Text(data.exception?.message ?? 'Something went wrong'),
          );
        }
      },
    );
  }

  Widget myBody(BuildContext context, CharacterModel character) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: const Icon(Icons.back_hand),
            ),
          ],
        ),
        Image.network(character.image ?? ''),
        Text(
          character.name ?? '',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          character.gender ?? '',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          character.species ?? '',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          character.status ?? '',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          character.location?.name ?? '',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          character.type ?? '',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          character.origin?.name ?? '',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
