// account.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'assets/loading_animation.dart'; // Import the LoadingAnimation widget
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';

// Function that returns an OutlineInputBorder with the desired properties
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: const BorderSide(color: Color(0xFF003366), width: 3),
  );
}


//my account page widget
class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController _businessLocationController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  String? _imageUrl;
  String imagePath = '';

  //Define a method to pick an image from the gallery
  void _pickImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagePath = pickedFile.path;
      // Display the picked image immediately
      setState(() {
        _imageUrl = pickedFile.path;
      });

      } else {
        // Handle error
      }
    }


// Delete the image from the server
  void _removeImage() {
    setState(() {
      _imageUrl = null;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 80.0),
                        child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(width: 240, height: 240,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey, width: 2,
                                      ),
                                      image: _imageUrl != null
                                          ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(_imageUrl!) as ImageProvider<Object>,
                                      )
                                          : null,
                                    ),
                                    child: _imageUrl == null ? const Icon(Icons.person, size: 100, color: Colors.grey) : null,
                                  ),


                                    Positioned(bottom: 5, right: 40,
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          cardColor: Colors.white, // This changes the background color of the menu
                                          popupMenuTheme: PopupMenuThemeData(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(color: Color(0xFF00a896), width: 2), // This gives the menu an outline
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                          ),
                                        ),
                                        child: PopupMenuButton<ImageSource>(
                                          icon: const Icon(Icons.camera_alt, size: 40, color: Color(0xFF003366)),
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              child: Text('Upload Image', style: TextStyle(color: Color(0xFF003366))), // This changes the text color
                                              value: ImageSource.gallery,
                                            ),
                                            PopupMenuItem(
                                              child: Text('Remove Image', style: TextStyle(color: Color(0xFF003366))), // This changes the text color
                                              value: ImageSource.camera,
                                            ),
                                          ],
                                          onSelected: (value) {
                                            if (value == ImageSource.camera) {
                                              _removeImage();
                                            } else {
                                              _pickImage();
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    ],
                                  ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 150),
                              child: Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const ListTile(
                                        leading: Icon(Icons.business, color: Color(0xFF003366), size: 30),
                                        title: Text('Business Name',
                                            style : TextStyle(color : Color(0xFF00a896),fontSize :16, fontFamily : 'Nunito',fontWeight : FontWeight.bold)),
                                      ),
                                      const SizedBox(height: 10),

                                      const ListTile(
                                        leading: Icon(Icons.location_on,color : Color(0xFF003366),size :30),
                                        title: Text('Business Location',
                                            style : TextStyle(color : Color(0xFF00a896),fontSize :16, fontFamily : 'Nunito',fontWeight : FontWeight.bold)),
                                      ),
                                      const SizedBox(height: 10),

                                      const ListTile(
                                        leading: Icon(Icons.email,color : Color(0xFF003366),size :30),
                                        title: Text('Business Email',
                                            style : TextStyle(color : Color(0xFF00a896),fontSize :16, fontFamily : 'Nunito',fontWeight : FontWeight.bold)),
                                      ),
                                      const SizedBox(height: 20),

                        Padding(padding : const EdgeInsets.only(top :20, left: 70),
                            child : ElevatedButton(onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Edit details',
                                      textAlign : TextAlign.center,
                                      style: TextStyle(fontSize: 20, fontFamily: 'Nunito', color: Color(0xFF003366), fontWeight : FontWeight.bold),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(color: Color(0xFF00a896), width: 3),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    content:
                                    SingleChildScrollView(child:
                                    ListBody(children:<Widget>[
                                      const Text('Name: Business Name',
                                          style : TextStyle(color : Color(0xFF00a896),fontSize :16, fontFamily : 'Nunito',fontWeight : FontWeight.bold)),
                                      const SizedBox(height: 10),

                                      TextField(
                                        controller: _businessLocationController,
                                        textAlign : TextAlign.center,
                                        decoration: InputDecoration(
                                            border : outlineInputBorder(),
                                            focusedBorder : outlineInputBorder(),
                                            enabledBorder : outlineInputBorder(),
                                            hintText: 'Location',
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
                                            alignLabelWithHint: true,
                                            hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Nunito')),
                                      ), const SizedBox(height: 20),

                                      TextField(
                                        controller: _phoneNumberController,
                                        textAlign : TextAlign.center,
                                        decoration: InputDecoration(
                                            border : outlineInputBorder(),
                                            focusedBorder : outlineInputBorder(),
                                            enabledBorder : outlineInputBorder(),
                                            hintText: 'Phone Number',
                                            contentPadding:
                                            const EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
                                            alignLabelWithHint: true,
                                            hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Nunito')),
                                      ),
                                    ])),

                                    actions:<Widget>[
                                      Center(
                                        child: Container(
                                          child: ElevatedButton(onPressed:
                                              () async {

                                            // TODO:
                                            // Implement save logic
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

                                            // Wait for 5 seconds to simulate checking email and password against database
                                            await Future.delayed(const Duration(seconds : 5));

                                            // Dismiss loading animation
                                            Navigator.pop(context);
                                            Navigator.pop(context);

                                          },
                                            child: const Text('Save',
                                              style: TextStyle( fontSize: 16, fontFamily: 'Nunito', color: Colors.white, fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(primary: const Color(0xFF003366),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),
                                              ),
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
                                    shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20))),
                                child:const Text('Edit Profile', style:TextStyle(color:Colors.white))

                            )
                        ),
                      ]),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Padding(padding : const EdgeInsets.only(right :80,bottom :100),
                    child :
                    Column(crossAxisAlignment : CrossAxisAlignment.start,
                        children:[
                          const ListTile(
                            leading: Icon(Icons.headset_mic,
                                color : Color(0xFF003366),size :30),
                            title:
                            Text('Support',
                                style : TextStyle(color : Color(0xFF003366),fontSize :16, fontFamily : 'Nunito',fontWeight : FontWeight.bold)),
                          ),
                          const Padding(
                              padding : EdgeInsets.only(left :80,top :20),
                              child : Column(crossAxisAlignment : CrossAxisAlignment.start,
                                  children:[
                                    Text('+254 704 134 095',
                                        style :TextStyle(color :
                                        Color(0xFF00a896),fontSize :14, fontFamily : 'Nunito')),
                                    SizedBox(height: 20),

                                    Text('hello@try.ke',
                                        style :TextStyle(color :
                                        Color(0xFF00a896),fontSize :16, fontFamily : 'Nunito')),
                                  ])
                          ),
                          Padding(padding : const EdgeInsets.only(top :50,left :50),
                              child : GestureDetector(onTap:
                                  () {
                                // Show terms and conditions dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: const SingleChildScrollView(child:
                                      ListBody(
                                          children: <Widget>[
                                            Text(
                                            '1. Definitions\n\n'
                                                '- "Company" refers to [Your Company Name], a logistics service provider.\n'
                                                '- "Client" refers to the individual, business, or organization engaging the services of the Company.\n'
                                                '- "Services" refers to the logistics, transportation, and related services provided by the Company.\n'
                                                '- "Cargo" refers to the goods, items, or products being transported by the Company.\n'
                                                '- "Agreement" refers to the contractual relationship established between the Company and the Client, including these terms and conditions.\n\n'
                                                '2. Service Agreement\n\n'
                                                'By engaging the services of the Company, the Client agrees to abide by these terms and conditions. This Agreement supersedes any prior verbal or written agreements.\n\n'
                                                '3. Booking and Confirmation\n\n'
                                                '- All service bookings are subject to availability and confirmation by the Company.\n'
                                                '- The Client must provide accurate and complete information regarding the nature of the Cargo, dimensions, weight, packaging, pickup and delivery locations, and any special handling requirements.\n\n'
                                                '4. Charges and Payment\n\n'
                                                '- The Client agrees to pay the quoted charges for the Services as per the agreed terms.\n'
                                                '- Charges may include transportation, handling, packaging, insurance, and any applicable taxes or duties.\n'
                                                '- Payment is due within the agreed timeframe from the date of invoice. Late payments may incur additional charges.\n\n'
                                                '5. Liability and Insurance\n\n'
                                                '- The Company will take reasonable care of the Cargo during transportation; however, the Client acknowledges that the Company is not liable for damage, loss, or delay beyond its control.\n'
                                                '- The Client is responsible for providing appropriate insurance coverage for the Cargo during transit, if desired.\n\n'
                                                '6. Delays\n\n'
                                                '- The Company will make reasonable efforts to meet agreed-upon delivery timelines. However, delays due to unforeseen circumstances, including but not limited to weather, traffic, customs, or mechanical issues, may occur.\n\n'
                                                '7. Cancellations and Changes\n\n'
                                                '- Cancellation of a booked service must be made in writing within a reasonable time prior to the scheduled pickup.\n'
                                                '- Changes to booking details may incur additional charges or lead to adjustments in the agreed timeline.\n\n'
                                                '8. Confidentiality\n\n'
                                                '- Both parties agree to keep all non-public information obtained during the course of the Agreement confidential.\n\n'
                                                '9. Governing Law\n\n'
                                                '- This Agreement shall be governed by and construed in accordance with the laws of [Jurisdiction]. Any disputes shall be subject to the exclusive jurisdiction of the courts in [Jurisdiction].\n\n'
                                                '10. Termination\n\n'
                                                '- Either party may terminate this Agreement in the event of a material breach by the other party. Written notice of such breach must be provided, and the breaching party shall have a reasonable opportunity to remedy the breach.\n\n'
                                                '11. Miscellaneous\n\n'
                                                '- This Agreement constitutes the entire understanding between the parties and supersedes all prior agreements.\n'
                                                '- No modifications or amendments to this Agreement shall be valid unless made in writing and signed by both parties.',
                                          ),
                                        ])),
                                    actions:<Widget>[
                                      TextButton(
                                          child: const Text('Accept',
                                        style: TextStyle(fontSize: 16, fontFamily: 'Nunito', color: Color(0xFF003366), fontWeight : FontWeight.bold),
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
                                child : const Text('Terms & Conditions',
                                    style : TextStyle(color : Color(0xFF003366),fontSize :14, fontFamily : 'Nunito',fontWeight : FontWeight.bold))
                            )
                        )
                      ])
              )

            )
            ])
        ]),
      ),
    ])
    )
      )
    );
  }
}