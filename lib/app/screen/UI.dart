import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search/app/router/router.dart';

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
            final String keyword = controller.text;
            if (keyword.isNotEmpty) {
              if (page == "image") {
                context.push(RouterPath.image_result, extra: keyword);
              } else if (page == "text") {
                context.push(RouterPath.text_result, extra: keyword);
              }
            } else {
              //뭐띄우지
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

GestureDetector image_box(BuildContext context, Map result) {
  return GestureDetector(
    onTap: () => context.push(RouterPath.image_detail, extra: result),
    child: Container(
      width: 185,
      height: 170,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(result["thumbnail_url"]),
          fit: BoxFit.cover,
        ),
        border: Border.all(width: 4.0, color: Peri.WinklePeri),
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
  );
}

GestureDetector text_box(BuildContext context, Map result) {
  return GestureDetector(
    onTap: () => context.push(RouterPath.text_detail, extra: result),
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
              result["title"].replaceAll(RegExp(r'<.*?>'), ''),
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
              result["contents"].replaceAll(RegExp(r'<.*?>'), ''),
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

SizedBox back_button(BuildContext context) {
  return SizedBox(
    width: 70,
    height: 70,
    child: FittedBox(
      child: FloatingActionButton(
        onPressed: context.pop,
        backgroundColor: Peri.WinklePeri,
        foregroundColor: Colors.white,
        child: Icon(Icons.arrow_back),
      ),
    ),
  );
}

OutlinedButton loading_button({required VoidCallback onPressed}) {  //required : 필수 매개변수(없으면망해서 오류남)
  return OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Peri.VeryPeri,
    ),
    child: Text("다음 페이지"),
  );
}

class Peri {
  static Color VeryPeri = Color(0xff6667ab);
  static Color WinklePeri = Color(0xFFa3a3e0);
}
