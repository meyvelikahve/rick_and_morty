import 'package:rick_morty_api/feature/episode/data/dto/episode_dto.dart';
import 'package:rick_morty_api/feature/episode/domain/entities/episode.dart';

extension EpisodeDtoExtention on EpisodeDto {
  EpisodeEntity toEpisodeEntity() {
    return EpisodeEntity(
        id: id,
        name: name,
        airDate: airDate,
        episode: episode,
        characters: characters,
        url: url,
        created: created);
  }
}
