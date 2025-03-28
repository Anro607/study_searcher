import 'package:flutter/material.dart';
import 'package:image_search/app/screen/UI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: HttpApp(),
    );
  }
}

class HttpApp extends StatefulWidget {
  const HttpApp({super.key});

  @override
  _HttpAppState createState() => _HttpAppState();
}

class _HttpAppState extends State<HttpApp> {
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
  int max_search = 10;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Padding(
            padding: EdgeInsets.all(25.0),
            child: search_box(context, "text"),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                for (int i = 0; i < max_search; i++)
                  text_box(
                    context,
                    search_results[i]["title"].replaceAll(RegExp(r'<.*?>'), ''),
                    search_results[i]["contents"].replaceAll(
                      RegExp(r'<.*?>'), 
                      '',
                    )
                  ),
                OutlinedButton(
                  onPressed: () {
                    max_search += 10;
                    getJSONData();
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
      'https://dapi.kakao.com/v2/search/web?target=title&query=pizza&size=$max_search',
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





//search 박스 텍스트 변수를 결과페이지로 보냄, 결과페이지에서 쿼리어쩌구