// delivery_request_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

// Import the pages
import '../login_signup_forgot_reset_business_details_page.dart';
import 'home_page.dart';
import 'assets/custom_text_form_field_page.dart';
import 'deliveries_page.dart';
import '../account_page.dart';

// Function that returns an OutlineInputBorder with the desired properties
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: const BorderSide(color: Color(0xFF003366), width: 3),
  );
}

// delivery request page widget
class DeliveryRequestPage extends StatefulWidget {
  const DeliveryRequestPage({Key? key}) : super(key: key);

  @override
  _DeliveryRequestPageState createState() => _DeliveryRequestPageState();
}

class _DeliveryRequestPageState extends State<DeliveryRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _locationController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _costController = TextEditingController();

  bool _showPopup = false;

  final _nameKey = GlobalKey<CustomTextFormFieldState>();
  final _contactKey = GlobalKey<CustomTextFormFieldState>();
  final _locationKey = GlobalKey<CustomTextFormFieldState>();

  final _nameFocusNode = FocusNode();
  final _contactFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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

                        // Profile picture
                        Positioned(
                          top: MediaQuery.of(context).padding.top + 30,
                          left: 30,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                // view profile pic
                              });
                            },
                            child: const CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.grey,
                              // TODO:
                              // Replace with the actual profile picture of the rider
                              child: Icon(Icons.person, size: 60, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 300),

                        // Menu
                        Row(
                          children: [
                            const SizedBox(width: 50),

                            // Nav bar icon
                            IconButton(
                              icon: const Icon(Icons.menu,
                                  color: Color(0xFF003366), size: 50),
                              onPressed: () {
                                setState(() => _showPopup = !_showPopup);
                              },
                            ),
                          ],
                        )
                      ]
                  ),
                ),


                Expanded(
                  child:
                  Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Form(
                                key: _formKey,
                                child:
                                Column(children: [
                                  Transform.translate(
                                    offset: const Offset(0, -50),
                                    child: Container(
                                      width: 350,
                                      height: 500,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: const Color(0xFF00a896),
                                            width: 3),
                                        borderRadius:
                                        BorderRadius.circular(30),
                                      ),
                                      child:
                                      Column(children: [
                                        const SizedBox(height: 60),
                                        CustomTextFormField(key: _nameKey,
                                          hintText: 'Customer Name',
                                          errorMessage: 'Please enter customer name',
                                          controller: _nameController,
                                          focusNode: _nameFocusNode,),
                                        const SizedBox(height: 30),

                                        CustomTextFormField(key: _contactKey,
                                          hintText: 'Customer Contact',
                                          errorMessage: 'Please enter contact info',
                                          controller: _contactController,
                                          focusNode: _contactFocusNode,),
                                        const SizedBox(height: 30),

                                        CustomTextFormField(key: _locationKey,
                                          hintText: 'Delivery Location',
                                          errorMessage: 'Please enter the location',
                                          controller: _locationController,
                                          focusNode: _locationFocusNode,
                                          onTap: _handleLocationTap,),
                                        const SizedBox(height: 30),


                                        SizedBox(width: 300, height: 40, child:
                                        TextFormField(controller:
                                        _instructionsController, textAlign:
                                        TextAlign.center, style:
                                        const TextStyle(color:
                                        Colors.white, fontSize:
                                        18, fontFamily: 'Nunito', fontWeight:
                                        FontWeight.bold), decoration:
                                        InputDecoration(hintText:
                                        'Extra Instructions',
                                            hintStyle:
                                            const TextStyle(color:
                                            Colors.white, fontSize:
                                            12, fontFamily: 'Nunito'),
                                            fillColor:
                                            const Color(0xFF00a896),
                                            filled:
                                            true,
                                            border:
                                            OutlineInputBorder(borderRadius:
                                            BorderRadius.circular(30)),
                                            contentPadding:
                                            const EdgeInsets.symmetric(vertical:
                                            12, horizontal: 80)),),),
                                        const SizedBox(height: 15),

                                        Padding(
                                          padding: const EdgeInsets.only(left: 35),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    'Cost (KES):',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'Nunito',
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Container(
                                                    width: 80,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(30),
                                                      color: Colors.white,
                                                      border: Border.all(color: const Color(0xFF00a896)),
                                                    ),
                                                    child: TextFormField(
                                                      controller: _costController,
                                                      style: const TextStyle(
                                                          color: Color(0xFF003366),
                                                          fontSize: 14,
                                                          fontFamily: 'Nunito',
                                                          fontWeight: FontWeight.bold),
                                                      decoration: const InputDecoration(
                                                        contentPadding:
                                                        EdgeInsets.symmetric(vertical: 15.6, horizontal: 10),
                                                        border: InputBorder.none,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height :50), // Add this line
                                              Align( // Add this line
                                                  alignment :Alignment.centerLeft, // Add this line
                                                  child:
                                                  Padding( // Add this line
                                                      padding :const EdgeInsets.only(left :90), // Add this line
                                                      child :
                                                      ElevatedButton(
                                                          onPressed :_handlePlaceOrder,style :
                                                      ElevatedButton.styleFrom(primary :
                                                      const Color(0xFF003366),shape :
                                                      RoundedRectangleBorder(borderRadius :
                                                      BorderRadius.circular(15))),child :
                                                      const Text('Place Order',style :
                                                      TextStyle(color :
                                                      Colors.white,)))
                                                  )
                                              )
                                            ],
                                          ),
                                        )
                                      ]),),),
                                ]),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                          },
                        ), const SizedBox(height: 40),

                        // Deliveries button
                        ListTile(
                          leading:
                          const Icon(Icons.motorcycle, color:  Color(0xFF003366), size: 44),
                          title:  const Text('Deliveries',
                              style: TextStyle(fontSize: 20, fontFamily:'Nunito', fontWeight : FontWeight.bold, color: Color(0xFF00a896))),
                          onTap : () {Navigator.push( context,
                              MaterialPageRoute(builder: (context) => const DeliveriesPage(deliveries: [])));
                          },
                        ),const SizedBox(height: 40),

                        // Log out button
                        ListTile(
                          leading:
                          const Icon(Icons.logout, color:  Color(0xFF003366), size: 44),
                          title: const Text('Log Out',
                              style: TextStyle(fontSize: 20, fontFamily:'Nunito', fontWeight : FontWeight.bold, color: Color(0xFF00a896))),
                          onTap : () {

                            // Log out and navigate to the login page
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                          },
                        ), const SizedBox(height: 210),


                        // My account section
                        Padding(padding : const EdgeInsets.all(8.0),
                            child : Row(mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                children:[
                                  ElevatedButton(onPressed : () {
                                    Navigator.push(context, MaterialPageRoute(builder:(context) => const AccountPage()));
                                  }, child : const Text('My Account',
                                      style : TextStyle(color : Colors.white)),
                                      style : ElevatedButton.styleFrom(primary : const Color(0xFF00a896),
                                          shape : RoundedRectangleBorder(borderRadius : BorderRadius.circular(25)))),
                                  const CircleAvatar(radius : 20, backgroundColor : Colors.grey,
                                      // TODO:
                                      // Replace with the actual profile picture of the rider
                                      child : Icon(Icons.person, size : 40, color : Colors.white))
                                ])),
                      ]),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _handleLocationTap() async {
    // TODO Replace with your own API key
    const apiKey = 'AIzaSyDJqeRm7RSk2fCJCly_BeMYRuCBbFgqSB8';
    final places = GoogleMapsPlaces(apiKey: apiKey);
    final result = await PlacesAutocomplete.show(
      context: context,
      apiKey: apiKey,
      mode: Mode.overlay,
      language: 'en',
      components: [Component(Component.country, 'ke')],);
    if (result != null) {
      final details = await places.getDetailsByPlaceId(result.placeId!);
      setState(() =>
      _locationController.text = details.result.formattedAddress!);
    }
  }


  void _handlePlaceOrder() {
    if (_nameController.text.isEmpty) {
      _nameKey.currentState?.setValid(false);
    }
    if (_contactController.text.isEmpty) {
      _contactKey.currentState?.setValid(false);
    }
    if (_locationController.text.isEmpty) {
      _locationKey.currentState?.setValid(false);
    }
    if (_formKey.currentState!.validate()) {
      // Check if all fields are filled
      bool isFormFilled =
          _nameController.text.isNotEmpty &&
              _contactController.text.isNotEmpty &&
              _locationController.text.isNotEmpty;

      // Only show confirmation dialog if all fields are filled
      if (isFormFilled) {
        // Show confirmation dialog
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(width: 3, color: Color(0xFF00a896),
                  ),
                ),
                //contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40,
                //),
                title: const Text('Confirm details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFF003366), fontWeight: FontWeight.bold)),


                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text('Name: ${_nameController.text}',
                        style: const TextStyle(color: Color(0xFF003366),
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    Text('Contact: ${_contactController.text}',
                        style: const TextStyle(color: Color(0xFF003366),
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    Text('Location: ${_locationController.text}',
                        style: const TextStyle(color: Color(0xFF003366),
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    Text('Cost (KES): ${_costController.text}',
                        style: const TextStyle(color: Color(0xFF003366),
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    Text('Instructions :${_instructionsController.text}', style:
                    const TextStyle(color: Color(0xFF003366), fontWeight:
                    FontWeight.bold)),
                  ],
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  TextButton(onPressed:
                      () {
                    Navigator.pop(context);
                  }, child:
                  const Text('Edit', style:
                  TextStyle(color: Colors.white)), style:
                  TextButton.styleFrom(backgroundColor:
                  const Color(0xFF003366), shape:
                  RoundedRectangleBorder(borderRadius:
                  BorderRadius.circular(20)),)),
                  const SizedBox(width: 50),

                  TextButton(onPressed:
                  _handleConfirmation, child:
                  const Text('OK', style:
                  TextStyle(color: Colors.white)), style:
                  TextButton.styleFrom(backgroundColor:
                  const Color(0xFF003366), shape:
                  RoundedRectangleBorder(borderRadius:
                  BorderRadius.circular(20)),)),

                ],
              );
            });
      }
    }
  }

  void _handleConfirmation() {
    Navigator.pop(context); // Close the confirmation dialog

// Save the delivery request information
    Map<String, dynamic> delivery = {
      'orderNumber': '12345',
      // TODO Replace with actual order number from backend
      'customerName': _nameController.text,
      'customerLocation': _locationController.text,
      'rider': 'Jane Doe',
      // TODO Replace with actual rider from admin app
      'status': 'To Assign',
    };

// Show Done/New dialog
    showDialog(
      context: context, builder: (context) {
      return AlertDialog(shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: const BorderSide(width: 3, color: Color(0xFF00a896))),
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 40),
        title: const Text(
            'To make another request\nclick New otherwise\nclick Done',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF003366))),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(onPressed:
              () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => DeliveriesPage(deliveries: [delivery])));
          }, child:
          const Text('Done', style:
          TextStyle(color:
          Colors.white)), style:
          TextButton.styleFrom(backgroundColor:
          const Color(0xFF003366), shape:
          RoundedRectangleBorder(borderRadius:
          BorderRadius.circular(20))),),
          const SizedBox(width:
          30),
          TextButton(onPressed:
              () {
            Navigator.pop(context); // Close the new/done dialog
            _nameController.clear();
            _contactController.clear();
            _locationController.clear();
            _instructionsController.clear();
            _costController.clear();
          }, child:
          const Text('New', style:
          TextStyle(color:
          Colors.white)), style:
          TextButton.styleFrom(backgroundColor:
          const Color(0xFF003366), shape:
          RoundedRectangleBorder(borderRadius:
          BorderRadius.circular(20))),),
        ],);
    },
    );

// Clear the input fields
    _nameController.clear();
    _contactController.clear();
    _locationController.clear();
    _instructionsController.clear();
    _costController.clear();

// Show notification message
    showNotification(context, 'Order successfully placed!', Colors.green);
  }

  void showNotification(BuildContext context, String message, Color color) {
    final overlay = Overlay.of(context)!;
    final overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        top: 50,
        child: SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  message,
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
}