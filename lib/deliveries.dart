// deliveries.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // Import the http package
import 'assets/page_loading.dart';
import 'package:another_flushbar/flushbar.dart';
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';


// Import the pages
import '../user_details.dart';
import 'delivery_request.dart';
import 'home.dart';
import '../account.dart';
import 'user_session.dart';

// Function that returns an OutlineInputBorder with the desired properties
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: const BorderSide(color: Color(0xFF003366), width: 3),
  );
}


// deliveries page widget
class DeliveriesPage extends StatefulWidget {
  final String userEmail;


  // const DeliveriesPage({Key? key}) : super(key: key);

  DeliveriesPage({required this.userEmail, Key? key,}) : super(key: key);

  @override
  _DeliveriesPageState createState() => _DeliveriesPageState();
}

class _DeliveriesPageState extends State<DeliveriesPage> {
  // Assuming you have a reference to your UserSession
  final UserSession userSession = UserSession();


  bool _showPopup = false;
  bool _showSuccess = true; // Add this variable
  String _filter = 'All';


  // Displays an loading message as a popup
  void _showSuccessMessage(String message) {
    Flushbar(
      messageText: Text(message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green.withOpacity(1.0),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.only(top: 70, left: 8, right: 8),
      maxWidth: 350,
      borderRadius: BorderRadius.circular(25),
      duration: const Duration(seconds: 5),
    ).show(context);
  }

// Store the fetched deliveries
  List<Map<String, dynamic>> _deliveries = [];


  @override
  void initState() {
    super.initState();




    final userSession = Provider.of<UserSession>(context, listen: false);
    final userEmail = userSession.getUserEmail() ?? '';
    // print('User Email: $userEmail');

    _showSuccessMessage('Loading, please wait.');

    fetchDeliveriesAndSendEmail(userEmail, 'All'); // Fetch with "All" filter initially

    // _showSuccess = false;


  }

  Future<void> fetchDeliveriesAndSendEmail(String userEmail, String dateFilter) async {


    // print('Fetching deliveries with filter: $dateFilter');
    final apiUrl = 'http://127.0.0.1:8000/fetch_deliveries/?userEmail=$userEmail&dateFilter=$dateFilter';

    try {
      final emailResponse = await http.get(Uri.parse(apiUrl));

      if (emailResponse.statusCode == 200) {

        print('Email sent to backend successfully');

        final deliveriesUrl = Uri.parse(apiUrl);
        final deliveriesResponse = await http.get(deliveriesUrl);

        if (deliveriesResponse.statusCode == 200) {



          final Map<String, dynamic> jsonData = json.decode(deliveriesResponse.body);
          final List<dynamic> deliveries = jsonData['deliveries'];

          setState(() {
            // _showSuccess = false;
            _deliveries = deliveries.cast<Map<String, dynamic>>();

          });

          setState(() {
            _showSuccess = false;
          });

        } else {
          print('Failed to fetch deliveries: ${deliveriesResponse.statusCode}');
        }
      } else {
        final errorResponse = json.decode(emailResponse.body);
        final errorMessage = errorResponse['error'];
        print('Failed to send email to backend: $errorMessage');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {




    // Get the screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (_showPopup) {
                setState(() => _showPopup = false);
              }
            },
            child: SafeArea(
                child: Stack(
                    children: [
                      Column(
                          children: [
// Nav bar
                            Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // "All Deliveries" text
                                      Text("All Deliveries", style: TextStyle(fontFamily: 'Nunito', color: Color(0xFF003366), fontSize: 6.sp, fontWeight: FontWeight.bold)),
                                      // Empty Container to take up space on the left
                                      Container(),
// Profile picture
//                                       Positioned(
//                                         top: MediaQuery.of(context).padding.top + 30, left: screenWidth * 0.05,
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             setState(() {
//
//                                               // view profile pic
//                                             });
//                                           },
//                                           child: CircleAvatar(
//                                             radius: screenWidth * 0.04, backgroundColor: Colors.grey,
//                                             child:
//                                             Icon(Icons.person, size: screenWidth * 0.04, color: Colors.white),
//                                           ),
//                                         ),
//                                       ),

// Menu
                                      Row(children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: screenHeight * 0.02),
                                          child: Container(width: screenWidth * 0.15, height: screenHeight * 0.07,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(screenWidth * 0.05),
                                                border: Border.all(color: const Color(0xFF003366), width: 2)
                                            ),
                                            child: Theme(
                                              data: Theme.of(context).copyWith(
                                                cardColor: Colors.white,
                                                popupMenuTheme: PopupMenuThemeData(
                                                  shape: RoundedRectangleBorder(
                                                    side: const BorderSide(color: Color(0xFF00a896), width: 2), // This gives the menu an outline
                                                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left: screenWidth * 0.01),
                                                    child: Text(
                                                      _filter,
                                                      style: TextStyle(fontSize: screenWidth * 0.012, color: Color(0xFF003366)),
                                                    ),
                                                  ),

                                                  // This is to give some space at the start
                                                  MouseRegion(
                                                    cursor: SystemMouseCursors.click,
                                                    child: InkWell(
                                                      onTap: () {},
                                                      child: PopupMenuButton<String>(
                                                        icon: Icon(Icons.arrow_drop_down, size: screenHeight  * 0.04, color: const Color(0xFF003366)),
                                                        itemBuilder: (context) => [
                                                          PopupMenuItem(
                                                            child: Text('All', style: TextStyle(fontSize: screenWidth * 0.013, color: Color(0xFF003366))), // This changes the text color
                                                            value: 'All',
                                                          ),
                                                          PopupMenuItem(
                                                            child: Text('Today', style: TextStyle(fontSize: screenWidth * 0.013, color: Color(0xFF003366))), // This changes the text color
                                                            value: 'Today',
                                                          ),
                                                          PopupMenuItem(
                                                            child: Text('Last 7 days', style: TextStyle(fontSize: screenWidth * 0.013, color: Color(0xFF003366))), // This changes the text color
                                                            value: 'Last 7 days',
                                                          ),
                                                          PopupMenuItem(
                                                            child: Text('Last month', style: TextStyle(fontSize: screenWidth * 0.013, color: Color(0xFF003366))), // This changes the text color
                                                            value: 'Last month',
                                                          ),
                                                          PopupMenuItem(
                                                            child: Text('Older', style: TextStyle(fontSize: screenWidth * 0.013, color: Color(0xFF003366))), // This changes the text color
                                                            value: 'Older',
                                                          ),
                                                        ],
                                                        onSelected: (String? newValue) {
                                                          setState(() {
                                                            _filter = newValue!;
                                                            fetchDeliveriesAndSendEmail(widget.userEmail, _filter); // Call the function with the selected date filter
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  )

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: screenWidth * 0.015),

                                        // Nav bar icon
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() => _showPopup = !_showPopup);
                                            },
                                            child: Icon(Icons.menu, color: const Color(0xFF003366), size: screenWidth * 0.04,
                                            ),
                                          ),
                                        )
                                      ])
                                    ])),

                            Expanded(child:
                            SingleChildScrollView(child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center, children: [
                              Stack(clipBehavior: Clip.none, children: [
                                Form(child:
                                Column(children: [
                                  Padding(padding:
                                  EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
                                      child:
                                      const Row(mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Text('All Deliveries',
                                            //     style: TextStyle(fontSize: 20, fontFamily: 'Nunito', color: Color(0xFF003366), fontWeight: FontWeight.bold)),
                                          ])),

                                  // Use ListView.builder to display deliveries
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: _deliveries.length,
                                    itemBuilder: (context, index) {
                                      final delivery = _deliveries[index];
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                                        child: Container(
                                          width: 1080,
                                          height: 115,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(color: const Color(0xFF003366), width: 2),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Order number:${delivery['orderNumber']}',
                                                              style: const TextStyle(color: Color(0xFF003366), fontWeight: FontWeight.bold)),
                                                          Text('Customer name: ${delivery['customerName']}',
                                                              style: const TextStyle(color: Color(0xFF003366), fontWeight: FontWeight.bold)),
                                                          Text('Customer location: ${delivery['customerLocation']}',
                                                              style: const TextStyle(color: Color(0xFF003366), fontWeight: FontWeight.bold)),
                                                          Text('Rider: ${delivery['rider']}',
                                                              style: const TextStyle(color: Color(0xFF003366), fontWeight: FontWeight.bold)),
                                                          Text('Delivery Instructions: ${delivery['extraInstructions'] == "NULL" ? 'None' : delivery['extraInstructions']}',
                                                              style: const TextStyle(color: Color(0xFF003366), fontWeight: FontWeight.bold)),
                                                        ]),

                                                    const Spacer(),
                                                    Align(
                                                      alignment: Alignment.bottomRight,
                                                      child: Container(width: 100, height: 30,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(15),
                                                          color: const Color(0xFF00a896),
                                                        ),
                                                        child: Center(
                                                          child: Text(delivery['status'],
                                                            style: TextStyle(
                                                              color: delivery['status'] == 'To Assign' ? Colors.red
                                                                  : delivery['status'] == 'To Pick Up' ? Colors.yellow
                                                                  : delivery['status'] == 'En-Route' ? const Color(0xFF1B5E20)
                                                                  : const Color(0xFF003366),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                                ),
                                ),
                              ],
                              ),
                            ],
                            ),
                            )
                            ),
                          ]),

                      // Popup menu
                      if (_showPopup)
                        Positioned(
                          top: MediaQuery.of(context).padding.top + 100,
                          right: 35,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.height * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                              border: Border.all(color: const Color(0xFF00a896), width: 2),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  SizedBox(height: screenHeight * 0.01),
                                  // Home button
                                  ListTile(
                                    leading:
                                    const Icon(Icons.home, color:  Color(0xFF003366), size: 44),
                                    title: const Text('Home',
                                        style: TextStyle(fontSize: 20, fontFamily:'Nunito', fontWeight : FontWeight.bold, color: Color(0xFF00a896))),
                                    onTap : () {
                                      // Navigate to the home page

                                      Navigator.pushNamed(context, '/home');                                    },
                                  ), const SizedBox(height: 40),

                                  // Deliveries button
                                  ListTile(
                                    leading:
                                    const Icon(Icons.motorcycle, color:  Color(0xFF003366), size: 44),
                                    title:  const Text('Deliveries',
                                        style: TextStyle(fontSize: 20, fontFamily:'Nunito', fontWeight : FontWeight.bold, color: Color(0xFF00a896))),
                                    onTap : () {
                                      final userSession = Provider.of<UserSession>(context, listen: false);
                                      final userEmail = userSession.getUserEmail() ?? '';

                                      Navigator.pushNamed(context, '/home');
                                    },
                                  ), const SizedBox(height: 40),

                                  // Log out button
                                  ListTile(
                                    leading:
                                    const Icon(Icons.logout, color:  Color(0xFF003366), size: 44),
                                    title: const Text('Log Out',
                                        style: TextStyle(fontSize: 20, fontFamily:'Nunito', fontWeight : FontWeight.bold, color: Color(0xFF00a896))),
                                    onTap : () {

                                      // Clear the user session
                                      userSession.clearSession();

                                      // Log out and navigate to the login page
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                                    },
                                  ), const SizedBox(height: 210),

                                  // My account section
                                  Padding(padding : const EdgeInsets.all(8.0),
                                      child : Row(mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                          children:[
                                            ElevatedButton(onPressed : () {

                                              Navigator.pushNamed(context, '/myAccount');
                                              }, child : const Text('My Account',
                                                style : TextStyle(color : Colors.white)),
                                                style : ElevatedButton.styleFrom(primary : const Color(0xFF00a896),
                                                    shape : RoundedRectangleBorder(borderRadius : BorderRadius.circular(25)))),
                                            // const CircleAvatar(radius : 20, backgroundColor : Colors.grey,

                                            //  Replace with the actual profile picture of the rider
                                            //     child : Icon(Icons.person, size : 40, color : Colors.white))
                                          ])),
                                ]),
                          ),
                        ),
                    ])
            )));
  }
}