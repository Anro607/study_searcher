import 'package:flutter/material.dart';
import 'package:image_search/app/screen/UI.dart';

class ImageSearchDetail extends StatelessWidget {
  const ImageSearchDetail({super.key, required this.detail});
  final Map detail;
  

  @override
  Widget build(BuildContext context) {
    print(detail);
    return Scaffold(body: Center(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 400,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 14),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(detail["image_url"]),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            width: 350,
            height: 400,
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detail["display_sitename"],
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
                    detail["image_url"],
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
    ),floatingActionButton: back_button(context),);
  }
}
