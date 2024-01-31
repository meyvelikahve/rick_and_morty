import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_morty_api/feature/character/domain/entities/character_entity.dart';
import 'package:rick_morty_api/feature/character/presentation/list/view/character_page.dart';
import 'package:rick_morty_api/feature/dashboard/presentation/ui/dashboard_screen.dart';
import 'package:rick_morty_api/feature/episode/domain/entities/episode.dart';
import 'package:rick_morty_api/feature/episode/presentation/detail/view/episode_detail_page.dart';
import 'package:rick_morty_api/feature/episode/presentation/list/view/episode_page.dart';
import 'package:rick_morty_api/feature/location/domain/entities/location_entity.dart';
import 'package:rick_morty_api/feature/location/presentation/detail/view/location_detail_page.dart';
import 'package:rick_morty_api/feature/location/presentation/list/view/location_page.dart';

import '../../feature/character/presentation/detail/view/character_detail_screen.dart';

enum RoutePathEnum {
  character(path: '/character'),
  characterDetail(path: 'characterDetail'),
  characterEpisodeDetail(path: 'characterEpisodeDetail'),
  episode(path: '/episode'),
  episodeDetail(path: 'episodeDetail'),
  location(path: '/location'),
  locationDetail(path: 'locationDetail'),
  locationCharacterDetail(path: 'locationCharacterDetail');

  const RoutePathEnum({required this.path});
  final String path;
}

class AppNavigation {
  AppNavigation._();

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey(debugLabel: 'root');

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePathEnum.character.path,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return DashboardScreen(child: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: RoutePathEnum.character.path,
                name: RoutePathEnum.character.name,
                routes: [
                  GoRoute(
                    path: '${RoutePathEnum.characterDetail.path}:characterId',
                    name: RoutePathEnum.characterDetail.name,
                    builder: (context, state) {
                      CharacterEntity characterEntity =
                          state.extra as CharacterEntity;
                      return CharacterDetailsPage(
                        key: state.pageKey,
                        characterEntity: characterEntity,
                      );
                    },
                  ),
                  GoRoute(
                    path:
                        '${RoutePathEnum.characterEpisodeDetail.path}/:episodeId',
                    name: RoutePathEnum.characterEpisodeDetail.name,
                    builder: (context, state) {
                      EpisodeEntity episodeEntity =
                          state.extra as EpisodeEntity;
                      return EpisodeDetailPage(
                        key: state.pageKey,
                        episodeEntity: episodeEntity,
                      );
                    },
                  ),
                ],
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: CharacterPage(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: RoutePathEnum.episode.path,
                name: RoutePathEnum.episode.name,
                routes: [
                  GoRoute(
                    path: '${RoutePathEnum.episodeDetail.path}:episodeId',
                    name: RoutePathEnum.episodeDetail.name,
                    builder: (context, state) {
                      EpisodeEntity episodeEntity =
                          state.extra as EpisodeEntity;

                      return EpisodeDetailPage(episodeEntity: episodeEntity);
                    },
                  ),
                ],
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: EpisodePage(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: RoutePathEnum.location.path,
                name: RoutePathEnum.location.name,
                routes: [
                  GoRoute(
                    path: '${RoutePathEnum.locationDetail.path}:locationId',
                    name: RoutePathEnum.locationDetail.name,
                    builder: (context, state) {
                      LocationEntity locationEntity =
                          state.extra as LocationEntity;

                      return LocationDetailPage(locationEntity: locationEntity);
                    },
                    routes: [
                      GoRoute(
                        path:
                            '${RoutePathEnum.locationCharacterDetail.path}/:characterId',
                        name: RoutePathEnum.locationCharacterDetail.name,
                        builder: (context, state) {
                          CharacterEntity characterEntity =
                              state.extra as CharacterEntity;
                          return CharacterDetailsPage(
                            characterEntity: characterEntity,
                          );
                        },
                      ),
                    ],
                  ),
                ],
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: LocationPage(
                      key: state.pageKey,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
