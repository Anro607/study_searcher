import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_search/app/router/router.dart';

void main() {
  runApp(ProviderScope(child: MaterialApp.router(routerConfig: RouterOutlet.router,)));
}
