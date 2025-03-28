import 'package:flutter/material.dart';
import 'package:image_search/app/screen/UI.dart';

int size = 10;

class TextSearchResult extends StatelessWidget {
  const TextSearchResult({super.key, required this.keyword});
  final String keyword;

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
              children: [for (int i = 0; i < 6; i++) text_box(context, keyword, i, size),OutlinedButton(
                  onPressed: () {
                    size+=10;
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Peri.VeryPeri,
                  ),
                  child: Text("다음 페이지"),
                ),],
            ),
          ),
        ),
      ),
    );
  }

  
}
