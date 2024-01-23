import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageIndexProvider =
    NotifierProvider<PageIndexProvider, int>(PageIndexProvider.new);

class PageIndexProvider extends Notifier<int> {
  @override
  build() {
    state = 0;
    return state;
  }

  nextIndex() {
    state++;
  }
}
