// deliveries.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Import the pages
import '../user_details.dart';
import 'delivery_request.dart';
import 'home.dart';
import '../account.dart';

// Function that returns an OutlineInputBorder with the desired properties
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: const BorderSide(color: Color(0xFF003366), width: 3),
  );
}


// deliveries page widget
class DeliveriesPage extends StatefulWidget {
  final List<Map<String, dynamic>> deliveries;

  const DeliveriesPage({Key? key, required this.deliveries}) : super(key: key);

  @override
  _DeliveriesPageState createState() => _DeliveriesPageState();
}


class _DeliveriesPageState extends State<DeliveriesPage> {
  bool _showPopup = false;
  String _filter = 'All';

// TODO Replace with actual data from backend
  final List<Map<String, dynamic>> _deliveries = [];


    @override
    void initState() {
      super.initState();
      _deliveries.addAll(widget.deliveries);
    }

  @override
  Widget build(BuildContext context) {
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
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                child: const CircleAvatar(radius: 40,
                                  backgroundColor: Colors.grey,
                                  // TODO:
                                  // Replace with the actual profile picture of the rider
                                  child:
                                  Icon(Icons.person, size: 60, color: Colors.white),
                                ),
                              ),
                            ), const SizedBox(width: 300),

// Menu
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  width: 180,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(color: const Color(0xFF00a896), width: 2)
                                  ),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      cardColor: Colors.white, // This changes the background color of the menu
                                      popupMenuTheme: PopupMenuThemeData(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(color: Color(0xFF00a896), width: 2), // This gives the menu an outline
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text(
                                            _filter == null ? "Filter by:" : _filter,
                                            style: const TextStyle(color: Color(0xFF003366)),
                                          ),
                                        ),
                                        const SizedBox(width: 10), // This is to give some space at the start
                                        PopupMenuButton<String>(
                                          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF003366)),
                                          itemBuilder: (context) => [
                                            const PopupMenuItem(
                                              child: Text('All', style: TextStyle(color: Color(0xFF003366))), // This changes the text color
                                              value: 'All',
                                            ),
                                            const PopupMenuItem(
                                              child: Text('Today', style: TextStyle(color: Color(0xFF003366))), // This changes the text color
                                              value: 'Today',
                                            ),
                                            const PopupMenuItem(
                                              child: Text('Last 7 days', style: TextStyle(color: Color(0xFF003366))), // This changes the text color
                                              value: 'Last 7 days',
                                            ),
                                            const PopupMenuItem(
                                              child: Text('Last month', style: TextStyle(color: Color(0xFF003366))), // This changes the text color
                                              value: 'Last month',
                                            ),
                                            const PopupMenuItem(
                                              child: Text('Older', style: TextStyle(color: Color(0xFF003366))), // This changes the text color
                                              value: 'Older',
                                            ),
                                          ],
                                          onSelected: (String? newValue) {
                                            setState(() {
                                              _filter = newValue!;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),



                            // Nav bar icon
                              IconButton(icon:
                              const Icon(Icons.menu, color: Color(0xFF003366),
                                  size: 50), onPressed:
                                  () {
                                setState(() => _showPopup = !_showPopup);
                              },),

                            ])
                          ])),
                  Expanded(child:
                  SingleChildScrollView(child:
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center, children: [
                    Stack(clipBehavior: Clip.none, children: [
                      Form(child:
                      Column(children: [
                        const Padding(padding:
                        EdgeInsets.symmetric(horizontal: 150.0, vertical: 2),
                            child:
                            Row(mainAxisAlignment:
                            MainAxisAlignment.spaceBetween, children: [
                              Text('All Deliveries', style:
                              TextStyle(fontSize: 20,
                                  fontFamily: 'Nunito', color:
                                  Color(0xFF003366), fontWeight:
                                  FontWeight.bold)),

                            ])),

                        ..._deliveries.map((delivery) {
                          return Card(shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                              child: Container(width: 1080, height: 100, decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFF003366), width: 2)),
                                  child: Padding(padding: const EdgeInsets.all(10),
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
                              ]),
                              const Spacer(),
                              Align(alignment: Alignment.bottomRight,
                                  child:
                              Container(width: 100, height: 30,
                                  decoration: BoxDecoration(borderRadius:
                              BorderRadius.circular(15), color: const Color(0xFF00a896)),
                                  child:
                              Center(child:
                              Text(delivery['status'],
                                  style: TextStyle(color:
                              delivery['status'] == 'To Assign' ? Colors.red
                                  : delivery['status'] == 'To Pick Up' ? Colors.yellow
                                  : delivery['status'] == 'En-Route' ? const Color(0xFF1B5E20)
                                  : const Color(0xFF003366)))))),
                            ])
                          ]))));
                        }).toList()

                      ]))
                    ])
                  ]))
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
                                  const SizedBox(height: 20),
                                  // Home button
                                  ListTile(
                                    leading:
                                    const Icon(Icons.home, color:  Color(0xFF003366), size: 44),
                                    title: const Text('Home',
                                        style: TextStyle(fontSize: 20, fontFamily:'Nunito', fontWeight : FontWeight.bold, color: Color(0xFF00a896))),
                                    onTap : () {
                                      // Navigate to the home page
                                      Navigator.push(context, MaterialPageRoute( builder: (context) => const HomePage()));
                                    },
                                  ), const SizedBox(height: 40),

                                  // Deliveries button
                                  ListTile(
                                    leading:
                                    const Icon(Icons.motorcycle, color:  Color(0xFF003366), size: 44),
                                    title:  const Text('Deliveries',
                                        style: TextStyle(fontSize: 20, fontFamily:'Nunito', fontWeight : FontWeight.bold, color: Color(0xFF00a896))),
                                    onTap : () {
                                      Navigator.push(context, MaterialPageRoute( builder: (context) => DeliveriesPage(deliveries: _deliveries)));
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
                                      Navigator.push(context, MaterialPageRoute( builder: (context) => const LoginPage()));
                                    },
                                  ), const SizedBox(height: 210),

                                  // My account section
                                  Padding(padding : const EdgeInsets.all(8.0),
                                      child : Row(mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                          children:[
                                            ElevatedButton(onPressed : () {
                                              Navigator.push(context, MaterialPageRoute( builder: (context) => const AccountPage()));
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
              ])
          )));
    }
  }
