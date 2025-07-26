import 'package:flutter_riverpod/flutter_riverpod.dart';

class imageSearchControllerVO {
  List searchResults = [];
  List favProvider = [];
}

class imageNotifier extends Notifier<imageSearchControllerVO> {
  set search_(List value) {
    //set 해줄 때
    final newState = imageSearchControllerVO(); //새 state
    newState.searchResults = value; //그 newstate는 foo를 set넣은 애고
    state = newState; //state 갈아껴주기
  }

  set favP_(List value) {
    //set 해줄 때
    final newState = imageSearchControllerVO(); //새 state
    newState.favProvider = value; //그 newstate는 foo를 set넣은 애고
    state = newState; //state 갈아껴주기
  }

  @override
  build() {
    return imageSearchControllerVO();
  }
}

final imageProvider = NotifierProvider<imageNotifier, imageSearchControllerVO>(
  () {
    return imageNotifier();
  },
);
