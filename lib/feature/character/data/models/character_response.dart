import 'package:rick_morty_api/common/base/page_info.dart';
import 'package:rick_morty_api/feature/character/data/models/character_model.dart';

class CharacterResponse {
  PageInfo? info;
  List<CharacterModel>? results;

  CharacterResponse({this.info, this.results});

  CharacterResponse.fromJson(dynamic json) {
    info = json['info'] != null ? PageInfo.fromJson(json['info']) : null;
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(CharacterModel.fromJson(v));
      });
    }
  }
}
