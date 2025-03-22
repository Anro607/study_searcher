import 'package:flutter/material.dart';
import 'package:image_search/app/screen/UI.dart';

class TextSearchDetail extends StatelessWidget {
  const TextSearchDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 50),
          SizedBox(
            width: 350,
            height: 400,
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "원본 제목",
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Peri.VeryPeri,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Divider(height: 5, thickness: 2, color: Peri.WinklePeri),
                  Text(
                    "https://www.youtube.com/watch?v=B0Kms_d5DsM",
                    style: TextStyle(fontSize: 17.0, color: Peri.VeryPeri),
                    overflow: TextOverflow.fade,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
