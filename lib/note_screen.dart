import 'package:flutter/material.dart';
import 'package:flutter_login_page/theme_controller.dart';
import 'package:get/get.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkMode = themeController.isDarkMode.value;

      return Scaffold(
        backgroundColor: isDarkMode ? Color(0xFF181818) : Colors.indigo.shade50,
        body: Center(
          child: Text(
            'Note',
            style: TextStyle(fontSize: 24, color: Colors.indigo.shade500),
          ),
        ),
      );
    });
  }
}
