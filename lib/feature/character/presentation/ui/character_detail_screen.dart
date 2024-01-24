import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_api/feature/character/application/character_service.dart';
import 'package:rick_morty_api/feature/character/application/icharacter_service.dart';
import 'package:rick_morty_api/utils/api_future_builder.dart';

import '../../domain/model/character.dart';

class CharacterDetailScreen extends ConsumerWidget {
  final String id;
  const CharacterDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ICharacterService characterService = ref.watch(characterServiceProvider);

    return GeneralFutureBuilder(
      future: characterService.getCharacterWithId(
        int.parse(id),
      ),
      builder: (context, data) {
        return myBody(context, data);
      },
    );
  }

  Widget myBody(BuildContext context, Character character) {
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
        Image.network(character.image),
        Text(
          character.name,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          character.gender,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          character.species,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          character.status,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          character.location.name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          character.type,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          character.origin.name,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}
