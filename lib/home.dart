// home.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Import the pages
import '../user_details.dart';
import 'delivery_request.dart';
import 'deliveries.dart';
import '../account.dart';
import 'assets/environment_variables.dart';

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
  // Assuming you have a reference to your UserSession
  final UserSession userSession = UserSession();

  List<Map<String, dynamic>> deliveries = <Map<String, dynamic>>[];
  Color _buttonColor = const Color(0xFF00a896);

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

  // for the delivery request
  void _handleDeliveryRequestNavigation() {
    final userEmail = userSession.getUserEmail() ?? '';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeliveryRequestPage(deliveries: deliveries, userEmail: userEmail),
      ),
    );
  }


  // for the delivery page
  void _handleDeliveriesNavigation() {

    // Fetch deliveries and send email to backend when the widget is initialized
    final userSession = Provider.of<UserSession>(context, listen: false);
    final userEmail = userSession.getUserEmail() ?? '';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeliveriesPage(userEmail: userEmail),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // get userEmail

    // Get the UserSession instance within the build method
    final userSession = Provider.of<UserSession>(context);

    // Get the user's email
    final userEmail = userSession.getUserEmail();


    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h,),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        // Profile pic and salutation
                        Row(
                          children: [

                            // Profile picture
                            Positioned(
                              top: MediaQuery.of(context).padding.top + 80.h, left: 10.w,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // view profile pic
                                  });
                                },
                                child: CircleAvatar(radius: 15.sp, backgroundColor: Colors.grey,
                                  // TODO:
                                  // Replace with the actual profile picture of the rider
                                  child: Icon(Icons.person, size: 15.sp, color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 5.w, height: 50.h,),

                            // Salutation
                            Text(_salutation, style: TextStyle(color: const Color(0xFF003366), fontSize: 5.sp, fontFamily: 'Nunito', fontWeight: FontWeight.bold)),
                             Padding(
                              padding: EdgeInsets.symmetric(vertical: 40.h,),
                            ),
                          ],
                        ),  SizedBox(width: 160.w),

                        // Menu
                        Row(
                          children: [
                            SizedBox(width: 15.w),

                            // Nav bar icon
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() => _showPopup = !_showPopup);
                                },
                                child: Icon(Icons.menu, color: const Color(0xFF003366), size: 15.sp,
                                ),
                              ),
                            )

                          ],
                        )
                      ]
                  ),
                ),

                    Image.asset('images/bike.png',
                      width: screenWidth * 0.5,  // Adjust size based on screen width
                      height: screenHeight * 0.5,  // Adjust size based on screen height
                    ),


                    SizedBox(height: 10.h),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              MouseRegion(
                                onEnter: (event) => setState(() => _buttonColor = const Color(0xFF02C39A)),
                                onExit: (event) => setState(() => _buttonColor = const Color(0xFF00a896)),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _handleDeliveryRequestNavigation; // Call the method when the button is pressed
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: _buttonColor,
                                    fixedSize: Size(55.w, 80.h),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.sp)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.w),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Delivery\nRequest',
                                          style: TextStyle(fontFamily: 'Nunito', fontSize: 6.sp, color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(top: -55.h, left: -10.w,
                                child: Icon(Icons.note_add_outlined, color: Color(0xFF003366), size: 30.sp),
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
                    top: MediaQuery.of(context).padding.top + 20.w,  // Use .w for width
                    right: 15.w,  // Use .w for width
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.2,  // Adjust width based on screen width
                      height: MediaQuery.of(context).size.height * 0.8,  // Adjust height based on screen height
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.sp),
                          bottomLeft: Radius.circular(6.sp),
                          bottomRight: Radius.circular(6.sp),
                        ),
                        border: Border.all(color: const Color(0xFF00a896), width: 0.5.w),  // Use .w for width
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              SizedBox(height : 40.h),  // Use .h for height

                              ListTile(
                                leading :
                              Icon(Icons.home, color :  const Color(0xFF003366), size : 10.sp),
                                title : Text('Home',
                                    style : TextStyle(fontSize :5.sp, fontFamily:'Nunito', fontWeight : FontWeight.bold, color : const Color(0xFF00a896))),  // Use .sp for font size
                                onTap : () {
                                  Navigator.push(context, MaterialPageRoute( builder : (context) => const HomePage()));
                                },
                              ), SizedBox(height :40.h),

                              // Deliveries button
                        ListTile(
                          leading:
                          Icon(Icons.motorcycle, color :  const Color(0xFF003366), size : 10.sp),
                          title:  Text('Deliveries',
                              style: TextStyle(fontSize :5.sp, fontFamily:'Nunito', fontWeight : FontWeight.bold, color : const Color(0xFF00a896))),
                          onTap : () {
                            _handleDeliveriesNavigation();
                            },
                        ),SizedBox(height :40.h),

                        // Log out button
                        ListTile(
                          leading:
                          Icon(Icons.logout, color :  const Color(0xFF003366), size : 10.sp),
                          title: Text('Log Out',
                              style: TextStyle(fontSize :5.sp, fontFamily:'Nunito', fontWeight : FontWeight.bold, color : const Color(0xFF00a896))),
                          onTap : () {

                            // Clear the user session
                            userSession.clearSession();

                            // Log out and navigate to the login page
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                          },
                        ), SizedBox(height :190.h),

                        // My account section
                        Padding(padding : EdgeInsets.all(10.h),
                            child : Row(mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                children:[
                                  ElevatedButton(onPressed : () {
                                    Navigator.push(context, MaterialPageRoute( builder: (context) => const AccountPage()));
                                    },
                                      child : Text('My Account',
                                      style : TextStyle(color : Colors.white, fontSize :3.5.sp, fontFamily:'Nunito', fontWeight : FontWeight.bold, )),
                                      style : ElevatedButton.styleFrom(primary : const Color(0xFF00a896),
                                          shape : RoundedRectangleBorder(borderRadius : BorderRadius.circular(10.sp)))),
                                  CircleAvatar(radius : 8.sp, backgroundColor : Colors.grey,
                                      child : Icon(Icons.person, size : 7.sp, color : Colors.white))
                                ])),
                      ]),
                ),
              ),
              )
          ],
        ),
      ),
        )
    );
  }
}