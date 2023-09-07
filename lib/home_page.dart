// home_page.dart

import 'package:flutter/material.dart';

// Import the pages
import '../login_signup_forgot_reset_business_details_page.dart';
import 'delivery_request_page.dart';
import 'deliveries_page.dart';
import '../account_page.dart';

// Function that returns an OutlineInputBorder with the desired properties
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: const BorderSide(color: Color(0xFF003366), width: 3),
  );
}

//home page widget
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> deliveries = <Map<String, dynamic>>[];
  Color _buttonColor = const Color(0xFF00a896);

  final gif = Image.asset('images/gif.gif');

  String _salutation = '';
  bool _showPopup = false;

  @override
  void initState() {
    super.initState();
    _updateSalutation();
  }

  void _updateSalutation() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      setState(() => _salutation = 'Good morning!');
    } else if (hour < 18) {
      setState(() => _salutation = 'Good afternoon!');
    } else {
      setState(() => _salutation = 'Good evening!');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10,),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        // Profile pic and salutation
                        Row(
                          children: [
                            // Profile picture
                            Positioned(
                              top: MediaQuery.of(context).padding.top + 30, left: 30,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // view profile pic
                                  });
                                },
                                child: const CircleAvatar( radius: 40,
                                  backgroundColor: Colors.grey,
                                  // TODO:
                                  // Replace with the actual profile picture of the rider
                                  child: Icon(Icons.person, size: 60, color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20, height: 30,),

                            // Salutation
                            Text(_salutation, style: const TextStyle(color: Color(0xFF003366), fontSize: 16, fontFamily: 'Nunito', fontWeight: FontWeight.bold)),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 40,),
                            ),
                          ],
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

                Container(
                  width: 800,
                  height: 400,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: const Color(0xFF00a896), width: 2),
                  ),
                  child: gif,
                ), const SizedBox(height: 40),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              MouseRegion(
                                onEnter: (event) => setState(() => _buttonColor = const Color(0xFF00a4cd)),
                                onExit: (event) => setState(() => _buttonColor = const Color(0xFF00a896)),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DeliveryRequestPage(deliveries: deliveries),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: _buttonColor,
                                    fixedSize: const Size(200, 70),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 70),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Delivery',
                                          style:
                                          TextStyle(fontFamily: 'Nunito', fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Request',
                                          style:
                                          TextStyle(fontFamily: 'Nunito', fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Positioned(
                                top: -50,
                                left: -10,
                                child:
                                Icon(Icons.note_add_outlined, color: Color(0xFF003366), size: 120),
                              ),
                            ],
                          )
                        ],
                      ),
                    )


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
                          onTap : () { Navigator.push(context,
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
        )
    );
  }
}