import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_search/app/screen/Tab/pages/Favorite/provider/favorite_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:image_search/app/screen/UI.dart';

int toggle_index = 0;

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerVO = ref.watch(favoriteProvider); //watch : 감시
    final providerNotifier = ref.read(favoriteProvider.notifier); //read : 쓰기

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Center(
          child: ToggleSwitch(
            minWidth: 100.0,
            cornerRadius: 17.0,
            activeFgColor: Peri.VeryPeri,
            inactiveBgColor: Peri.VeryPeri,
            inactiveFgColor: Colors.white,
            totalSwitches: 2,
            labels: ['Image', 'Text'],
            fontSize: 18.0,
            borderWidth: 3.0,
            borderColor: [Peri.VeryPeri],
            radiusStyle: true,
            activeBgColors: [
              [Colors.white],
              [Colors.white],
            ],
            initialLabelIndex: providerVO.toggleIndex,
            onToggle: (index) {
              print('switched to: $index');
              providerNotifier.toggleIndex_ = index!;
              toggle_index = index;
            },
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [toggle_index == 0 ? Text('쨔잔~이미지') : Text('안쨔잔... 텍스트')],
        ),
      ),
    );
  }
}
