import 'package:flutter/material.dart';
import 'package:flutter_login_page/login_screen.dart';
import 'package:flutter_login_page/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.nama});
  final String nama;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo[600],
        foregroundColor: Colors.white,
        title: const Text('Home Screen', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Handle logout action
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hi ${nama}, Welcome to the Home Screen",
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator to login screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[600],
                  foregroundColor: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text("Go to Profile"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
