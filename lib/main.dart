// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


// Import the pages
import 'user_details.dart';
import 'user_session.dart';

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
    return ScreenUtilInit(
        designSize: const Size(360, 690),
    builder: (BuildContext context, Widget? child) {
    return MaterialApp(
        title: 'tuma.today',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
    home: const LoginPage(),
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