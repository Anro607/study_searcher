import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search/app/screen/Tab/pages/Favorite/favorite_page.dart';
import 'package:image_search/app/screen/Tab/pages/ImageSearch/image_search_detail.dart';
import 'package:image_search/app/screen/Tab/pages/ImageSearch/image_search_page.dart';
import 'package:image_search/app/screen/Tab/pages/ImageSearch/image_search_result.dart';
import 'package:image_search/app/screen/Tab/pages/TextSearch/text_search_detail.dart';
import 'package:image_search/app/screen/Tab/pages/TextSearch/text_search_page.dart';
import 'package:image_search/app/screen/Tab/pages/TextSearch/text_search_result.dart';
import 'package:image_search/app/screen/Tab/tab_shell.dart';

abstract class RouterOutlet {
  // static final RouterOutlet _instance = RouterOutlet._internal();

  // factory RouterOutlet() {
  //   return _instance;
  // }

  // RouterOutlet._internal();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  // static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: RouterPath.favorite,
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state, child) => TabShell(navigationShell: child),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: _Path.image,
                builder: (context, state) => ImageSearchPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: _Path.text,
                builder: (context, state) => TextSearchPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: _Path.favorite,
                builder: (context, state) => FavoritePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: _Path.image_result,
                builder: (context, state) => ImageSearchResult(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: _Path.image_detail,
                builder: (context, state) => ImageSearchDetail(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: _Path.text_result,
                builder: (context, state) => TextSearchResult(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: _Path.text_detail,
                builder: (context, state) => TextSearchDetail(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

abstract class RouterPath {
  static const root = _Path.root;
  static const favorite = _Path.favorite;
  static const image = _Path.image;
  static const image_result = _Path.image_result;
  static const image_detail = _Path.image_detail;
  static const text = _Path.text;
  static const text_result = _Path.text_result;
  static const text_detail = _Path.text_detail;
}

abstract class _Path {
  static const root = '/';
  static const favorite = '/favorite';
  static const image = '/image';
  static const image_result = '/image_result';
  static const image_detail = '/image_detail';
  static const text = '/text';
  static const text_result = '/text_result';
  static const text_detail = '/text_detail';
}
