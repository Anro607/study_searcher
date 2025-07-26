import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_search/app/router/router.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox("fav_image");
  await Hive.openBox("fav_text");
  runApp(
    ProviderScope(child: MaterialApp.router(routerConfig: RouterOutlet.router)),
  );
}
