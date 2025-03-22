import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabControllerVO {
  int bottomNavigationBarIndex = 0;
}

class TabNotifier extends Notifier<TabControllerVO> {
  int get bottomNavigationBarIndex => state.bottomNavigationBarIndex;
  set bottomNavigationBarIndex(int value) {
    final newState = TabControllerVO();
    newState.bottomNavigationBarIndex = value;
    state = newState;
  }

  @override
  build() {
    return TabControllerVO();
  }
}

final tabProvider = NotifierProvider<TabNotifier, TabControllerVO>(() {
  return TabNotifier();
});
