import 'package:get_it/get_it.dart';
import 'package:rick_morty_api/feature/character/domain/use_cases/get_characters.dart';

final locator = GetIt.instance;

void setup() {
  // locator.registerSingleton<GetCharacters>(GetCharacters(locator()));
}
