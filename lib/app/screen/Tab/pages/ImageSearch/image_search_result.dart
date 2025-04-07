import 'package:flutter/material.dart';
import 'package:image_search/app/screen/UI.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_search/app/screen/Tab/pages/ImageSearch/provider/image_provider.dart';
  int size = 20;
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
    {"thumbnail_url": "none"},
  ];
class ImageSearchResult extends ConsumerWidget {
  const ImageSearchResult({super.key, required this.keyword});
    final String keyword;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
        final providerVO = ref.watch(imageProvider); //watch : 감시
    final providerNotifier = ref.read(imageProvider.notifier); //read : 쓰기
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
          child: Column(
            children: [
              for (int i = 0; i < size~/2; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    image_box(
                      context,
                      search_results[i * 2]["thumbnail_url"],
                    ),
                    SizedBox(width: 12),
                    image_box(
                      context,
                      search_results[i*2 +1]["thumbnail_url"],
                    ),
                  ],
                ),OutlinedButton(
                onPressed: () {
                  size += 20;
                  getJSONData(providerNotifier);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Peri.VeryPeri,
                ),
                child: Text("다음 페이지"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getJSONData(dynamic providerNotifier) async {
    var url = Uri.parse(
      'https://dapi.kakao.com/v2/search/image?target=title&query=$keyword&size=$size',
    );
    var response = await http.get(
      url,
      headers: {"Authorization": "KakaoAK 694742416ffa1cf156b692be155cf50e"},
    );

    search_results = json.decode(response.body)["documents"];
    providerNotifier.foo_ = search_results;
    print(search_results[0]["contents"]);
    return "Sucess";
  }
}
