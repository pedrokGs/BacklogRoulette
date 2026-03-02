import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreenIndexProvider extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void update(int index) {
    state = index;
  }
}

final homeScreenIndexProvider = NotifierProvider<HomeScreenIndexProvider, int>(
  HomeScreenIndexProvider.new,
);
