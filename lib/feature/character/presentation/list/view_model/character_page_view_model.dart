import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_api/app/navigation/app_navigation.dart';
import 'package:rick_morty_api/feature/character/domain/entities/character_entity.dart';
import 'package:rick_morty_api/feature/character/presentation/list/controller/character_page_controller.dart';
import 'package:rick_morty_api/feature/character/presentation/list/view/character_page.dart';

abstract class CharacterListViewModel extends ConsumerState<CharacterListView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  void goToDetailsPage(
      BuildContext context, WidgetRef ref, CharacterEntity character) {
    context.pushNamed(
      RoutePathEnum.characterDetail.path,
      extra: character,
      pathParameters: {'characterId': character.id.toString()},
    );
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      ref.read(characterPageControllerProvider.notifier).fetchNextPage();
    }
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    return scrollController.offset >=
            scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange;
  }
}
