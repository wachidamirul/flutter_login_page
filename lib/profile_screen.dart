import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_page/login_screen.dart';
import 'package:flutter_login_page/theme_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final box = GetStorage();
  final themeController = Get.put(ThemeController());
  late bool isDarkMode;

  double coverHeight = 280;
  double profileHeight = 144;

  String coverPicture = "";
  String profilePicture = "";
  String userName = "";
  String userBio = "";
  String userAbout = "";

  @override
  void initState() {
    super.initState();
    isDarkMode = themeController.isDarkMode.value;
    loadData(); // Load data when the widget is initialized
  }

  changeTheme() {
    themeController.setTheme(!isDarkMode);
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  // Load data from JSON file with the same userId
  Future<void> loadData() async {
    try {
      String userId = box.read('userId') ?? '';
      String data = await rootBundle.loadString('assets/data.json');
      List<dynamic> users = jsonDecode(data);
      for (var user in users) {
        if (user['id'].toString() == userId) {
          userName = user['name'];
          userBio = user['bio'];
          userAbout = user['about'];
          coverPicture = user['coverPicture'];
          profilePicture = user['profilePicture'];
          break;
        }
      }
    } catch (e) {
      // Handle errors (e.g., file not found or JSON parsing issues)
      print('Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Color(0xFF181818) : Colors.indigo.shade50,
      body: FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView(
              padding: EdgeInsets.zero,
              children: [buildTop(), buildContent()],
            );
          }
        },
      ),
    );
  }

  Widget buildTop() {
    double top = coverHeight - profileHeight / 2;
    double bottom = profileHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(top: top, child: buildProfileImage()),
      ],
    );
  }

  Widget buildCoverImage() {
    return Container(
      height: coverHeight,
      color: isDarkMode ? Colors.black45 : Colors.indigo.shade100,
      child: Image.network(
        coverPicture,
        width: double.infinity,
        height: coverHeight,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value:
                  loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
            ),
          );
        },
      ),
    );
  }

  Widget buildProfileImage() {
    return CircleAvatar(
      radius: profileHeight / 2 + 8, // Add extra radius for the border
      backgroundColor:
          isDarkMode
              ? Color(0xFF181818) // Dark mode background color
              : Colors.indigo.shade50, // Border color
      child: CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: isDarkMode ? Colors.black : Colors.indigo.shade100,
        backgroundImage: NetworkImage(profilePicture),
      ),
    );
  }

  Widget buildContent() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Center(
            child: Column(
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                Text(
                  userBio,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Divider(
            color: isDarkMode ? Colors.indigo.shade700 : Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          buildAboutSection(),
          const SizedBox(height: 32),
          buildSettingsSection(),
          const SizedBox(height: 32),
          buildLogoutButton(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          userAbout,
          style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black87),
        ),
      ],
    );
  }

  Widget buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Settings",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Change Theme to ${isDarkMode ? 'Light' : 'Dark'} Mode",
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
            IconButton(
              icon: Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
              onPressed: changeTheme,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildLogoutButton() {
    return ElevatedButton(
      onPressed: () {
        box.remove("userId");
        box.remove("isDarkMode");
        Get.offAll(LoginScreen());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isDarkMode ? Colors.red.shade700 : Colors.red.shade800,
        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Text("Logout", style: TextStyle(color: Colors.white))],
      ),
    );
  }
}
