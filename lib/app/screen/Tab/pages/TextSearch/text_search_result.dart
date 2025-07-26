import 'package:flutter/material.dart';
import 'package:image_search/app/screen/UI.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_search/app/screen/Tab/pages/TextSearch/provider/text_provider.dart';
import 'package:hive/hive.dart';

bool isFirst = true;
int size = 10;
Map search_info = {"total_count": 100, "pageable_count": 10, "is_end": false};
List search_results = [];
Box fav = Hive.box("fav_text");
List fav_provider = fav.values.toList();

class TextSearchResult extends ConsumerWidget {
  const TextSearchResult({super.key, required this.keyword});
  final String keyword;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerVO = ref.watch(textProvider); //watch : 감시
    final providerNotifier = ref.read(textProvider.notifier); //read : 쓰기

    providerToHive();
    print("화면갱신됨");

    return FutureBuilder(
      future: getJSONData(providerNotifier, true),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator()); //기본제공 로딩바
        } else {
          return Center(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: Padding(
                  padding: EdgeInsets.all(25.0),
                  child: search_box(
                    context,
                    "text",
                  ), //다음 고칠 것: 얘를 search_box(결과 push) 말고 여기 페이지에서 keyword 바꾸고 size 초기화 하는 걸로 바꾸기
                ),
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children:
                        search_info['pageable_count'] >= size
                            ? [
                              for (int i = 0; i < size; i++)
                                text_box(
                                  context,
                                  search_results[i],
                                  checkBool(search_results[i]),
                                  () => db_InOut(
                                    providerNotifier,
                                    search_results[i],
                                  ),
                                ),
                              loading_button(
                                onPressed: () {
                                  size += 10;
                                  getJSONData(providerNotifier, false);
                                },
                              ),
                            ]
                            : [
                              for (
                                int i = 0;
                                i < search_info['pageable_count'];
                                i++
                              )
                                text_box(
                                  context,
                                  search_results[i],
                                  checkBool(search_results[i]),
                                  () => db_InOut(
                                    providerNotifier,
                                    search_results[i],
                                  ),
                                ),
                            ],
                  ),
                ),
              ),
              floatingActionButton: back_button(context),
            ),
          );
        }
      },
    );
  }

  void providerToHive() {
    //DB연동
    fav.clear();
    for (var item in fav_provider) {
      fav.add(item);
    }
  }

  bool checkBool(Map<String, dynamic> detail) {
    //url가 box 내부에 있다면 return true, 없다면 false를 줘서 콘테나 하트를 채우거나 안채우게 해줌
    print(
      fav_provider.any(
        (item) =>
            item['url'] == detail['url'], //map은 내용 자체로 검색이 안됨. 고유 내용물(필드)로 비교
      ),
    );
    if (fav_provider.any((item) => item['url'] == detail['url'])) {
      return true;
    } else {
      return false;
    }
  }

  void db_InOut(dynamic providerNotifier, Map<String, dynamic> detail) {
    //checkBool(detail)에 따라 db 추가, 삭제  여기서하는이유는프로바이더땜시
    print("처리 전 : ");
    print(fav_provider);
    if (checkBool(detail)) {
      fav_provider.removeWhere((item) => item['url'] == detail['url']);
    } else {
      fav_provider.add(detail);
    }
    print("처리후 : ");
    print(fav_provider);
    providerNotifier.favP_ = fav_provider;
  }

  Future<String> getJSONData(dynamic providerNotifier, bool isFirst) async {
    var url = Uri.parse(
      'https://dapi.kakao.com/v2/search/web?target=title&query=$keyword&size=$size',
    );
    var response = await http.get(
      url,
      headers: {"Authorization": "KakaoAK 694742416ffa1cf156b692be155cf50e"},
    );

    // print(size);
    // print(json.decode(response.body)["meta"]["pageable_count"]);
    search_info = json.decode(response.body)["meta"];
    search_results = json.decode(response.body)["documents"];
    if (isFirst) {
      return "Success1";
    } else {
      providerNotifier.foo_ = search_results; //provider
      return "Success2";
    }
  }
}
