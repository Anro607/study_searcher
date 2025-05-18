import 'package:flutter_riverpod/flutter_riverpod.dart';




class FavoriteControllerVO {
  //이곳의 변수를 감시(page 파일에서 watch함)
  int toggleIndex = 0; // 토글 스위치의 상태를 저장하는 변수 추가
}


class FavoriteNotifier extends Notifier<FavoriteControllerVO> {
  set toggleIndex_(int value) {
    // 토글 상태를 설정하는 setter
    final newState = FavoriteControllerVO();
    newState.toggleIndex = value;
    state = newState;
  }


  @override
  build() {
    return FavoriteControllerVO();
  }
}


final favoriteProvider =
    NotifierProvider<FavoriteNotifier, FavoriteControllerVO>(() {
      return FavoriteNotifier();
    });
