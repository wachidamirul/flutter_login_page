import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_page/home_screen.dart';
import 'package:flutter_login_page/navbar_controller.dart';
import 'package:flutter_login_page/note_screen.dart';
import 'package:flutter_login_page/profile_screen.dart';
import 'package:flutter_login_page/theme_controller.dart';
import 'package:get/get.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  final themeController = Get.put(ThemeController());
  final navbarController = Get.put(NavbarController());
  final iconList = <IconData>[Icons.home, Icons.person];
  final screenList = <Widget>[
    const HomeScreen(),
    const ProfileScreen(),
    const NoteScreen(),
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
          onPressed: () => navbarController.setIndex(2),
          backgroundColor: Colors.indigo.shade500,
          shape: const CircleBorder(),
          child: Icon(Icons.add_rounded, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          backgroundColor: isDarkMode ? Color(0xFF1D1E24) : Colors.white,
          activeColor:
              isDarkMode ? Colors.indigo.shade300 : Colors.indigo.shade800,
          inactiveColor:
              isDarkMode ? Colors.indigo.shade100 : Colors.indigo.shade200,
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
