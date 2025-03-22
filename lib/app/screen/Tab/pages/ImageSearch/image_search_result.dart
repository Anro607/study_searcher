import 'package:flutter/material.dart';
import 'package:image_search/app/screen/UI.dart';

class ImageSearchResult extends StatelessWidget {
  const ImageSearchResult({super.key});

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
              for (int i = 0; i < 6; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    image_box(
                      context,
                      "https://www.zezelife.com/wp-content/uploads/2023/11/5-1.jpg",
                    ),
                    SizedBox(width: 12),
                    image_box(
                      context,
                      "https://www.zezelife.com/wp-content/uploads/2023/11/5-1.jpg",
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
