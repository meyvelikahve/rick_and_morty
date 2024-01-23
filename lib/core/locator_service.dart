import 'package:get_it/get_it.dart';
import 'package:rick_morty_api/core/route/go_router_provider.dart';

final getIt = GetIt.instance;

void locatorServiceInitialize() {
  getIt.registerFactory(() => GoRouterProvider());
}
