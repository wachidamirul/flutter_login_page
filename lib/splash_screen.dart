import 'package:flutter/material.dart';
import 'package:flutter_login_page/dashboard_screen.dart';
import 'package:flutter_login_page/login_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      final box = GetStorage();
      // Check if the user is logged in
      String userId = box.read('userId') ?? '';
      // If the user is logged in, navigate to the dashboard screen
      if (userId.isNotEmpty) {
        Get.off(DashboardScreen());
      } else {
        // If the user is not logged in, navigate to the login screen
        Get.off(LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', width: 100, height: 100),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
