// main.dart
import 'package:flutter/material.dart';
import 'assets/splash_screen.dart'; // Import the splash screen
import 'assets/responsive_design.dart'; // Import the responsive design widget
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';
import 'assets/routes.dart';

// Import the pages
import 'user_details.dart';
import 'package:client_app/account.dart';
import 'package:client_app/deliveries.dart';
import 'package:client_app/delivery_request.dart';
import 'package:client_app/home.dart';

// The main function that runs the app
void main() {
  final router = FluroRouter();
  Routes.configureRoutes(router);
  runApp(
    ChangeNotifierProvider(
      create: (context) => DeliveryModel(),
      child: MyApp(router),
    ),
  );
}

class MyApp extends StatelessWidget {
  final FluroRouter router;

  MyApp(this.router, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveDesign(
      child: MaterialApp(
      title: 'tuma.today',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: router.generator,
      //home: const SplashScreen(nextPage: LoginPage()), // Use the imported splash screen

      initialRoute: '/',
      routes: {
     '/': (context) => const SplashScreen(nextPage: LoginPage()),
        '/login': (context) => const LoginPage(),
        '/signUp': (context) => const SignUpPage(),
        '/forgotPassword': (context) => ForgotPasswordPage(),
        '/resetPassword': (context) => const ResetPasswordPage(),
        '/businessDetails': (context) => const BusinessDetailsPage(),
        '/myAccount': (context) => const AccountPage(),
        '/deliveries': (context) => const DeliveriesPage(deliveries: [],),
        '/deliveryRequest': (context) => DeliveryRequestPage(deliveries: const [],),
        '/home': (context) => const HomePage(),
      },
    )
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

















