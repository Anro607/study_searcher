import 'package:flutter/material.dart';
import 'package:image_search/app/screen/UI.dart';

class TextSearchPage extends StatelessWidget {
  const TextSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/free-icon-content-writing-4554480.png',
            scale: 2.5,
          ),
          SizedBox(height: 10),
          search_box(context, "text"),
          SizedBox(height: 140),
        ],
      ),
    );
  }
}
