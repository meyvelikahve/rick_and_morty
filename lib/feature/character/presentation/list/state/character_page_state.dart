import 'package:equatable/equatable.dart';
import 'package:rick_morty_api/feature/character/domain/entities/character_entity.dart';

enum CharacterPageStatus { initial, loading, success, failure }

class CharacterPageState extends Equatable {
  const CharacterPageState({
    this.status = CharacterPageStatus.initial,
    this.characters = const [],
    this.hasReachedEnd = false,
    this.currentPage = 1,
  });

  final CharacterPageStatus status;
  final List<CharacterEntity> characters;
  final bool hasReachedEnd;
  final int currentPage;

  CharacterPageState copyWith({
    CharacterPageStatus? status,
    List<CharacterEntity>? characters,
    bool? hasReachedEnd,
    int? currentPage,
  }) {
    return CharacterPageState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [
        status,
        characters,
        hasReachedEnd,
        currentPage,
      ];
}
