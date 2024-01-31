import 'package:equatable/equatable.dart';
import 'package:rick_morty_api/feature/episode/domain/entities/episode.dart';

enum EpisodePageStatus { initial, loading, success, failure }

class EpisodePageState extends Equatable {
  const EpisodePageState({
    this.status = EpisodePageStatus.initial,
    this.episodes = const [],
    this.hasReachedEnd = false,
    this.currentPage = 1,
  });

  final EpisodePageStatus status;
  final List<EpisodeEntity> episodes;
  final bool hasReachedEnd;
  final int currentPage;

  EpisodePageState copyWith({
    EpisodePageStatus? status,
    List<EpisodeEntity>? episodes,
    bool? hasReachedEnd,
    int? currentPage,
  }) {
    return EpisodePageState(
      status: status ?? this.status,
      episodes: episodes ?? this.episodes,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [
        status,
        episodes,
        hasReachedEnd,
        currentPage,
      ];
}
