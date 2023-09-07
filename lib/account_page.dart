// account_page.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
  File? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      print(image.path);
      setState(() {
        _image = File(image.path);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:
        SingleChildScrollView(child:
        Column(crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Padding( padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical :10.0),
                child:
                Row(children:[
                  Stack(children: [
                    if (_image == null)
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 90,
                        child: Icon(
                          Icons.person,
                          size: 100,
                          color: Colors.white,
                        ),
                      )
                    else
                      CircleAvatar(
                        radius: 90,
                        backgroundImage: FileImage(_image!),
                      ),

                    Positioned(top: 130, left: 72,
                      child: PopupMenuButton(
                        onSelected: (value) async {
                          if (value == 'upload') {
                            await _pickImage();
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          const PopupMenuItem(
                            value: 'upload',
                            child: ListTile(
                              leading: Icon(Icons.photo_library),
                              title: Text('Upload Photo'),
                            ),
                          ),
                        ],
                        child: const Icon(Icons.camera_alt, color: Color(0xFF003366), size: 40,),
                      ),

                    ),

                  ],
                  ),

                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                          margin: const EdgeInsets.only(top: 150), // Add this Container widget with top margin of 80
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                    children: [
                                      Icon(Icons.business,
                                          color: Color(0xFF003366), size: 30),
                                      Padding(padding : EdgeInsets.only(left :10),
                                          child : Text('Business Name',
                                              style : TextStyle(color : Color(0xFF00a896),fontSize :16, fontFamily : 'Nunito',fontWeight : FontWeight.bold))
                                      )
                                    ]), const SizedBox(height: 30),

                                const Row(children:[
                                  Icon(Icons.location_on,color :
                                  Color(0xFF003366),size :30),
                                  Padding(padding : EdgeInsets.only(left :10),
                                      child : Text('Business Location',
                                          style : TextStyle(color : Color(0xFF00a896),fontSize :16, fontFamily : 'Nunito',fontWeight : FontWeight.bold))
                                  )
                                ]), const SizedBox(height: 30),

                                const Row(children:[
                                  Icon(Icons.email,color : Color(0xFF003366),size :30),
                                  Padding(padding : EdgeInsets.only(left :10),
                                      child : Text('Business Email',
                                          style : TextStyle(color : Color(0xFF00a896),fontSize :16, fontFamily : 'Nunito',fontWeight : FontWeight.bold))
                                  )
                                ]), const SizedBox(height: 30),

                                Padding(padding :
                                const EdgeInsets.only(top :20),
                                    child : ElevatedButton(onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                            const Text('Edit details',
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
                                                decoration:
                                                InputDecoration(
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
                                                    contentPadding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
                                                    alignLabelWithHint: true,
                                                    hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Nunito')),
                                              ),
                                            ])),
                                            actions: <Widget>[
                                              Center(
                                                child: Container(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      // TODO:
                                                      // Implement save logic
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: const Text('Save',
                                                      style: TextStyle( fontSize: 16, fontFamily: 'Nunito',
                                                        color: Colors.white, fontWeight: FontWeight.bold,
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
                              ])
                      )
                  )
                ]),
              ),

              Padding(padding : const EdgeInsets.only(left :80,top :50),
                  child :
                  Column(crossAxisAlignment : CrossAxisAlignment.start,
                      children:[
                        const Row(children:[
                          Icon(Icons.headset_mic,
                              color : Color(0xFF003366),size :30),
                          Padding(padding : EdgeInsets.only(left :10),
                              child :
                              Text('Support',
                                  style : TextStyle(color : Color(0xFF003366),fontSize :16, fontFamily : 'Nunito',fontWeight : FontWeight.bold))
                          )
                        ]),
                        const Padding(padding :
                        EdgeInsets.only(left :50,top :20),
                            child :
                            Column(crossAxisAlignment :
                            CrossAxisAlignment.start,
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
                        Padding(padding :
                        const EdgeInsets.only(top :50,left :150),
                            child :

                            GestureDetector(onTap:
                                () {
                              // Show terms and conditions dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content:
                                    const SingleChildScrollView(child:
                                    ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Terms and Conditions',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 10),
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
                                      TextButton(child:
                                      const Text('Accept',
                                        style:
                                        TextStyle(fontSize: 16, fontFamily: 'Nunito', color: Color(0xFF003366), fontWeight : FontWeight.bold),
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
                                    style :
                                    TextStyle(color :
                                    Color(0xFF003366),fontSize :14, fontFamily : 'Nunito',fontWeight : FontWeight.bold))
                            )
                        )
                      ])
              )
            ])
        ),
      ),
    );
  }
}