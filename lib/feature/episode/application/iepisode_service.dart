import 'package:rick_morty_api/feature/episode/domain/model/episode.dart';

abstract class IEpisodeService {
  Future<List<Episode>> getEpisodeList(int? pageIndex);
}
