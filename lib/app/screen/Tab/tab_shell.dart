import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_search/app/screen/Tab/provider/tab_provider.dart';

class TabShell extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  const TabShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerVO = ref.watch(tabProvider);
    final providerNotifier = ref.read(tabProvider.notifier);
    
    return Scaffold(
      body: Center(child: navigationShell),
      bottomNavigationBar: BottomNavigationBar( 
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xff6667ab),
        backgroundColor: Color(0xFFa3a3e0),
        showUnselectedLabels: false,
        currentIndex: providerVO.bottomNavigationBarIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_camera), label: "image",),
          BottomNavigationBarItem(icon: Icon(Icons.description), label: "text"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "favorite"),
        ],
        onTap: (i) {
          providerNotifier.bottomNavigationBarIndex = i;
          navigationShell.goBranch(i);
        },
      ),
    );
  }
}
