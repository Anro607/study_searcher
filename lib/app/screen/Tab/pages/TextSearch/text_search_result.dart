import 'package:flutter/material.dart';
import 'package:image_search/app/screen/UI.dart';

class TextSearchResult extends StatelessWidget {
  const TextSearchResult({super.key});

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
              children: [for (int i = 0; i < 6; i++) text_box(context, "df", "df")],
            ),
          ),
        ),
      ),
    );
  }
}
