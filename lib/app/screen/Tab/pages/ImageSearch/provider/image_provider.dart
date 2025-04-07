import 'package:flutter_riverpod/flutter_riverpod.dart';

class imageSearchControllerVO {
  List searchResults = [
    {"contents": "temp1", "title": "temp2"},
    {"contents": "temp3", "title": "temp4"},
    {"contents": "temp1", "title": "temp2"},
    {"contents": "temp3", "title": "temp4"},
    {"contents": "temp1", "title": "temp2"},
    {"contents": "temp3", "title": "temp4"},
    {"contents": "temp1", "title": "temp2"},
    {"contents": "temp3", "title": "temp4"},
    {"contents": "temp1", "title": "temp2"},
    {"contents": "temp3", "title": "temp4"},
    {"contents": "temp1", "title": "temp2"},
    {"contents": "temp3", "title": "temp4"},
    {"contents": "temp1", "title": "temp2"},
    {"contents": "temp3", "title": "temp4"},
    {"contents": "temp1", "title": "temp2"},
    {"contents": "temp3", "title": "temp4"},
    {"contents": "temp1", "title": "temp2"},
    {"contents": "temp3", "title": "temp4"},
    {"contents": "temp1", "title": "temp2"},
    {"contents": "temp3", "title": "temp4"},
    {"contents": "temp1", "title": "temp2"},
    {"contents": "temp3", "title": "temp4"},
  ];
}

class imageNotifier extends Notifier<imageSearchControllerVO> {
  set foo_(List value) {
    //set 해줄 때
    final newState = imageSearchControllerVO(); //새 state
    newState.searchResults = value; //그 newstate는 foo를 set넣은 애고
    state = newState; //state 갈아껴주기
  }

  @override
  build() {
    return imageSearchControllerVO();
  }
}

final imageProvider =
    NotifierProvider<imageNotifier, imageSearchControllerVO>(() {
      return imageNotifier();
    });
