import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, required this.userId});
  final String userId;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDarkMode = false;
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
    loadData(); // Load data when the widget is initialized
  }

  changeTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  // Load data from JSON file with the same userId
  Future<void> loadData() async {
    try {
      String data = await rootBundle.loadString('assets/data.json');
      List<dynamic> users = jsonDecode(data);
      for (var user in users) {
        if (user['id'].toString() == widget.userId) {
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
      backgroundColor:
          isDarkMode ? Colors.indigo.shade900 : Colors.indigo.shade50,
      body: SafeArea(
        child: FutureBuilder(
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
      color: Colors.grey.shade300,
      child: Image.network(
        coverPicture,
        width: double.infinity,
        height: coverHeight,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildProfileImage() {
    return CircleAvatar(
      radius: profileHeight / 2,
      backgroundColor: Colors.grey.shade200,
      backgroundImage: NetworkImage(profilePicture),
    );
  }

  Widget buildContent() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Center(
            child: Column(
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white70 : Colors.black87,
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
          Text(
            "About",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            userAbout,
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: isDarkMode ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Settings",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: isDarkMode ? Colors.white70 : Colors.black87,
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
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
