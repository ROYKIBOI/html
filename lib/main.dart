// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


// Import the pages
import 'user_details.dart';
import 'user_session.dart';
import 'home.dart';
import 'deliveries.dart';
import 'delivery_request.dart';
import 'account.dart';
import 'assets/splash_screen.dart';

// The main function that runs the app
void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserSession()), // Your UserSession provider
      // Other providers if needed
    ],
    // create: (context) => DeliveryModel(),
    child: MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // Fetch deliveries and send email to backend when the widget is initialized
    final userSession = Provider.of<UserSession>(context, listen: false);
    final userEmail = userSession.getUserEmail() ?? '';

    return ScreenUtilInit(
        designSize: const Size(360, 690),
    builder: (BuildContext context, Widget? child) {
    return MaterialApp(
        title: 'tuma.today',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),



      routes: {

        '/': (context) => LoginPage(), // Define the root route to load the HomePage
        '/home': (context) => HomePage(),
        '/signup': (context) => SignUpPage(),
        '/deliveries': (context) => DeliveriesPage(userEmail: userEmail),
        '/businessAccount': (context) => BusinessDetailsPage(),
        '/myAccount': (context) => AccountPage(),
        '/deliveryRequest': (context) => DeliveryRequestPage(deliveries: const [],userEmail: userEmail),
        '/forgotPassword': (context) => ForgotPasswordPage(),
        '/resetPassword': (context) => ResetPasswordPage(email: userEmail),
        '/splashscreen': (context) => SplashScreen(),
        // '/flushbarRoute': (context) => LoginPage(),
        // Define other named routes as needed
      },
      // home: const LoginPage(),
      );
  });
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