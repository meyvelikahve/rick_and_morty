import 'package:flutter_riverpod/flutter_riverpod.dart';

final navBarProvider =
    NotifierProvider<NavBarProvider, int>(NavBarProvider.new);

class NavBarProvider extends Notifier<int> {
  @override
  build() {
    state = 0;
    return state;
  }

  setPageIndex(int newIndex) {
    state = newIndex;
  }
}
