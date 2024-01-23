import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_api/feature/character/application/character_service.dart';
import 'package:rick_morty_api/feature/character/application/icharacter_service.dart';
import 'package:rick_morty_api/feature/character/domain/model/character.dart';
import 'package:rick_morty_api/feature/character/presentation/ui/character_detail_screen.dart';

class CharacterScreen extends ConsumerWidget {
  const CharacterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ICharacterService characterService = ref.watch(characterServiceProvider);
    return Scaffold(
      body: FutureBuilder(
        future: characterService.getCharacterList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              return bodyColumn(ref, snapshot.data!);
            } else {
              return const Center(
                child: Text("Episodes not found."),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }

  Widget bodyColumn(WidgetRef ref, List<Character> characterList) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: characterList.length,
            itemBuilder: (context, index) {
              Character character = characterList[index];
              return InkWell(
                onTap: () {
                  GoRouter.of(context).go('/characterDetail', extra: {'id': 1});
                },
                child: ListTile(
                  title: Text(character.name),
                ),
              );
            },
          ),
        ),
        IconButton(
          onPressed: () {
            //ref.read(pageIndexProvider.notifier).nextIndex();
          },
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
