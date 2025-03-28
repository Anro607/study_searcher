import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_search/app/screen/Tab/pages/Favorite/provider/favorite_provider.dart';
int number = 0;
class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerVO = ref.watch(favoriteProvider);     //watch : 감시
    final providerNotifier = ref.read(favoriteProvider.notifier);   //read : 쓰기


    return Scaffold(
      body: Center(
        child: Text(number.toString()),),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            number += 1;
            providerNotifier.foo_ = number;   //foo의 setter
            print(number);
          }
        ),
    );
  }
}
