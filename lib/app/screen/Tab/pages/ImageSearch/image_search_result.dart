import 'package:flutter/material.dart';
import 'package:image_search/app/screen/UI.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_search/app/screen/Tab/pages/ImageSearch/provider/image_provider.dart';
import 'package:hive/hive.dart';

int size = 20;
Map search_info = {};
List search_results = [];
Box fav = Hive.box("fav_image");
List fav_provider = fav.values.toList();

class ImageSearchResult extends ConsumerWidget {
  const ImageSearchResult({super.key, required this.keyword});
  final String keyword;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerVO = ref.watch(imageProvider); //watch : 감시
    final providerNotifier = ref.read(imageProvider.notifier); //read : 쓰기
    print("화면갱신됨");

    return FutureBuilder(
      future: futurecompo(providerNotifier),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); //기본제공 로딩바
        } else {
          // print(fav_provider);
          // print(fav.values);
          return Center(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: Padding(
                  padding: EdgeInsets.all(25.0),
                  child: search_box(context, "image"),
                ),
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:
                        search_info['pageable_count'] >= size
                            ? [
                              Wrap(
                                spacing: 10,
                                runSpacing: 15,
                                children: [
                                  for (int i = 0; i < size; i++)
                                    image_box(
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
                              loading_button(
                                onPressed: () {
                                  size += 10;
                                  getJSONData(providerNotifier, false);
                                },
                              ),
                            ]
                            : [
                              //두 페이지 이상 불러올 데이터가 없을 때
                              Wrap(
                                spacing: 10,
                                runSpacing: 15,
                                children: [
                                  for (int i = 0; i < size; i++)
                                    image_box(
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

  Future<String> providerTohive() async {
    //DB연동
    await fav.clear();
    for (var item in fav_provider) {
      await fav.add(item);
    }
    return "success";
  }

  bool checkBool(Map<String, dynamic> detail) {
    //url가 box 내부에 있다면 return true, 없다면 false를 줘서 콘테나 하트를 채우거나 안채우게 해줌
    if (fav_provider.any(
      (item) =>
          item['thumbnail_url'] ==
          detail['thumbnail_url'], //map은 내용 자체로 검색이 안됨. 고유 내용물(필드)로 비교
    )) {
      return true;
    } else {
      return false;
    }
  }

  void db_InOut(dynamic providerNotifier, Map<String, dynamic> detail) {
    //checkBool(detail)에 따라 db 추가, 삭제  여기서하는이유는프로바이더땜시
    // print("처리 전 : ");
    // print(fav_provider);
    if (checkBool(detail)) {
      fav_provider.removeWhere(
        (item) => item['thumbnail_url'] == detail['thumbnail_url'],
      );
    } else {
      fav_provider.add(detail);
    }
    // print("처리후 : ");
    // print(fav_provider);
    providerNotifier.favP_ = fav_provider;
  }

  Future<String> getJSONData(dynamic providerNotifier, bool isFirst) async {
    var url = Uri.parse(
      'https://dapi.kakao.com/v2/search/image?target=title&query=$keyword&size=$size',
    );
    var response = await http.get(
      url,
      headers: {"Authorization": "KakaoAK 694742416ffa1cf156b692be155cf50e"},
    );
    // print(search_results);
    search_info = json.decode(response.body)["meta"];
    search_results = json.decode(response.body)["documents"];
    if (isFirst) {
      return "Success1";
    } else {
      providerNotifier.search_ = search_results; //provider
      return "Success2";
    }
  }

  Future<String> futurecompo(dynamic providerNotifier) async {
    await getJSONData(providerNotifier, true);
    await providerTohive();
    return "success";
  }
}
