import 'package:flutter/material.dart';
import 'package:image_search/app/screen/UI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HttpApp(),
    );
  }
}

class HttpApp extends StatefulWidget {
  @override
  _HttpAppState createState() => _HttpAppState();
}

class _HttpAppState extends State<HttpApp> {
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
  int max_search = 20;
  @override
  Widget build(BuildContext context) {
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
              for (int i = 0; i < max_search ~/ 2; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    image_box(
                      context,
                      search_results[(i + 1) * 2 - 2]["thumbnail_url"],
                    ),
                    SizedBox(width: 12),
                    image_box(
                      context,
                      search_results[(i + 1) * 2 - 1]["thumbnail_url"],
                    ),
                  ],
                ),
              OutlinedButton(
                onPressed: () {
                  max_search += 20;
                  getJSONData();
                },
                child: Text("다음 페이지"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Peri.VeryPeri,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            getJSONData();
          },
          child: Icon(Icons.file_download),
        ),
      ),
    );
  }

  Future<String> getJSONData() async {
    var url = Uri.parse(
      'https://dapi.kakao.com/v2/search/image?target=title&query=cat&size=$max_search',
    );
    var response = await http.get(
      url,
      headers: {"Authorization": "KakaoAK 694742416ffa1cf156b692be155cf50e"},
    );

    print(response.body);
    setState(() {
      search_results = json.decode(response.body)["documents"];
      print(search_results[0]["contents"]);
    });
    return "Successful";
  }
}
