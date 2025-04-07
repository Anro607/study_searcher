import 'package:flutter_riverpod/flutter_riverpod.dart';

class textSearchControllerVO { 
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

class textNotifier extends Notifier<textSearchControllerVO> {
  set foo_(List value) {
    //set 해줄 때
    final newState = textSearchControllerVO(); //새 state
    newState.searchResults = value; //그 newstate는 foo를 set넣은 애고
    state = newState; //state 갈아껴주기
  }

  @override
  build() {
    return textSearchControllerVO();
  }
}

final textProvider =
    NotifierProvider<textNotifier, textSearchControllerVO>(() {
      return textNotifier();
    });
