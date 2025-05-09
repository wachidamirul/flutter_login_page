import 'package:flutter/material.dart';
import 'package:flutter_login_page/theme_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkMode = themeController.isDarkMode.value;

      return Scaffold(
        backgroundColor: isDarkMode ? Color(0xFF181818) : Colors.indigo.shade50,
        body: Center(
          child: Text(
            'Home',
            style: TextStyle(fontSize: 24, color: Colors.indigo.shade500),
          ),
        ),
      );
    });
  }
}
