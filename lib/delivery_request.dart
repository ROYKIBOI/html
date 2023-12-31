// delivery_request.dart
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:html' as html;


import 'dart:convert';
import 'assets/page_loading.dart';

// Import the pages
import '../user_details.dart';
import 'home.dart';
import 'deliveries.dart';
import '../account.dart';
import 'user_session.dart';



// Function that returns an OutlineInputBorder with the desired properties
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: const BorderSide(color: Color(0xFF003366), width: 3),
  );
}

// DELIVERY REQUEST WIDGET
class DeliveryRequestPage extends StatefulWidget {
  final List<Map<String, dynamic>> deliveries;
  final String userEmail; //  line to accept the userEmail

  DeliveryRequestPage({
    required this.deliveries,
    required this.userEmail,
  });

  @override
  _DeliveryRequestPageState createState() => _DeliveryRequestPageState();
}

class _DeliveryRequestPageState extends State<DeliveryRequestPage> {
  // Assuming you have a reference to your UserSession
  final UserSession userSession = UserSession();


  late List<Map<String, dynamic>> _deliveries;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _pickController = TextEditingController();
  final _locationController = TextEditingController();
  final _instructionsController = TextEditingController();
  final places = GoogleMapsPlaces(apiKey: "AIzaSyC6peV2tSrAFIWVTEeHxJ2GvESfN_DmTto");

  final _costController = TextEditingController(text: NumberFormat("#,###").format(0));

  bool _showPopup = false;

  // final _nameKey = GlobalKey<CustomTextFormFieldState>();
  // final _contactKey = GlobalKey<CustomTextFormFieldState>();
  // final _locationKey = GlobalKey<CustomTextFormFieldState>();

  final _nameFocusNode = FocusNode();
  final _contactFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();
  final _pickFocusNode = FocusNode();
  final _instructionsFocusNode = FocusNode();

  // Displays an error message as a popup with red, almost transparent background at the top center of the window for 15 seconds
  void _showErrorMessage(String message) {
    Flushbar(
      messageText: Text(message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.transparent,
      // Set backgroundColor to transparent
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.only(top: 80, left: 20, right: 2),
      maxWidth: 350,
      borderRadius: BorderRadius.circular(25),
      duration: const Duration(seconds: 10),
    ).show(context);
  }

  void showNotification(BuildContext context, String message, Color color) {
    final overlay = Overlay.of(context)!;
    final overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        top: 50,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(message,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      );
    });

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 10), () {
      overlayEntry.remove();
    });
  }


  void _handleConfirmation() {
    Navigator.pop(context); // Close the confirmation dialog


    final userSession = Provider.of<UserSession>(context, listen: false);
    final userEmail = userSession.getUserEmail() ?? '';

    // Navigate to DeliveriesPage and wait for it to return a result
    Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryRequestPage(deliveries: _deliveries,userEmail: userEmail),
    ),
    );

    // Clear the input fields
    _nameController.clear();
    _contactController.clear();
    _locationController.clear();
    _pickController.clear();
    _instructionsController.clear();
    _costController.clear();

    // Show Done/New dialog
    showDialog(
      context: context, builder: (context) {
      return NewDonePopup(
        handleNew: () {
          Navigator.pop(context); // Close the new/done dialog
          _nameController.clear();
          _contactController.clear();
          _pickController.clear();
          _locationController.clear();
          _instructionsController.clear();
          _costController.clear();

          final userSession = Provider.of<UserSession>(context, listen: false);
          final userEmail = userSession.getUserEmail() ?? '';

          // Pop this page and pass back the updated list of deliveries
          Navigator.pop(context, _deliveries);

          // Navigate to the delivery request page


          Navigator.pushNamed(context, '/deliveryRequest');
        },
        handleDone: () {
          final userSession = Provider.of<UserSession>(context, listen: false);
          final userEmail = userSession.getUserEmail() ?? '';

          Navigator.pushNamed(context, '/home');         },
      );
    },
    );

    // Clear the input fields
    _nameController.clear();
    _contactController.clear();
    _pickController.clear();
    _locationController.clear();
    _instructionsController.clear();
    _costController.clear();


  }

  Future<void> _sendDeliveryRequest() async {
    final apiUrl = 'http://localhost:8000/save_delivery_request/';

    try {

      final userSession = Provider.of<UserSession>(context, listen: false);
      final userEmail = userSession.getUserEmail() ?? '';

      final requestBody = {
        'customerName': _nameController.text,
        'customerContact': _contactController.text,
        'pickLocation': _pickController.text,
        'deliveryLocation': _locationController.text,
        'instructions': _instructionsController.text,
        'cost': _costController.text,
        'userEmail': userEmail,
      };


      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Show notification message
        showNotification(context, 'Order successfully placed!', Colors.green);

      } else {
        _showErrorMessage('Failed to send delivery request: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorMessage('Error sending delivery request: $e');
    }
  }

  // In your _AccountPageState class
  Map<String, dynamic> _clientDetails = {};

  @override
  void initState() {
    super.initState();

    // Initialize _deliveries with the list of deliveries passed from DeliveriesPage
    _deliveries = widget.deliveries;

    //For the pickup prefill
    final userSession = Provider.of<UserSession>(context, listen: false);
    final userEmail = userSession.getUserEmail() ?? '';

    fetchBusinessDetails(userEmail).then((details) {
      setState(() {
        _clientDetails = details;
      });

      // print('Fetched Business Details: $_clientDetails');

    }).catchError((error) {
      print('Error fetching business details: $error');
    });
  }



  // To print the prefill location
  // Function to fetch business details
  Future<Map<String, dynamic>> fetchBusinessDetails(String userEmail) async {
    final apiUrl = 'http://127.0.0.1:8000/get_client_details/?userEmail=$userEmail';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch business details');
    }
  }
  // void initState() {
  //   super.initState();
  //   final userSession = Provider.of<UserSession>(context, listen: false);
  //   final userEmail = userSession.getUserEmail() ?? '';
  //
  //   fetchBusinessDetails(userEmail).then((details) {
  //     setState(() {
  //       _clientDetails = details;
  //     });
  //
  //     // print('Fetched Business Details: $_clientDetails');
  //
  //   }).catchError((error) {
  //     print('Error fetching business details: $error');
  //   });
  // }





  @override
  Widget build(BuildContext context) {
    // You can access the user's email using widget.userEmail
    //final userEmail = widget.userEmail;
    // Print the user's email to the console for testing
    // print('User Email: $userEmail');


    // Fetched business details
    final String businessLocation = _clientDetails['businessLocation']?.toUpperCase() ?? '';


    return Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() => _showPopup = false);
          },
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    // Nav bar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20,),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // "Request A Delivery" text
                            Text("Request Delivery", style: TextStyle(fontFamily: 'Nunito', color: Color(0xFF003366), fontSize: 6.sp, fontWeight: FontWeight.bold)),
                            // Empty Container to take up space on the left
                            Container(),

                            // Profile picture
                            // Positioned(
                            //   top: MediaQuery.of(context).padding.top + 30, left: 30,
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       setState(() {
                            //         // view profile pic
                            //       });
                            //     },
                            //     child: const CircleAvatar(radius: 40, backgroundColor: Colors.grey,
                            //
                            //       // Replace with the actual profile picture of the rider
                            //       child: Icon(Icons.person, size: 60, color: Colors.white),
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(width: 300),

                            // Menu
                            Row(
                              children: [
                                const SizedBox(width: 50),

                                // Nav bar icon
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() => _showPopup = !_showPopup);
                                    },
                                    child: Icon(Icons.menu, color: Color(0xFF003366), size: 50,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ]
                      ),
                    ),


                    Expanded(
                      child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Form(key: _formKey,
                                    child: Column(
                                        children: [
                                      Transform.translate(
                                        offset: const Offset(0, -50),
                                        child: Container(width: 350, height: 500,
                                          decoration: BoxDecoration(color: Colors.white,
                                            border: Border.all(color: const Color(0xFF00a896), width: 3),
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child:
                                          Column(children: [
                                            const SizedBox(height: 60),
                                            SizedBox(width: 300, height: 40,
                                              child: TextFormField(
                                                controller: _nameController,
                                                focusNode: _nameFocusNode,
                                                textAlign: TextAlign.center,
                                                style:  TextStyle(color: Colors.white, fontSize: 3.sp, fontFamily: 'Nunito', fontWeight: FontWeight.w100),
                                                decoration: InputDecoration(
                                                  hintText: 'Customer Name',
                                                    hintStyle:  TextStyle( color: Colors.white, fontSize: 3.sp, fontFamily: 'Nunito'),
                                                    fillColor: const Color(0xFF00a896),
                                                    filled: true,
                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 80)),),),
                                            const SizedBox(height: 30),

                                            SizedBox(width: 300, height: 40,
                                              child: TextFormField(
                                                controller: _contactController,
                                                focusNode: _contactFocusNode,
                                                textAlign: TextAlign.center,
                                                style:  TextStyle(color: Colors.white, fontSize: 3.sp, fontFamily: 'Nunito', fontWeight: FontWeight.w100),
                                                decoration: InputDecoration(
                                                  hintText: 'Customer Contact',
                                                    hintStyle:  TextStyle( color: Colors.white,fontSize: 3.sp, fontFamily: 'Nunito'),
                                                    fillColor: const Color(0xFF00a896),
                                                    filled: true,
                                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 80)),),),
                                            const SizedBox(height: 30),


                                            SizedBox(
                                              width: 300, height: 40, child:
                                            TextFormField(
                                              controller: _instructionsController,
                                              focusNode: _instructionsFocusNode,
                                              textAlign: TextAlign.center,
                                              style:  TextStyle(color: Colors.white, fontSize: 3.sp, fontFamily: 'Nunito', fontWeight: FontWeight.w100),
                                              decoration: InputDecoration(
                                                  hintText: 'Extra Instructions',
                                                  hintStyle:  TextStyle( color: Colors.white, fontSize: 3.sp, fontFamily: 'Nunito'),
                                                  fillColor: const Color(0xFF00a896),
                                                  filled: true,
                                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 80)),),),
                                            const SizedBox(height: 15),


                                            SizedBox(width: 300, height: 40,
                                              child: Stack(
                                                alignment: Alignment.centerLeft,
                                                children: [
                                                  TextFormField(
                                                    controller: _pickController,
                                                    focusNode: _pickFocusNode,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(color: Colors.white, fontSize: 3.sp, fontFamily: 'Nunito', fontWeight: FontWeight.w100),
                                                    decoration: InputDecoration(
                                                        hintText: businessLocation,
                                                        hintStyle: TextStyle(color: Colors.white, fontSize: 3.sp, fontFamily: 'Nunito'),
                                                        fillColor: const Color(0xFF00a896),
                                                        filled: true,
                                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                                        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 50)
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 25),
                                                    child: Text('Pick up:', style: TextStyle(color: Colors.white,fontWeight: FontWeight.w100)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 20.h),


                                            SizedBox(
                                              width: 300,
                                              height: 40,
                                              child: Stack(
                                                alignment: Alignment.centerLeft,
                                                children: [
                                                  TextFormField(
                                                    controller: _locationController,
                                                    focusNode: _locationFocusNode,
                                                    onTap: () async {
                                                      // Show location autocomplete when the text field is tapped.
                                                      Prediction p = await PlacesAutocomplete.show(
                                                        context: context,
                                                        apiKey: "AIzaSyC6peV2tSrAFIWVTEeHxJ2GvESfN_DmTto",
                                                        mode: Mode.overlay, // Mode.fullscreen
                                                        language: "en",
                                                        components: [Component(Component.country, "ke")],
                                                      );

                                                      if (p != null) {
                                                        // Get details of the place and set it as the text field's value.
                                                        PlacesDetailsResponse detail =
                                                        await places.getDetailsByPlaceId(p.placeId);
                                                        _locationController.text = detail.result.formattedAddress;
                                                      }
                                                    },
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 3.sp,
                                                        fontFamily: 'Nunito',
                                                        fontWeight: FontWeight.w100),
                                                    decoration: InputDecoration(
                                                      hintText: 'Delivery Location',
                                                      hintStyle:
                                                      TextStyle(color: Colors.white, fontSize: 3.sp, fontFamily: 'Nunito'),
                                                      fillColor: const Color(0xFF00a896),
                                                      filled: true,
                                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                                      contentPadding:
                                                      const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 25),
                                                    child:
                                                    Text('Deliver:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w100)),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            SizedBox(height: 20.h),




                                            Padding(
                                              padding: EdgeInsets.only(left: 10.w, top: 10.h),
                                              child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text('Cost (KES):',
                                                          style: TextStyle( color: Colors.black, fontFamily: 'Nunito', fontWeight: FontWeight.bold),
                                                        ),
                                                        SizedBox(height: 5.h),

                                                        Container( width: 30.w, height: 35.h,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(6.w), color: Colors.white, border: Border.all(
                                                              color: const Color(0xFF00a896)),
                                                          ),
                                                          child: TextFormField(
                                                            controller: _costController,
                                                            readOnly: true, // Makes the TextFormField non-editable
                                                            keyboardType: TextInputType.number, // Makes the TextFormField only accept numbers
                                                            style: TextStyle(color: Color(0xFF003366), fontSize: 6.sp, fontFamily: 'Nunito', fontWeight: FontWeight.bold),
                                                            decoration: InputDecoration(
                                                              contentPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 3.w),
                                                              border: InputBorder.none,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 30.h),


                                            Padding(
                                              padding: EdgeInsets.only(left: 0.w),

                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,

                                                children: [


                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 90),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          // Check if any of the fields are empty
                                                          if (_nameController.text.isEmpty ||
                                                              _contactController.text.isEmpty ||
                                                              _locationController.text.isEmpty) {
                                                            // Show error message if either one or all fields are empty
                                                            _showErrorMessage('Please fill in all the fields');
                                                            return;
                                                          }

                                                          // Check and set default value for instructions
                                                          String instructions = _instructionsController.text.trim();
                                                          if (instructions.isEmpty) {
                                                            instructions = 'No instruction';
                                                          }

                                                          // Show confirmation dialog
                                                          showDialog(
                                                            barrierDismissible: false,
                                                            context: context,
                                                            builder: (context) {
                                                              return ConfirmDetailsPopup(
                                                                name: _nameController.text,
                                                                contact: _contactController.text,
                                                                location: _locationController.text,
                                                                cost: _costController.text,
                                                                instructions: instructions,
                                                                handleConfirmation: _handleConfirmation,
                                                              );
                                                            },
                                                          );
                                                          _sendDeliveryRequest();
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          primary: const Color(0xFF003366),
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                        ),
                                                        child: const Text('Place Order', style: TextStyle(color: Colors.white)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ]),),]),
                                        ))]),
                                  )
                                ]),
                          ]),
                    ),
                  ],
                ),


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
                            const SizedBox(height: 20),
                            // Home button
                            ListTile(
                              leading:
                              const Icon(Icons.home, color:  Color(0xFF003366), size: 44),
                              title: const Text('Home',
                                  style: TextStyle(fontSize: 20, fontFamily:'Nunito', fontWeight : FontWeight.bold, color: Color(0xFF00a896))),
                              onTap : () {
                                // Navigate to the home page

                                Navigator.pushNamed(context, '/home');                               },
                            ), const SizedBox(height: 40),

                            // Deliveries button
                            ListTile(
                              leading:
                              const Icon(Icons.motorcycle, color: Color(0xFF003366), size: 44),
                              title: const Text('Deliveries',
                                  style: TextStyle(fontSize: 20, fontFamily: 'Nunito', fontWeight: FontWeight.bold, color: Color(0xFF00a896))),
                              onTap: () {

                                final userSession = Provider.of<UserSession>(context, listen: false);
                                final userEmail = userSession.getUserEmail() ?? '';

                                Navigator.pushNamed(context, '/deliveries');                              },
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
                                      //
                                      //     child : Icon(Icons.person, size : 40, color : Colors.white))
                                    ])),
                          ]),
                    ),
                  ),
              ],
            ),
          ),
        )
    );
  }

}

// CONFIRM DETAILS POP UP WIDGET
class ConfirmDetailsPopup extends StatelessWidget {
  final String name;
  final String contact;
  final String location;
  final String cost;
  final String instructions;
  final Function handleConfirmation;

  ConfirmDetailsPopup({
    required this.name,
    required this.contact,
    required this.location,
    required this.cost,
    required this.instructions,
    required this.handleConfirmation,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: const BorderSide(width: 3, color: Color(0xFF00a896)),
      ),
      title: const Text('Confirm details',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF003366), fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: $name',
              style: const TextStyle(color: Color(0xFF003366), fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Text('Contact: $contact',
              style: const TextStyle(color: Color(0xFF003366), fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Text('Location: $location',
              style: const TextStyle(color: Color(0xFF003366), fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Text('Cost (KES): $cost',
              style: const TextStyle(color: Color(0xFF003366), fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Text('Instructions :$instructions',
              style: const TextStyle(color: Color(0xFF003366), fontWeight: FontWeight.bold)),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(onPressed:
            () {
          Navigator.pop(context);
        }, child: const Text('Edit',
            style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(backgroundColor: const Color(0xFF003366),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),)),
        const SizedBox(width: 50),

        TextButton(onPressed:
            () => handleConfirmation(),
            child: const Text('OK',
                style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF003366),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
      ],
    );
  }
}

// New/Done // NEW REQUEST POP UP WIDGET
class NewDonePopup extends StatelessWidget {
  final Function handleNew;
  final Function handleDone;

  NewDonePopup({
    required this.handleNew,
    required this.handleDone,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(width: 3, color: Color(0xFF00a896))),
      contentPadding: const EdgeInsets.symmetric( horizontal: 20, vertical: 40),
      title: const Text(
          'To make another request\nclick New otherwise\nclick Done',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF003366))),
      actionsAlignment:
      MainAxisAlignment.center,
      actions:[
        TextButton(
            onPressed : () => handleNew(),
            child: const Text('New', style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF003366),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
        const SizedBox(width :30),

        TextButton(
            onPressed : () => handleDone(),
            child: const Text('Done', style: TextStyle(color: Colors.white)),
            style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF003366),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))))
      ],
    );
  }
}