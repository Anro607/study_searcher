import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search/app/router/router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


Container search_box(BuildContext context, String page) {
  final controller = TextEditingController();

  return Container(
    width: 320,
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30.0),
      color: Peri.VeryPeri,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            if (page == "image") {
              context.go(RouterPath.image_result);
            } else if (page == "text") {
              final String keyword = controller.text;
              context.go(RouterPath.text_result, extra: keyword);
              
            }
          },
          icon: Icon(Icons.search, color: Colors.white, size: 30.0),
        ),
        SizedBox(width: 3),
        Container(
          height: 24,
          width: 240,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white, width: 2.5)),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText:
                  page == "image" ? "다음 용어로 이미지를 검색합니다" : "다음 용어로 텍스트를 검색합니다",
              hintStyle: TextStyle(color: Peri.WinklePeri),
            ),
          ),
        ),
        SizedBox(width: 15),
      ],
    ),
  );
  
}

GestureDetector image_box(BuildContext context, String url) {
  return GestureDetector(
    onTap: () => context.go(RouterPath.image_detail),
    child: Container(
      width: 185,
      height: 170,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 14),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
        border: Border.all(width: 4.0, color: Peri.WinklePeri),
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
  );
}

GestureDetector text_box(BuildContext context, String keyword, int index, int size) {
  
  var search_results = [];

  Future<String> getJSONData() async {
    var url = Uri.parse(
      'https://dapi.kakao.com/v2/search/web?target=title&query=$keyword&size=$size',
    );
    var response = await http.get(
      url,
      headers: {"Authorization": "KakaoAK 694742416ffa1cf156b692be155cf50e"},
    );
    search_results = json.decode(response.body)["documents"];
    print(search_results[0]["contents"]);
    
    return "Sucess";
  }
  return GestureDetector(
    onTap: () => context.go(RouterPath.text_detail),
    child: Container(
      width: 350,
      height: 130,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 14),
      decoration: BoxDecoration(
        border: Border.all(width: 4.0, color: Peri.WinklePeri),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              search_results[0]["title"],
              style: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
                color: Peri.VeryPeri,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Divider(height: 5, thickness: 2, color: Peri.WinklePeri),
            Text(
              search_results[0]["context"],
              style: TextStyle(fontSize: 14.0, color: Peri.VeryPeri),
              overflow: TextOverflow.fade,
              maxLines: 2,
            ),
          ],
        ),
      ),
    ),
  );
}

class Peri {
  static Color VeryPeri = Color(0xff6667ab);
  static Color WinklePeri = Color(0xFFa3a3e0);
}
