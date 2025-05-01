import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_page/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Define a boolean variable to control the visibility of the password
  bool isObscure = true;
  showPassword() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  // Define controllers for the text fields
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  handleLogin() async {
    // Get the values from the text fields
    String email = emailController.text;
    String password = passwordController.text;
    String userId = '';

    // Validate the input values
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter email and password'),
          backgroundColor: Colors.red[700],
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      // Load and parse the JSON data
      String data = await rootBundle.loadString('assets/data.json');
      List<dynamic> users = jsonDecode(data);

      // Check if the email and password match any user
      bool isValidUser = false;
      for (var user in users) {
        if (user['email'] == email && user['password'] == password) {
          isValidUser = true;
          // Get the user ID
          userId = user['id'].toString();
          break;
        }
      }

      if (isValidUser) {
        // Show success message or navigate to the home screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login successful!'),
            backgroundColor: Colors.green[700],
            duration: Duration(seconds: 2),
          ),
        );
        // Navigate to the home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(userId: userId)),
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid email or password'),
            backgroundColor: Colors.red[700],
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Handle errors (e.g., file not found or JSON parsing issues)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red[700],
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(Icons.lock, size: 100),
                  SizedBox(height: 8),
                  Text(
                    'Welcome back, you\'ve been missed!',
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                  SizedBox(height: 40),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo[200]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo[900]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      labelText: 'Email',
                      hintText: "Enter your Email",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo[200]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo[900]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      labelText: 'Password',
                      hintText: "Enter your password",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: showPassword,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      handleLogin();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo[800],
                      padding: EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Login", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
