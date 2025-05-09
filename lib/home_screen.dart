import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_page/navbar_controller.dart';
import 'package:flutter_login_page/profile_screen.dart';
import 'package:flutter_login_page/theme_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final themeController = Get.put(ThemeController());
  final navbarController = Get.put(NavbarController());
  final iconList = <IconData>[Icons.home, Icons.person];
  final screenList = <Widget>[
    const Center(child: Text('Home')),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkMode = themeController.isDarkMode.value;

      return Scaffold(
        backgroundColor: isDarkMode ? Color(0xFF181818) : Colors.indigo.shade50,
        body: IndexedStack(
          index: navbarController.getIndex(),
          children: screenList,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Handle floating action button press
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add_rounded),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          backgroundColor: isDarkMode ? Color(0xFF1D1E24) : Colors.white,
          activeColor: isDarkMode ? Colors.indigo.shade300 : Colors.black,
          inactiveColor: isDarkMode ? Colors.white70 : Colors.black54,
          icons: iconList,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.defaultEdge,
          activeIndex: navbarController.getIndex(),
          onTap: (index) => setState(() => navbarController.setIndex(index)),
        ),
      );
    });
  }
}
