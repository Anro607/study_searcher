import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteControllerVO {
  //이곳의 변수를 감시(page 파일에서 watch함)
  int toggleIndex = 0; // 토글 스위치의 상태를 저장하는 변수 추가
  List favImageProvider = [];
  List favTextProvider = [];
}

class FavoriteNotifier extends Notifier<FavoriteControllerVO> {
  set toggleIndex_(int value) {
    // 토글 상태를 설정하는 setter
    final newState = FavoriteControllerVO();
    newState.toggleIndex = value;
    state = newState;
  }

  set favImageP_(List value) {
    //set 해줄 때
    final newState = FavoriteControllerVO(); //새 state
    newState.favImageProvider = value; //그 newstate는 foo를 set넣은 애고
    state = newState; //state 갈아껴주기
  }

    set favTextP_(List value) {
    //set 해줄 때
    final newState = FavoriteControllerVO(); //새 state
    newState.favTextProvider = value; //그 newstate는 foo를 set넣은 애고
    state = newState; //state 갈아껴주기
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
