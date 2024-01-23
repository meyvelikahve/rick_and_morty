import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_morty_api/core/locator_service.dart';
import 'package:rick_morty_api/core/route/go_router_provider.dart';

void main() {
  locatorServiceInitialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final route = getIt.get<GoRouterProvider>();
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: route.goRouter(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
