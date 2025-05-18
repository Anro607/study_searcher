import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search/app/screen/UI.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_search/app/screen/Tab/pages/TextSearch/provider/text_provider.dart';

bool isFirst = true;
int size = 10;
Map search_info = {"total_count": 100, "pageable_count": 10, "is_end": false};
List search_results = [
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

class TextSearchResult extends ConsumerWidget {
  const TextSearchResult({super.key, required this.keyword});
  final String keyword;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerVO = ref.watch(textProvider); //watch : 감시
    final providerNotifier = ref.read(textProvider.notifier); //read : 쓰기

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
                                text_box(context, search_results[i]),
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
                                text_box(context, search_results[i]),
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

  Future<String> getJSONData(dynamic providerNotifier, bool isFirst) async {
    var url = Uri.parse(
      'https://dapi.kakao.com/v2/search/web?target=title&query=$keyword&size=$size',
    );
    var response = await http.get(
      url,
      headers: {"Authorization": "KakaoAK 694742416ffa1cf156b692be155cf50e"},
    );

    print(size);
    print(json.decode(response.body)["meta"]["pageable_count"]);
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
