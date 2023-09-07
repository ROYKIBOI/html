// main.dart
import 'package:flutter/material.dart';
import 'assets/splash_screen.dart'; // Import the splash screen
import 'assets/responsive_design.dart'; // Import the responsive design widget
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

// Import the pages
import 'login_signup_forgot_reset_business_details_page.dart';


// The main function that runs the app
void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => DeliveryModel(),
    child: MyApp(),
  ),
);

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

class DeliveryModel extends ChangeNotifier {
  List<Map<String, dynamic>> _deliveries = [];

  List<Map<String, dynamic>> get deliveries => _deliveries;

  void addDelivery(Map<String, dynamic> delivery) {
    _deliveries.add(delivery);
    notifyListeners();
  }
}

















