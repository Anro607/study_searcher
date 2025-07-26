// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_search/app/screen/Tab/pages/Favorite/provider/favorite_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:image_search/app/screen/UI.dart';

int toggle_index = 0;
Box favImage = Hive.box("fav_image");
List favImage_provider = favImage.values.toList();
Box favText = Hive.box("fav_text");
List favText_provider = favText.values.toList();

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerVO = ref.watch(favoriteProvider); //watch : 감시
    final providerNotifier = ref.read(favoriteProvider.notifier); //read : 쓰기

    print("화면갱신됨");
    print(favImage_provider);
    print(favImage.values);

    return FutureBuilder(
      future: providerToHive(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); //기본제공 로딩바
        } else {
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
                children: [
                  toggle_index == 0
                      ? Wrap(
                        spacing: 10,
                        runSpacing: 15,
                        children: [
                          for (int i = 0; i < favImage_provider.length; i++)
                            image_box(
                              context,
                              favImage_provider[i],
                              checkBool(favImage_provider[i]),
                              () => db_InOut(
                                providerNotifier,
                                favImage_provider[i],
                              ),
                            ),
                        ],
                      )
                      : Column(
                        children: [
                          for (int i = 0; i < favText_provider.length; i++)
                            text_box(
                              context,
                              favText_provider[i],
                              checkBool(favText_provider[i]),
                              () => db_InOut(
                                providerNotifier,
                                favText_provider[i],
                              ),
                            ),
                        ],
                      ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<String> providerToHive() async {
    //DB연동
    if (toggle_index == 0) {
      await favImage.clear();
      for (var item in favImage_provider) {
        await favImage.add(item);
      }
    } else {
      await favText.clear();
      for (var item in favText_provider) {
        await favText.add(item);
      }
    }
    return "success";
  }

  bool checkBool(Map<dynamic, dynamic> detail) {
    //url가 box 내부에 있다면 return true, 없다면 false를 줘서 콘테나 하트를 채우거나 안채우게 해줌
    if (toggle_index == 0) {
      if (favImage_provider.any(
        (item) => item['thumbnail_url'] == detail['thumbnail_url'],
      )) {
        return true;
      } else {
        return false;
      }
    } else {
      if (favText_provider.any((item) => item['url'] == detail['url'])) {
        return true;
      } else {
        return false;
      }
    }
  }

  void db_InOut(dynamic providerNotifier, Map<dynamic, dynamic> detail) {
    //checkBool(detail)에 따라 db 추가, 삭제  여기서하는이유는프로바이더땜시

    if (toggle_index == 0) {
      print("처리 전 : ");
      print(favImage_provider);
      if (checkBool(detail)) {
        favImage_provider.removeWhere(
          (item) => item['thumbnail_url'] == detail['thumbnail_url'],
        );
      } else {
        favImage_provider.add(detail);
      }
      print("처리후 : ");
      print(favImage_provider);
      providerNotifier.favImageP_ = favImage_provider;
    } else {
      print("처리 전 : ");
      print(favText_provider);
      if (checkBool(detail)) {
        favText_provider.removeWhere((item) => item['url'] == detail['url']);
      } else {
        favText_provider.add(detail);
      }
      print("처리후 : ");
      print(favText_provider);
      providerNotifier.favTextP_ = favText_provider;
    }
  }
}
