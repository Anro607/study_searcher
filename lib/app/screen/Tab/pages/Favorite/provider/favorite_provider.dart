import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteControllerVO {
  int foo = 0;
}

class FavoriteNotifier extends Notifier<FavoriteControllerVO> {
  set bottomNavigationBarIndex(int value) {
    final newState = FavoriteControllerVO();
    newState.foo = value;
    state = newState;
  }

  @override
  build() {
    return FavoriteControllerVO();
  }
}

final favoriteProvider = NotifierProvider<FavoriteNotifier, FavoriteControllerVO>(() {
  return FavoriteNotifier();
});