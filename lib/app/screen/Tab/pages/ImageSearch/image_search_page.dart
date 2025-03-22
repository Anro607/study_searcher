import 'package:flutter/material.dart';
import 'package:image_search/app/screen/UI.dart';

class ImageSearchPage extends StatelessWidget {
  const ImageSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/free-icon-edit-photo-11556318.png', scale: 2.5),
          SizedBox(height: 10),
          search_box(context, "image"),
          SizedBox(height: 140),
        ],
      ),
    );
  }
}
