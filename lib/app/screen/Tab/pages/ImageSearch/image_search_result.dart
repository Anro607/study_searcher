import 'package:flutter/material.dart';
import 'package:image_search/app/screen/UI.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_search/app/screen/Tab/pages/ImageSearch/provider/image_provider.dart';

int size = 20;
Map search_info = {"total_count": 100, "pageable_count": 100, "is_end": false};
List search_results = [
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
  {"thumbnail_url": "none"},
];

class ImageSearchResult extends ConsumerWidget {
  const ImageSearchResult({super.key, required this.keyword});
  final String keyword;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerVO = ref.watch(imageProvider); //watch : 감시
    final providerNotifier = ref.read(imageProvider.notifier); //read : 쓰기

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
                                    image_box(context, search_results[i]),
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
                              Wrap(
                                spacing: 10,
                                runSpacing: 15,
                                children: [
                                  for (int i = 0; i < size; i++)
                                    image_box(context, search_results[i]),
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

  Future<String> getJSONData(dynamic providerNotifier, bool isFirst) async {
    var url = Uri.parse(
      'https://dapi.kakao.com/v2/search/image?target=title&query=$keyword&size=$size',
    );
    var response = await http.get(
      url,
      headers: {"Authorization": "KakaoAK 694742416ffa1cf156b692be155cf50e"},
    );
    print(search_results);
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
