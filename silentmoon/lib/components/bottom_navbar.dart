import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:silentmoon/app/configs/theme.dart';
import 'package:silentmoon/pages/home_page.dart';
import 'package:silentmoon/pages/meditate_page.dart';
import 'package:silentmoon/pages/music_page.dart';
import 'package:silentmoon/pages/profile_page.dart';
import 'package:silentmoon/pages/sleep_page.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(() {
        // Change bottom bar background color when on SleepPage
          bool isSleepPage = controller.selectedIndex.value == 1;
          Color backgroundColor = isSleepPage ? ThemeConfigs.color1 : ThemeConfigs.color2;
          Color indicatorColor = ThemeConfigs.color3;
          Color labelColor = isSleepPage ? ThemeConfigs.color3 : ThemeConfigs.color24;

        return NavigationBarTheme(
          data: NavigationBarThemeData(
              labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return TextStyle(color: labelColor, fontWeight: FontWeight.bold);
                  }
                  return const TextStyle(color: Colors.black);
                },
              ),
            ),

          child: NavigationBar(
            height: 80,
            elevation: 0,
            backgroundColor: backgroundColor,
            indicatorColor: indicatorColor,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected:
                (index) => controller.selectedIndex.value = index,
            destinations: const [
              NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
              NavigationDestination(icon: Icon(Iconsax.moon), label: 'Sleep'),
              NavigationDestination(
                icon: Icon(Iconsax.add_circle),
                label: 'Meditate',
              ),
              NavigationDestination(icon: Icon(Iconsax.music), label: 'Music'),
              NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
            ],
          ),
        );
      }),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomePage(),
    const SleepPage(),
    const MeditatePage(),
    const MusicPage(),
    const ProfilePage(),
  ];
}
