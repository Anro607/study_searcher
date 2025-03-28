import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteControllerVO {  //이곳의 변수를 감시(page 파일에서 watch함)
  int foo = 0;
}

class FavoriteNotifier extends Notifier<FavoriteControllerVO> {
  set foo_(int value) {   //set 해줄 때
    final newState = FavoriteControllerVO();    //새 state 
    newState.foo = value;                       //그 newstate는 foo를 set넣은 애고
    state = newState;                           //state 갈아껴주기
  }

  @override
  build() {
    return FavoriteControllerVO();
  }
}

final favoriteProvider = NotifierProvider<FavoriteNotifier, FavoriteControllerVO>(() {
  return FavoriteNotifier();
});