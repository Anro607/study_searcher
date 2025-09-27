import 'package:hive/hive.dart';

class FavoriteRepository {
  // Image Favorites Methods
  static Future<void> addImageFavorite(Map item) async {
    final box = Hive.box('fav_image');
    final isAlreadyFavorite = await isImageFavorite(item);
    if (!isAlreadyFavorite) {
      await box.add(item);
    }
  }

  static Future<void> removeImageFavorite(Map item) async {
    final box = Hive.box('fav_image');
    final thumbnailUrl = item['thumbnail_url'] as String;
    final keysToRemove = <int>[];
    for (var key in box.keys) {
      final storedItem = box.get(key) as Map?;
      if (storedItem != null && storedItem['thumbnail_url'] == thumbnailUrl) {
        keysToRemove.add(key as int);
      }
    }
    for (var key in keysToRemove) {
      await box.delete(key);
    }
  }

  static bool isImageFavorite(Map detail) {
    final box = Hive.box('fav_image');
    return box.values.any((item) {
      if (item is Map) {
        return item['thumbnail_url'] == detail['thumbnail_url'];
      }
      return false;
    });
  }

  static List<Map> getAllImageFavorites() {
    final box = Hive.box('fav_image');
    return box.values
        .whereType<Map>()
        .toList();
  }

  // Text Favorites Methods
  static Future<void> addTextFavorite(Map item) async {
    final box = Hive.box('fav_text');
    final isAlreadyFavorite = await isTextFavorite(item);
    if (!isAlreadyFavorite) {
      await box.add(item);
    }
  }

  static Future<void> removeTextFavorite(Map item) async {
    final box = Hive.box('fav_text');
    final url = item['url'] as String;
    final keysToRemove = <int>[];
    for (var key in box.keys) {
      final storedItem = box.get(key) as Map?;
      if (storedItem != null && storedItem['url'] == url) {
        keysToRemove.add(key as int);
      }
    }
    for (var key in keysToRemove) {
      await box.delete(key);
    }
  }

  static bool isTextFavorite(Map detail) {
    final box = Hive.box('fav_text');
    return box.values.any((item) {
      if (item is Map) {
        return item['url'] == detail['url'];
      }
      return false;
    });
  }

  static List<Map> getAllTextFavorites() {
    final box = Hive.box('fav_text');
    return box.values
        .whereType<Map>()
        .toList();
  }

  // Toggle between image and text might not be needed here, but utility if required
  static List<Map> getFavoritesByType(int toggleIndex) {
    if (toggleIndex == 0) {
      return getAllImageFavorites();
    } else {
      return getAllTextFavorites();
    }
  }
}