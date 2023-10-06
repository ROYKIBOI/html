// account.dart
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'assets/loading_animation.dart'; // Import the LoadingAnimation widget
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:url_launcher/url_launcher.dart';



// Import the pages
import 'user_session.dart';
import 'home.dart';

//my account page widget
class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}


class _AccountPageState extends State<AccountPage> {
  final TextEditingController _businessLocationController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String id = '';
  String? _imageUrl;
  String imagePath = '';
  String _editedLocation = '';
  String _editedPhoneNumber = '';
  Uint8List? _imageBytes; // To store the image bytes
  bool _showDefaultImage = true;


  void navigateToDeliveries() {
    Navigator.pushNamed(context, 'myAccount');
  }



  // To upload the image and have it in the database.
  Future<void> _uploadImage() async {
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image != null) {

      final userSession = Provider.of<UserSession>(context, listen: false);
      final userEmail = userSession.getUserEmail() ?? '';

      List<int> imageBytes = await image.readAsBytes();
      String email = userEmail;

      await _pickImage(imageBytes, email);
    }
  }

  Future<void> _pickImage(List<int> imageBytes, String email) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://127.0.0.1:8000/upload_image/'),
    );

    // Use the user's email as the filename
    final filename = '$email.jpg';

    request.files.add(
      http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename:filename,
      ),
    );
    request.fields['email'] = email;


    var response = await request.send();
    if (response.statusCode == 200) {
      print('Image uploaded successfully');

      // setState(() {
      //   _imageUrl = 'http://127.0.0.1:8000/uploads/$filename'; // Replace with your actual image URL
      // });

      // Fetch and display the user's image immediately
      _getImage();

    } else {
      print('Image upload failed');
    }
  }


  // To display the image
  Future<void> _getImage() async {
    final userSession = Provider.of<UserSession>(context, listen: false);
    final userEmail = userSession.getUserEmail() ?? '';

    final imageBytes = await _fetchImageBytes(userEmail);

    if (imageBytes != null) {
      // Update the _imageBytes with the fetched image bytes
      setState(() {
        _imageBytes = imageBytes;
        _showDefaultImage = false; // Hide the default image
      });
    } else {
      // No user image available, keep showing the default image
      setState(() {
        _imageBytes = null; // Clear the _imageBytes
        _showDefaultImage = true; // Show the default image
      });
    }
  }

  Future<Uint8List?> _fetchImageBytes(String email) async {
    try {
      // Make an HTTP GET request to your Django backend to retrieve the image data
      final apiUrl = 'http://127.0.0.1:8000/get_image/?email=$email';
      final response = await http.get(Uri.parse(apiUrl)); // Replace with your backend URL and endpoint
      if (response.statusCode == 200) {
        // Parse the response JSON to extract the base64-encoded image data
        final imageBase64 = json.decode(response.body)['image_data']; // Adjust the JSON structure as per your backend response

        // Decode the base64 image data into bytes
        final imageBytes = base64.decode(imageBase64);

        return imageBytes;
      } else {
        // Handle the case where the image data cannot be retrieved
        return null;
      }
    } catch (e) {
      // Handle any network or other errors
      return null;
    }
  }






  void _removeImage() async {
    // Delete the image from the server
    final response = await http.delete(Uri.parse('http://localhost:8000/delete/$id/'));

    if (response.statusCode == 200) {
      print('Image deleted successfully.');
      // Remove the image from the UI
      setState(() {
        _imageUrl = null;
      });
    } else {
      print('Failed to delete image.');
    }
  }

// Displays an error message as a popup
  void _showErrorMessage(String message) {
    // Get the screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Flushbar(
      messageText: Text(message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.transparent,
      barBlur: 0.0, // This removes the blur effect
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.only(top: screenHeight * 0.25, left: screenWidth * 0.0),
      maxWidth: 350,
      borderRadius: BorderRadius.circular(25),
      duration: const Duration(seconds: 10),
    ).show(context);
  }

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

  // In your _AccountPageState class
  Map<String, dynamic> _clientDetails = {};

  // Function for updating business details
  Future<void> updateBusinessDetails() async {
    final userSession = Provider.of<UserSession>(context, listen: false);
    final userEmail = userSession.getUserEmail() ?? '';

    // Print the values being sent to the backend
    // print('Updating business details:');
    // print('User Email: $userEmail');
    // print('New Location: $_editedLocation');
    // print('New Phone Number: $_editedPhoneNumber');

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/update_client_details/'),
        body: {
          'Email': userEmail,
          'Location': _editedLocation,
          'Contact': _editedPhoneNumber,
        },
      );



      if (response.statusCode == 200) {
        // Business details updated successfully
        // Dismiss loading animation
        Navigator.pop(context);

        Navigator.pushNamed(context, '/myAccount');
      } else {
        // // Handle error by logging the response
        // print('Failed to update business details. Response: ${response.body}');
      }

    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    final userSession = Provider.of<UserSession>(context, listen: false);
    final userEmail = userSession.getUserEmail() ?? '';
    if (mounted) {
      fetchBusinessDetails(userEmail).then((details) {
        setState(() {
          _clientDetails = details;
        });

        // print('Fetched Business Details: $_clientDetails');

      }).catchError((error) {
        print('Error fetching business details: $error');
      });
    }


  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Fetched business details
    final String businessName = _clientDetails['businessName']?.toUpperCase() ?? '';
    final String businessLocation = _clientDetails['businessLocation']?.toUpperCase() ?? '';
    final String businessEmail = _clientDetails['userEmail'] ?? '';
    final String businessPhone = _clientDetails['phoneNumber'] ?? '';


    final userSession = Provider.of<UserSession>(context, listen: false);
    final userEmail = userSession.getUserEmail() ?? ''; // Replace with your provider method

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Stack(
                    children: [
                      Positioned(top: screenHeight * 0.1, left: screenWidth * 0.2,
                        child: ElevatedButton(
                          onPressed: () {

                            Navigator.pushNamed(context, '/home');
                            },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF003366), // Background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.05), // Border radius
                      ),
                    ),

                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(Icons.arrow_back, color: Colors.white), // Arrow icon
                        SizedBox(width: screenWidth * 0.01,), // Spacing between the icon and text
                        Text('Home', style: TextStyle(fontSize: screenWidth * 0.01, color: Colors.white, fontFamily: 'Nunito')), // Text
                      ],
                    ),
                  ),
                ),
                
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.1, horizontal: screenWidth * 0.05),
                        child: Column(
                            children: [

                              Transform.translate(
                                offset: const Offset(0, -10),
                                child: Image.asset('images/logo.png',
                                  width: screenWidth * 0.5, // 50% of screen width
                                  height: screenHeight * 0.35,
                                ),
                              ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: screenWidth * 0.15),
                              child: Container(
                                margin: EdgeInsets.only(top: screenHeight * 0.02),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        leading: Icon(Icons.business, color: const Color(0xFF003366), size: screenWidth * 0.025),
                                        title: Text('$businessName',
                                            style : TextStyle(color : const Color(0xFF00a896),fontSize :screenWidth * 0.015, fontFamily : 'Nunito')),
                                      ),
                                      SizedBox(height: screenHeight * 0.01),

                                      ListTile(
                                        leading: Icon(Icons.location_on,color : const Color(0xFF003366),size :screenWidth * 0.025),
                                        title: Text('$businessLocation',
                                            style : TextStyle(color : const Color(0xFF00a896),fontSize :screenWidth * 0.015, fontFamily : 'Nunito')),
                                      ),
                                      SizedBox(height: screenHeight * 0.01),

                                      ListTile(
                                        leading: Icon(Icons.email,color : const Color(0xFF003366),size :screenWidth * 0.025),
                                        title: Text('$businessEmail',
                                            style : TextStyle(color : const Color(0xFF00a896),fontSize :screenWidth * 0.015, fontFamily : 'Nunito',)),
                                      ),
                                      SizedBox(height: screenHeight * 0.01),

                                      ListTile(
                                        leading: Icon(Icons.phone,color : const Color(0xFF003366),size :screenWidth * 0.025),
                                        title: Text('$businessPhone',
                                            style : TextStyle(color : const Color(0xFF00a896),fontSize :screenWidth * 0.015, fontFamily : 'Nunito',)),
                                      ),
                                      SizedBox(height: screenHeight * 0.01),


                                      Padding(padding : EdgeInsets.only(top :screenHeight * 0.05, left: screenWidth * 0.05),
                            child : ElevatedButton(onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Edit details for:',
                                      textAlign : TextAlign.center,
                                      style: TextStyle(fontSize: screenWidth * 0.02, fontFamily: 'Nunito', color: Color(0xFF003366), fontWeight : FontWeight.bold),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(color: Color(0xFF00a896), width: 3),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    content:
                                    SingleChildScrollView(child:
                                    ListBody(children:<Widget>[
                                      Text(' $businessName',
                                          style : TextStyle(color : const Color(0xFF00a896),fontSize :screenWidth * 0.015, fontFamily : 'Nunito')),
                                      SizedBox(height: screenHeight * 0.02),

                                      TextField(
                                        onChanged: (value) {
                                          setState(() {
                                            _editedLocation = value;
                                          });
                                        },
                                        controller: _businessLocationController,
                                        textAlign : TextAlign.center,
                                        decoration: InputDecoration(
                                            border : outlineInputBorder(),
                                            focusedBorder : outlineInputBorder(),
                                            enabledBorder : outlineInputBorder(),
                                            hintText: 'Location',
                                            contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08, vertical: screenHeight * 0.02),
                                            alignLabelWithHint: true,
                                            hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Nunito')),
                                      ), SizedBox(height: screenHeight * 0.03),

                                      TextField(
                                        onChanged: (value) {
                                          setState(() {
                                            _editedPhoneNumber = value;
                                          });
                                        },
                                        controller: _phoneNumberController,
                                        textAlign : TextAlign.center,
                                        decoration: InputDecoration(
                                            border : outlineInputBorder(),
                                            focusedBorder : outlineInputBorder(),
                                            enabledBorder : outlineInputBorder(),
                                            hintText: 'Phone Number',
                                            contentPadding:
                                            EdgeInsets.symmetric(horizontal: screenWidth * 0.08, vertical: screenHeight * 0.02),
                                            alignLabelWithHint: true,
                                            hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Nunito')),
                                      ),
                                    ])),

                                    actions:<Widget>[
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            // Check if all fields are filled
                                            if (_businessLocationController.text.isEmpty || _phoneNumberController.text.isEmpty) {
                                              // If not, show an error message
                                              _showErrorMessage('All fields must be filled before saving.');
                                            } else {

                                              // Show loading animation
                                              showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                barrierColor: Colors.transparent, // Set barrierColor to transparent
                                                builder: (BuildContext context) {
                                                  return const Dialog(
                                                    backgroundColor: Colors.transparent,
                                                    elevation: 0,
                                                    child: LoadingAnimation(),
                                                  );
                                                },
                                              );

                                              await updateBusinessDetails();




                                              // Clear the fields after saving
                                              _businessLocationController.clear();
                                              _phoneNumberController.clear();
                                            }
                                          },
                                          child: Text('Save',
                                            style: TextStyle(fontSize: screenWidth * 0.012, fontFamily: 'Nunito', color: Colors.white),
                                          ),
                                          style: ElevatedButton.styleFrom(primary: const Color(0xFF003366),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                                style:ElevatedButton.styleFrom(primary:const Color(0xFF003366),
                                    shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(screenWidth * 0.05))),
                                child: Text('Edit Profile',
                                    style:TextStyle(fontSize: screenWidth * 0.01, fontFamily: 'Nunito', color: Colors.white))

                            )
                        ),
                      ]),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Padding(padding : EdgeInsets.only(top: screenHeight * 0.02, left: screenWidth * 0.05),
                    child :
                    Column(crossAxisAlignment : CrossAxisAlignment.start,
                        children:[
                          ListTile(
                            leading: Icon(Icons.headset_mic,
                                color : const Color(0xFF003366),size :screenWidth * 0.025),
                            title:
                            Text('Support',
                                style : TextStyle(color : const Color(0xFF003366),fontSize :screenWidth * 0.015, fontFamily : 'Nunito',fontWeight : FontWeight.bold)),
                          ),
                          Padding(
                              padding : EdgeInsets.only(top: screenHeight * 0.02, left: screenWidth * 0.05),
                              child : Column(crossAxisAlignment : CrossAxisAlignment.start,
                                  children:[

                                    ///ADD ETALE
                                    // For the phone number
                                    InkWell(
                                      onTap: () async {
                                        const url = 'tel:+254704134095';
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                      child: Text('+254 704 134 095',
                                          style: TextStyle(color: const Color(0xFF00a896), fontSize: screenWidth * 0.012, fontFamily: 'Nunito')),
                                    ), SizedBox(height: screenHeight * 0.05),

                                    ///ADD ETALE
                                    // For the email
                                    InkWell(
                                      onTap: () async {
                                        const url = 'mailto:hello@try.ke';
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                      child: Text('hello@try.ke',
                                          style: TextStyle(color: const Color(0xFF00a896), fontSize: screenWidth * 0.012, fontFamily: 'Nunito')),
                                    ),

                                  ])
                          ),
                          Padding(padding : EdgeInsets.only(top: screenHeight * 0.1, left: screenWidth * 0.02),
                              child : GestureDetector(onTap:
                                  () {
                                // Show terms and conditions dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: SingleChildScrollView(child:
                                      ListBody(
                                          children: <Widget>[
                                            Text('Terms & Conditions',
                                                style :TextStyle(color : const Color(0xFF003366),fontSize :screenWidth * 0.012, fontFamily : 'Nunito')
                                            ),
                                        ])),
                                    actions:<Widget>[
                                      TextButton(
                                          child: Text('Close',
                                        style: TextStyle(fontSize :screenWidth * 0.015, fontFamily: 'Nunito', color: const Color(0xFF00a896), fontWeight : FontWeight.bold),
                                      ),
                                          onPressed:
                                              () {
                                            Navigator.of(context).pop();
                                          }),
                                    ],
                                  );
                                },
                              );
                            },
                                child : Text('Terms & Conditions',
                                    style : TextStyle(color : const Color(0xFF003366),fontSize :screenWidth * 0.012, fontFamily : 'Nunito',fontWeight : FontWeight.bold))
                            )
                        )
                      ])
              )

            )
            ])
        ]),
      ),
    ])
    ])
      )
        )
    );
  }
}