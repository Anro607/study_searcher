import 'package:flutter/material.dart';
import 'package:image_search/app/screen/UI.dart';

class TextSearchDetail extends StatelessWidget {
  const TextSearchDetail({super.key, required this.detail});
  final Map detail;

  @override
  Widget build(BuildContext context) {
    print(detail);
    return Scaffold(body: Center(
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
                    detail["title"],
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
                    detail["contents"],
                    style: TextStyle(fontSize: 17.0, color: Peri.VeryPeri),
                    overflow: TextOverflow.fade,
                    maxLines: 8,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ), floatingActionButton: back_button(context),);
  }
}
