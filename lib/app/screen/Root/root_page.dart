import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search/app/router/router.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.go(RouterPath.image);
    return Center();
  }
}
