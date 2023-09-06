// main.dart
import 'package:flutter/material.dart';
import 'assets/splash_screen.dart'; // Import the splash screen
import 'assets/responsive_design.dart'; // Import the responsive design widget


// Import the pages
import 'login_signup_forgot_reset_business_details_page.dart';


// The main function that runs the app
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveDesign(
      child: MaterialApp(
        title: 'tuma.today',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(nextPage: LoginPage()), // Use the imported splash screen
      ),
    );
  }
}



















