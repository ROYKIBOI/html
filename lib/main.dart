import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Import the splash screen
import 'responsive_design.dart'; // Import the responsive design widget
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';


// The main function that runs the app
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveDesign(
      child: MaterialApp(
        title: 'tuma.today',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(nextPage: LoginPage()), // Use the imported splash screen
      ),
    );
  }
}

// Function that returns an OutlineInputBorder with the desired properties
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: const BorderSide(color: Color(0xFF003366), width: 3),
  );
}

// The login page widget
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //final _formKey = GlobalKey<FormState>();
  final _logInEmailController = TextEditingController();
  final _logInPasswordController = TextEditingController();

  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // Display the app's title using RichText
            Stack(
              children: [
                RichText(
                  text: const TextSpan(
                    text: 'tuma',
                    style: TextStyle(
                        fontSize: 70,
                        fontFamily: 'Nunito',
                        color: Color(0xFF003366),
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(text: '.', style: TextStyle(color: Color(0xFF00a896))),
                      TextSpan(text: 'today', style: TextStyle(color: Color(0xFF003366))),
                    ],
                  ),
                ),
                const Positioned(
                  top: 70, left: 65,
                  child: Text('swift. secure. seamless',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Nunito',
                        color: Color(0xFF00a896),
                      )),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Email input field
            SizedBox(width: 300, height: 50,
              child: TextField(
                controller: _logInEmailController,
                textAlign : TextAlign.center,
                decoration: InputDecoration(
                  border : outlineInputBorder(),
                  focusedBorder : outlineInputBorder(),
                  enabledBorder : outlineInputBorder(),
                  hintText: 'Email',
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
                  alignLabelWithHint: true,
                  hintStyle:
                  const TextStyle(color: Colors.grey, fontFamily: 'Nunito'),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Password input field
            SizedBox(width: 300, height: 50,
              child: TextField(
                  controller: _logInPasswordController,
                  obscureText: _obscureText,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border : outlineInputBorder(),
                      focusedBorder : outlineInputBorder(),
                      enabledBorder : outlineInputBorder(),
                      hintText:  'Password',
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                      alignLabelWithHint: true,
                      hintStyle:
                      const TextStyle(color:
                      Colors.grey, fontFamily:
                      'Nunito'),
                      suffixIcon:
                      IconButton(icon:
                      Icon(_obscureText ?
                      Icons.visibility :
                      Icons.visibility_off),
                          onPressed: _togglePasswordVisibility)
                  )),
            ),
            const SizedBox(height: 20),


            // Login button
            ElevatedButton(
                onPressed: () async {
                  // Check if email and password are correct and found in the database
                  //TODO: bool isValid = await checkCredentials(email, password);
                  //TODO: if (isValid) {
                  // Redirect to home page
                  //TODO: Navigator.push(
                  //TODO: context,
                  MaterialPageRoute(builder: (context) => const HomePage());

                  //TODO:  } else {
                  // Show error message
                  //TODO: ScaffoldMessenger.of(context).showSnackBar(
                  //TODO:  SnackBar(content: Text('Invalid email or password')),
                  //TODO: );
                  //TODO: }
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                },
                style:ElevatedButton.styleFrom(primary:
                const Color(0xFF003366), shape:
                RoundedRectangleBorder(borderRadius:
                BorderRadius.circular(25))),
                child:
                const Text('Log In', style:
                TextStyle(color: Colors.white))),
            const SizedBox(height: 30),


            // Sign Up and Forgot Password buttons
            Row(mainAxisAlignment:
            MainAxisAlignment.center,
                children:<Widget>[

                  TextButton(onPressed:
                      () { Navigator.push(context, MaterialPageRoute(builder:(context) => const ForgotPasswordPage())); }
                      , child:
                      const Text('Forgot Password?', style : TextStyle(fontFamily : 'Nunito', color : Color(0xFF003366), fontWeight : FontWeight.bold))),
                  const SizedBox(width: 50),

                  TextButton(onPressed:
                      () {
                    Navigator.push(context, MaterialPageRoute(builder:(context) => const SignUpPage()));
                  }, child:
                  const Text('Sign Up', style : TextStyle(fontFamily : 'Nunito', color : Color(0xFF003366), fontWeight : FontWeight.bold))),
                ]),
          ],
        ),
      ),
    );
  }
}


// The sign up page widget
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  void _togglePasswordVisibility1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _togglePasswordVisibility2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // Display the app's title using RichText
            Stack(
              children: [
                RichText(
                  text: const TextSpan(
                    text: 'tuma',
                    style: TextStyle(
                        fontSize: 70,
                        fontFamily: 'Nunito',
                        color: Color(0xFF003366),
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(text: '.', style: TextStyle(color: Color(0xFF00a896))),
                      TextSpan(text: 'today', style: TextStyle(color: Color(0xFF003366))),
                    ],
                  ),
                ),
                const Positioned(
                  top: 70, left: 65,
                  child: Text('swift. secure. seamless',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Nunito',
                        color: Color(0xFF00a896),
                      )),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Email input field
            SizedBox(width: 300, height: 50,
              child: TextField(
                textAlign : TextAlign.center,
                decoration: InputDecoration(
                    border : outlineInputBorder(),
                    focusedBorder : outlineInputBorder(),
                    enabledBorder : outlineInputBorder(),
                    hintText:
                    'Email',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
                    alignLabelWithHint: true,
                    hintStyle:
                    const TextStyle(color: Colors.grey, fontFamily: 'Nunito')),
              ),
            ),
            const SizedBox(height: 20),

            // Password input field
            SizedBox(width: 300, height: 50,
              child: TextField(
                  obscureText: _obscureText1,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border : outlineInputBorder(),
                      focusedBorder : outlineInputBorder(),
                      enabledBorder : outlineInputBorder(),
                      hintText: 'Enter Password',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                      alignLabelWithHint: true,
                      hintStyle:
                      const TextStyle(color:
                      Colors.grey, fontFamily:
                      'Nunito'),
                      suffixIcon:
                      IconButton(icon:
                      Icon(_obscureText1 ?
                      Icons.visibility :
                      Icons.visibility_off),
                          onPressed:
                          _togglePasswordVisibility1)
                  )),
            ),
            const SizedBox(height: 20),

            // Confirm password input field
            SizedBox(width: 300, height: 50,
              child: TextField(
                  obscureText: _obscureText2,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border : outlineInputBorder(),
                      focusedBorder : outlineInputBorder(),
                      enabledBorder : outlineInputBorder(),
                      hintText: 'Confirm Password',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 10.0),
                      alignLabelWithHint: true,
                      hintStyle:
                      const TextStyle(color:
                      Colors.grey, fontFamily:
                      'Nunito'),
                      suffixIcon:
                      IconButton(icon:
                      Icon(_obscureText2 ?
                      Icons.visibility :
                      Icons.visibility_off),
                          onPressed:
                          _togglePasswordVisibility2)
                  )),
            ),
            const SizedBox(height: 20),

            // Confirmation button
            ElevatedButton(onPressed:
                () { Navigator.push(context, MaterialPageRoute(builder: (context) => const BusinessDetailsPage()));

              // Send email with link to business details page
              //TODO: sendEmail(email, 'Business Details', 'Please click this link to go to the business details page: <URL>');
            },
                style:ElevatedButton.styleFrom(primary:const Color(0xFF003366),
                    shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(25))),
                child:const Text('Confirm', style:TextStyle(color:Colors.white))),
          ],
        ),
      ),
    );
  }
}

// The forgot password page widget
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // Display the app's title using RichText
            Stack(
              children: [
                RichText(
                  text: const TextSpan(
                    text: 'tuma',
                    style: TextStyle(
                        fontSize: 70,
                        fontFamily: 'Nunito',
                        color: Color(0xFF003366),
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(text: '.', style: TextStyle(color: Color(0xFF00a896))),
                      TextSpan(text: 'today', style: TextStyle(color: Color(0xFF003366))),
                    ],
                  ),
                ),
                const Positioned(
                  top: 70, left: 65,
                  child: Text('swift. secure. seamless',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Nunito',
                        color: Color(0xFF00a896),
                      )),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Email input field
            SizedBox(width: 300, height: 50,
              child: TextField(
                textAlign : TextAlign.center,
                decoration: InputDecoration(
                    border : outlineInputBorder(),
                    focusedBorder : outlineInputBorder(),
                    enabledBorder : outlineInputBorder(),
                    hintText: 'Enter Email',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
                    alignLabelWithHint: true,
                    hintStyle:
                    const TextStyle(color:
                    Colors.grey, fontFamily:'Nunito')),
              ),
            ),
            const SizedBox(height: 20),

            // Submit button
            ElevatedButton(onPressed:
                () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPasswordPage()));
              // Send email with link to reset password page
              //TODO: sendEmail(email, 'Reset Password', 'Please click this link to reset your password: <URL>');

            }, style:ElevatedButton.styleFrom(primary:const Color(0xFF003366),
                shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(25))),
                child:const Text('Submit', style:TextStyle(color:Colors.white))),
          ],
        ),
      ),
    );
  }
}

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  void _togglePasswordVisibility1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _togglePasswordVisibility2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Display the app's title using RichText
            Stack(
              children: [
                RichText(
                  text: const TextSpan(
                    text: 'tuma',
                    style: TextStyle(
                        fontSize: 70,
                        fontFamily: 'Nunito',
                        color: Color(0xFF003366),
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(text: '.', style: TextStyle(color: Color(0xFF00a896))),
                      TextSpan(text: 'today', style: TextStyle(color: Color(0xFF003366))),
                    ],
                  ),
                ),
                const Positioned(
                  top: 70, left: 65,
                  child: Text('swift. secure. seamless',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Nunito',
                        color: Color(0xFF00a896),
                      )),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // New Password input field
            SizedBox(width: 300, height: 50, child:
            TextField(obscureText: _obscureText1,
                textAlign: TextAlign.center,
                decoration:
                InputDecoration(border :
                outlineInputBorder(),
                    focusedBorder : outlineInputBorder(),
                    enabledBorder : outlineInputBorder(),
                    hintText: 'New Password',
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0), alignLabelWithHint:
                    true, hintStyle:
                    const TextStyle(color: Colors.grey, fontFamily: 'Nunito'),
                    suffixIcon:
                    IconButton(icon:
                    Icon(_obscureText1 ?
                    Icons.visibility :
                    Icons.visibility_off),
                        onPressed:
                        _togglePasswordVisibility1)
                )),
            ),
            const SizedBox(height: 20),

            // Confirm password input field
            SizedBox(width: 300, height: 50,
              child: TextField(
                  obscureText: _obscureText2,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border : outlineInputBorder(),
                      focusedBorder : outlineInputBorder(),
                      enabledBorder : outlineInputBorder(),
                      hintText: 'Confirm Password',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 10.0),
                      alignLabelWithHint: true,
                      hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Nunito'),
                      suffixIcon:
                      IconButton(icon:
                      Icon(_obscureText2 ?
                      Icons.visibility :
                      Icons.visibility_off),
                          onPressed:
                          _togglePasswordVisibility2)
                  )),
            ),
            const SizedBox(height: 20),

            // Submit button
            ElevatedButton(onPressed:
                () {
              // TODO: Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));

            },
                style:ElevatedButton.styleFrom(primary:const Color(0xFF003366),
                    shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(25))),
                child:const Text('Confirm', style:TextStyle(color:Colors.white))),
          ],
        ),
      ),
    );
  }
}

// The business details page widget
class BusinessDetailsPage extends StatefulWidget {
  const BusinessDetailsPage({super.key});

  @override
  _BusinessDetailsPageState createState() => _BusinessDetailsPageState();
}

class _BusinessDetailsPageState extends State<BusinessDetailsPage> {
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _businessCategoryController = TextEditingController();
  String? _businessCategory;
  bool _termsAndConditionsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              // Display the app's title using RichText
              Stack(
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'tuma',
                      style: TextStyle(
                          fontSize: 70,
                          fontFamily: 'Nunito',
                          color: Color(0xFF003366),
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: '.', style: TextStyle(color: Color(0xFF00a896))),
                        TextSpan(text: 'today', style: TextStyle(color: Color(0xFF003366))),
                      ],
                    ),
                  ),
                  const Positioned(
                    top: 70, left: 65,
                    child: Text('swift. secure. seamless',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Nunito',
                          color: Color(0xFF00a896),
                        )),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Business name input field
              SizedBox( width: 300, height: 50,
                child: TextField(
                  controller: _businessNameController,
                  textAlign : TextAlign.center,
                  decoration: InputDecoration(
                      border : outlineInputBorder(),
                      focusedBorder : outlineInputBorder(),
                      enabledBorder : outlineInputBorder(),
                      hintText: 'Business Name',
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
                      alignLabelWithHint: true,
                      hintStyle:
                      const TextStyle(color: Colors.grey, fontFamily: 'Nunito')),
                ),
              ),
              const SizedBox(height: 20),

              // Phone number input field
              SizedBox(width: 300, height: 50, child:
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
                      hintStyle:
                      const TextStyle(color: Colors.grey, fontFamily: 'Nunito')))),
              const SizedBox(height: 20),

              // Location input field
              SizedBox(width: 300, height: 50,
                child: TextField(
                  controller: _locationController,
                  textAlign : TextAlign.center,
                  decoration: InputDecoration(
                      border : outlineInputBorder(),
                      focusedBorder : outlineInputBorder(),
                      enabledBorder : outlineInputBorder(),
                      hintText: 'Location',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
                      alignLabelWithHint: true,
                      hintStyle:
                      const TextStyle(color: Colors.grey, fontFamily: 'Nunito')),
                  onTap: () async {
                    // Prediction? prediction = await PlacesAutocomplete.show(
                    //  context: context,
                    // apiKey: '<YOUR_API_KEY>',
                    // mode: Mode.overlay,
                    // language: "en",
                    //  components: [Component(Component.country, "ke")],
                    //);

                    //if (prediction != null) {
                    // setState(() {
                    //   _locationController.text = prediction.description;
                    // });
                    //}
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Business category selection
              SizedBox( width: 300, height: 50,
                child: TextFormField(
                  controller: _businessCategoryController,
                  textAlign : TextAlign.center,
                  decoration: InputDecoration(
                      border: outlineInputBorder(),
                      focusedBorder: outlineInputBorder(),
                      enabledBorder: outlineInputBorder(),
                      hintText: 'Business Category',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 10.0),
                      alignLabelWithHint: true,
                      hintStyle:
                      const TextStyle(color: Colors.grey, fontFamily: 'Nunito')),

                  readOnly: true,
                  onTap: () {

                    // Show business category selection dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        TextEditingController _customCategoryController = TextEditingController();
                        List<String> _selectedCategories = [];
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return SimpleDialog(
                              title: const Text('Business Category', textAlign : TextAlign.center, style: TextStyle(fontSize: 20, fontFamily: 'Nunito', color: Color(0xFF003366), fontWeight : FontWeight.bold),
                              ),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Color(0xFF00a896), width: 3),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              children: [
                                ...<String>[
                                  'Jewellery',
                                  'Cosmetics',
                                  'Home Decor',
                                  'Perfume',
                                  'Clothes',
                                  'Fashion Accessories',
                                  'Other'
                                ].map<Widget>((value) {
                                  return CheckboxListTile(
                                    title: Text(value, style : const TextStyle(color : Color(0xFF003366))),
                                    value: _selectedCategories.contains(value),
                                    onChanged: (bool? newValue) {
                                      if (newValue == true) {
                                        setState(() {
                                          _selectedCategories.add(value);
                                        });
                                      } else {
                                        setState(() {
                                          _selectedCategories.remove(value);
                                        });
                                      }
                                    },
                                    activeColor: const Color(0xFF00a896),
                                  );
                                }),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal:
                                  16.0),
                                  child:
                                  TextButton(onPressed:
                                      () {
                                    setState(() {
                                      _businessCategoryController.text = _selectedCategories.join(', ');
                                    });
                                    Navigator.pop(context);
                                  },
                                      child:
                                      const Text('OK', style: TextStyle(fontSize: 14, fontFamily: 'Nunito', color: Color(0xFF003366), fontWeight : FontWeight.bold),
                                      )),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              // Terms and conditions checkbox and text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    value: _termsAndConditionsAccepted,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _termsAndConditionsAccepted = newValue ?? false;
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () {

                      // Show terms and conditions dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: const SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('Terms and Conditions'),
                                  // Insert terms and conditions text here
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Accept', style: TextStyle(fontSize: 16, fontFamily: 'Nunito', color: Color(0xFF003366), fontWeight : FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Terms and Conditions',style : TextStyle(fontSize : 14,
                        fontFamily : 'Nunito',color : Color(0xFF003366),fontWeight : FontWeight.bold
                    )),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Get started button
              ElevatedButton(
                  onPressed: () {
                    // Check if terms and conditions are accepted
                    if (_termsAndConditionsAccepted) {
                      // Perform validation and submission logic here
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                    } else {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please accept the terms and conditions')),
                      );
                    }
                    // Perform validation and submission logic here
                  },
                  style:ElevatedButton.styleFrom(primary:const Color(0xFF003366),
                      shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(25))),
                  child:const Text('Get Started', style:TextStyle(color:Colors.white))

              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _salutation = '';
  bool _isMenuOpen = false;

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
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Nav bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50,),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        // Profile pic and salutation
                        Row(
                          children: [
                            // Profile pic
                            GestureDetector(
                              onTap: () {
                                // TODO: Navigator.push(context, MaterialPageRoute(builder: (context) => AvatarSelectionPage()));
                              },
                              child:
                              const CircleAvatar(
                                backgroundColor: Colors.grey, radius: 40,
                              ),
                            ),
                            const SizedBox(width: 50),

                            // Salutation
                            Text(_salutation, style: const TextStyle(color: Color(0xFF003366), fontSize: 16, fontFamily: 'Nunito', fontWeight: FontWeight.bold)),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 50,),
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
                              icon: const Icon(Icons.menu, color: Color(0xFF003366), size: 50),
                              onPressed: () {
                                setState(() => _isMenuOpen = !_isMenuOpen);
                              },
                            ),
                          ],
                        )
                      ]
                  ),
                ),

                Expanded(
                    child:
                    Column(mainAxisAlignment:
                    MainAxisAlignment.center,
                        children:[

                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder:(context) => const DeliveryRequestPage()));
                                },
                                style:
                                ElevatedButton.styleFrom(primary: const Color(0xFF00a896),
                                    fixedSize: const Size(200,70),
                                    shape: RoundedRectangleBorder(borderRadius:
                                    BorderRadius.circular(10))
                                ),
                                child:
                                const Padding(padding: EdgeInsets.only(left: 70),
                                  child:
                                  Column(mainAxisAlignment:
                                  MainAxisAlignment.center,
                                      children:[
                                        Text('Delivery',
                                            style:
                                            TextStyle(fontFamily:'Nunito', fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,)
                                        ),
                                        Text('Request',
                                            style:
                                            TextStyle(fontFamily:'Nunito', fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,)
                                        ),
                                      ]
                                  ),
                                ),
                              ),
                              const Positioned(top:-50,left:-10,
                                  child:
                                  Icon(Icons.note_add_outlined,color: Color(0xFF003366),size: 120)
                              ),
                            ],
                          )
                        ])
                )
              ],
            ),

            // Menu dropdown
            if (_isMenuOpen)
              Positioned(
                top:kToolbarHeight + MediaQuery.of(context).padding.top +75,right:35,
                child:
                AnimatedContainer(duration:
                const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,height: 350, width: 250,
                  decoration:
                  BoxDecoration(color: Colors.white,border:
                  Border.all(color: const Color(0xFF00a896),width: 3),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                  ),
                  child:
                  SingleChildScrollView(child:
                  Column(crossAxisAlignment:
                  CrossAxisAlignment.start,
                      children:[
                        const SizedBox(height: 20),
                        TextButton.icon(onPressed: () {

                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const HomePage()));
                        },
                            icon: const Icon(Icons.home,color:  Color(0xFF003366), size: 44),

                            label: const Text('Home',style:
                            TextStyle(color: Color(0xFF00a896),fontSize :20, fontFamily: 'Nunito',fontWeight: FontWeight.bold))
                        ),
                        const SizedBox(height: 40),

                        TextButton.icon(onPressed: () {
                          Navigator.pop(context);
                          //TODO: Navigator.push(context, MaterialPageRoute(builder:(context) => DeliveriesPage()));
                        },
                            icon: const Icon(Icons.motorcycle,color: Color(0xFF003366), size: 44),
                            label: const Text('Deliveries',style:
                            TextStyle(color: Color(0xFF00a896),fontSize :20, fontFamily: 'Nunito',fontWeight: FontWeight.bold))
                        ),
                        const SizedBox(height: 40),

                        TextButton.icon(onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const LoginPage()));
                        },

                            icon: const Icon(Icons.logout,color: Color(0xFF003366), size: 44),
                            label: const Text('Log Out',style:
                            TextStyle(color: Color(0xFF00a896), fontSize :20, fontFamily: 'Nunito',fontWeight: FontWeight.bold))
                        ),
                        const SizedBox(height: 65),

                        Row(children:[
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder:(context) => AccountPage()));
                              },
                              child: const Text('My Account',
                                  style: TextStyle(fontFamily: 'Nunito', color: Colors.white, fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(primary: const Color(0xFF00a896),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                            ),
                          ),
                          const SizedBox(width: 70),
                          const CircleAvatar(backgroundColor: Colors.grey, radius: 20,),
                        ])


                      ])),

                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final String errorMessage;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function(String)? onFieldSubmitted;
  final VoidCallback? onTap;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.errorMessage,
    required this.controller,
    required this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.onTap,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isValid = true;

  void setValid(bool isValid) {
    setState(() => _isValid = isValid);
  }

  @override
  Widget build(BuildContext context) {
    return Container(width: 300, height: 40,
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: (value) {
          setState(() => _isValid = value.isNotEmpty);
        },
        style: const TextStyle(
          color: Colors.white, fontSize: 18, fontFamily: 'Nunito', fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: _isValid ? widget.hintText : widget.errorMessage,
          hintStyle: TextStyle(
            color: _isValid ? Colors.white : const Color(0xFF003366),
            fontSize: 12, fontFamily: 'Nunito',
          ),
          fillColor: const Color(0xFF00a896),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 60),
        ),
      ),
    );
  }
}


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

  bool _isMenuOpen = false;

  final _nameKey = GlobalKey<_CustomTextFormFieldState>();
  final _contactKey = GlobalKey<_CustomTextFormFieldState>();
  final _locationKey = GlobalKey<_CustomTextFormFieldState>();

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

                        // Profile pic
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // TODO: Navigator.push(context, MaterialPageRoute(builder: (context) => AvatarSelectionPage()));
                              },
                              child:
                              const CircleAvatar(
                                backgroundColor: Colors.grey, radius: 40,
                              ),
                            ),
                            const SizedBox(width: 50),


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
                                setState(() => _isMenuOpen = !_isMenuOpen);
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


            // Menu dropdown
            if (_isMenuOpen)
              Positioned(
                top: kToolbarHeight + MediaQuery.of(context).padding.top + 75,
                right: 35,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: 350,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFF00a896), width: 3),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                  ),
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            TextButton.icon(onPressed: () {

                              Navigator.pop(context);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => const HomePage()));
                            },
                                icon: const Icon(Icons.home,color:  Color(0xFF003366), size: 44),

                                label: const Text('Home',style:
                                TextStyle(color: Color(0xFF00a896),fontSize :20, fontFamily: 'Nunito',fontWeight: FontWeight.bold))
                            ),
                            const SizedBox(height: 40),

                            TextButton.icon(onPressed: () {
                              Navigator.pop(context);
                              //TODO: Navigator.push(context, MaterialPageRoute(builder:(context) => DeliveriesPage()));
                            },
                                icon: const Icon(Icons.motorcycle,color: Color(0xFF003366), size: 44),
                                label: const Text('Deliveries',style:
                                TextStyle(color: Color(0xFF00a896),fontSize :20, fontFamily: 'Nunito',fontWeight: FontWeight.bold))
                            ),
                            const SizedBox(height: 40),

                            TextButton.icon(onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => const LoginPage()));
                            },

                                icon: const Icon(Icons.logout,color: Color(0xFF003366), size: 44),
                                label: const Text('Log Out',style:
                                TextStyle(color: Color(0xFF00a896), fontSize :20, fontFamily: 'Nunito',fontWeight: FontWeight.bold))
                            ),
                            const SizedBox(height: 65),

                            Row(children:[
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    //TODO: Navigator.push(context, MaterialPageRoute(builder:(context) => AccountPage()));
                                  },
                                  child: const Text('My Account',
                                      style: TextStyle(fontFamily: 'Nunito', color: Colors.white, fontWeight: FontWeight.bold)),
                                  style: ElevatedButton.styleFrom(primary: const Color(0xFF00a896),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                ),
                              ),
                              const SizedBox(width: 70),
                              const CircleAvatar(backgroundColor: Colors.grey, radius: 20,),
                            ])


                          ])),

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

class DeliveriesPage extends StatefulWidget {
  final List<Map<String, dynamic>> deliveries;

  const DeliveriesPage({Key? key, required this.deliveries}) : super(key: key);

  @override
  _DeliveriesPageState createState() => _DeliveriesPageState();
}

class _DeliveriesPageState extends State<DeliveriesPage> {
  bool _isMenuOpen = false;
  String _filter = 'All';

// TODO Replace with actual data from backend
  List<Map<String, dynamic>> _deliveries = [
    {
      'orderNumber': '12345',
      'customerName': 'John Doe',
      'customerLocation': 'Nairobi',
      'rider': 'Jane Doe',
      'status': 'To Assign',
    },
    {
      'orderNumber': '67890',
      'customerName': 'Bob Smith',
      'customerLocation': 'Mombasa',
      'rider': 'Alice Johnson',
      'status': 'To Pick Up',
    },
    {
      'orderNumber': '111213',
      'customerName': 'Charlie Brown',
      'customerLocation': 'Kisumu',
      'rider': 'Eve Black',
      'status': 'En-Route',
    },
    {
      'orderNumber': '141516',
      'customerName': 'Dave White',
      'customerLocation': 'Nakuru',
      'rider': 'Frank Green',
      'status': 'Delivered',
    },
  ];

  @override
  void initState() {
    super.initState();
    _deliveries.addAll(widget.deliveries);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor :Colors.white,body :
    SafeArea(child :
    Stack(children:[
      Column(children:[
// Nav bar
        Padding(padding :
        const EdgeInsets.symmetric(horizontal :50,vertical :20),child :
        Row(mainAxisAlignment :MainAxisAlignment.spaceBetween,children:[
// Profile pic
          Row(children:[
            GestureDetector(onTap :
                () {
// TODO Navigator.push(context, MaterialPageRoute(builder:(context) =>AvatarSelectionPage()));
            },child :
            const CircleAvatar(backgroundColor :Colors.grey,radius :40),),
            const SizedBox(width :50),]),
          const SizedBox(width :300),
// Menu
          Row(children:[
            Padding(padding :
            const EdgeInsets.only(top :20), // Add this line
              child :
              Container(width :180,height :40,decoration:
              BoxDecoration(color:
              Colors.white,borderRadius:
              BorderRadius.circular(30),border:
              Border.all(color:
              const Color(0xFF003366),width:
              2)),child:
              DropdownButtonHideUnderline(child:
              DropdownButton<String>(value:
              _filter,iconSize:
              30,iconEnabledColor:
              const Color(0xFF00a896),onChanged:
                  (String? newValue) {
                setState(() {
                  _filter = newValue!;
                });
              },items:
              <String>['All','Today','Last 7 days','Last month','Older'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(value:value,child:Padding(padding:
                const EdgeInsets.only(left:20),child:
                Text(value)));
              }).toList(),),),),),
            const SizedBox(width :10),

// Nav bar icon
            IconButton(icon:
            const Icon(Icons.menu,color :Color(0xFF003366),size :50),onPressed :
                () {
              setState(() =>_isMenuOpen =!_isMenuOpen);
            },),

          ])
        ]),),


        Expanded(child:
        SingleChildScrollView(child:
        Column(mainAxisAlignment :MainAxisAlignment.center,children:[
          Stack(clipBehavior :Clip.none,children:[
            Form(child:
            Column(children:[
              const Padding(padding:
              EdgeInsets.symmetric(horizontal :150.0,vertical :2),child:
              Row(mainAxisAlignment:
              MainAxisAlignment.spaceBetween,children:[
                Text('All Deliveries',style:
                TextStyle(fontSize :20,
                    fontFamily :'Nunito',color :
                    Color(0xFF003366),fontWeight :
                    FontWeight.bold)),

              ])),
              // Menu dropdown
              if (_isMenuOpen)
                Stack(
                  children: [
                    Positioned(
                      top: kToolbarHeight + MediaQuery.of(context).padding.top + 100,
                      right: 35,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        height: 350,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFF00a896), width: 3),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25)),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height :20),
                              TextButton.icon(onPressed :
                                  () {
                                Navigator.pop(context);
                                Navigator.push(context,MaterialPageRoute(builder :(context) =>const HomePage()));
                              },icon :
                              const Icon(Icons.home,color :Color(0xFF003366),size :44),label :
                              const Text('Home',style :TextStyle(color :Color(0xFF00a896),fontSize :20,fontFamily :'Nunito',fontWeight :FontWeight.bold))),
                              const SizedBox(height :40),
                              TextButton.icon(onPressed :
                                  () {
                                Navigator.pop(context);
//TODO
                              },icon :
                              const Icon(Icons.motorcycle,color :Color(0xFF003366),size :44),label :
                              const Text('Deliveries',style :TextStyle(color :Color(0xFF00a896),fontSize :20,fontFamily :'Nunito',fontWeight :FontWeight.bold))),
                              const SizedBox(height :40),
                              TextButton.icon(onPressed :
                                  () {
                                Navigator.pop(context);
                                Navigator.push(context,MaterialPageRoute(builder :(context) =>const LoginPage()));
                              },icon :
                              const Icon(Icons.logout,color :Color(0xFF003366),size :44),label :
                              const Text('Log Out',style :TextStyle(color :Color(0xFF00a896),fontSize :20,fontFamily :'Nunito',fontWeight :FontWeight.bold))),
                              const SizedBox(height :65),
                              Row(children:[
                                Padding(padding :
                                const EdgeInsets.only(left :10),child :
                                ElevatedButton(onPressed :
                                    () {
//TODO
                                },child :
                                const Text('My Account',style:
                                TextStyle(fontFamily :'Nunito',color:
                                Colors.white,fontWeight:
                                FontWeight.bold)),style:
                                ElevatedButton.styleFrom(primary:
                                const Color(0xFF00a896),shape:
                                RoundedRectangleBorder(borderRadius:
                                BorderRadius.circular(15))))),
                              ]),
                              const SizedBox(width:70),
                              const CircleAvatar(backgroundColor:
                              Colors.grey,radius:20,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ..._deliveries.map((delivery) {
                return Card(shape :
                RoundedRectangleBorder(borderRadius :
                BorderRadius.circular(15)),margin :
                const EdgeInsets.symmetric(vertical :
                5,horizontal :20),child :
                Container(width :1080,height :100,decoration :
                BoxDecoration(borderRadius :
                BorderRadius.circular(20),border :
                Border.all(color :
                const Color(0xFF003366),width :
                2)),child :
                Padding(padding :
                const EdgeInsets.all(10),child :
                Column(crossAxisAlignment :
                CrossAxisAlignment.start,children:[
                  Row(mainAxisAlignment :
                  MainAxisAlignment.spaceBetween,children:[
                    Column(crossAxisAlignment :
                    CrossAxisAlignment.start,children:[
                      Text('Order number:${delivery['orderNumber']}',style :
                      const TextStyle(color :
                      Color(0xFF003366),fontWeight :
                      FontWeight.bold)),
                      Text('Customer name: ${delivery['customerName']}',
                          style: const TextStyle(
                              color: Color(0xFF003366),
                              fontWeight: FontWeight.bold)),
                      Text('Customer location: ${delivery['customerLocation']}',
                          style: const TextStyle(
                              color: Color(0xFF003366),
                              fontWeight: FontWeight.bold)),
                      Text('Rider: ${delivery['rider']}',
                          style: const TextStyle(
                              color: Color(0xFF003366),
                              fontWeight: FontWeight.bold)),
                    ]),
                    const Spacer(),
                    Align(alignment :Alignment.bottomRight,child :
                    Container(width :100,height :30,decoration:
                    BoxDecoration(borderRadius:
                    BorderRadius.circular(15),color:
                    const Color(0xFF00a896)),child:
                    Center(child:
                    Text(delivery['status'],style:
                    TextStyle(color:
                    delivery['status'] =='To Assign' ?Colors.red
                        : delivery['status'] =='To Pick Up' ?Colors.yellow
                        : delivery['status'] =='En-Route' ?Color(0xFF1B5E20)
                        : const Color(0xFF003366)))))),
                  ])
                ]))));
              }).toList()

            ]))
          ])
        ]))
        ),


      ])
    ])
    ));

  }
}



class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:
        SingleChildScrollView(child:
        Column(crossAxisAlignment:
        CrossAxisAlignment.start,
            children:[
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal:
                16.0, vertical :16.0),
                child:
                Row(children:[
                  GestureDetector(
                    onTap: () {
                      // Show options to upload photo or open camera
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children:<Widget>[
                              ListTile(
                                leading:
                                const Icon(Icons.photo_library),
                                title:
                                const Text('Upload Photo'),
                                onTap:
                                    () {
                                  // TODO:
                                  // Implement photo upload logic
                                },
                              ),
                              ListTile(
                                leading:
                                const Icon(Icons.camera_alt),
                                title:
                                const Text('Open Camera'),
                                onTap:
                                    () {
                                  // TODO:
                                  // Implement camera logic
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child:
                    Stack(children:[
                      CircleAvatar(backgroundColor:
                      Colors.grey, radius :40,),
                      Positioned(top:-10,left:-10,
                          child:
                          Icon(Icons.camera_alt,color:
                          Color(0xFF003366),size :80)
                      ),
                    ]),
                  ),
                  Padding(padding :
                  const EdgeInsets.only(left :20),
                      child :
                      Column(crossAxisAlignment :
                      CrossAxisAlignment.start,
                          children:[
                            Row(children:[
                              Icon(Icons.business,color :
                              Color(0xFF003366),size :40),
                              Padding(padding :
                              const EdgeInsets.only(left :10),
                                  child :
                                  Text('Business Name',
                                      style :
                                      TextStyle(color :
                                      Color(0xFF003366),fontSize :20, fontFamily : 'Nunito',fontWeight : FontWeight.bold))
                              )
                            ]),
                            Row(children:[
                              Icon(Icons.location_on,color :
                              Color(0xFF003366),size :40),
                              Padding(padding :
                              const EdgeInsets.only(left :10),
                                  child :
                                  Text('Business Location',
                                      style :
                                      TextStyle(color :
                                      Color(0xFF003366),fontSize :20, fontFamily : 'Nunito',fontWeight : FontWeight.bold))
                              )
                            ]),
                            Row(children:[
                              Icon(Icons.email,color :
                              Color(0xFF003366),size :40),
                              Padding(padding :
                              const EdgeInsets.only(left :10),
                                  child :
                                  Text('Business Email',
                                      style :
                                      TextStyle(color :
                                      Color(0xFF003366),fontSize :20, fontFamily : 'Nunito',fontWeight : FontWeight.bold))
                              )
                            ]),
                            Padding(padding :
                            const EdgeInsets.only(top :20),
                                child :
                                ElevatedButton(onPressed:
                                    () {
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
                                          Text('Name: Business Name',
                                              style :
                                              TextStyle(color :
                                              Color(0xFF003366),fontSize :20, fontFamily : 'Nunito',fontWeight : FontWeight.bold)),
                                          TextField(
                                            controller:
                                            _locationController,
                                            textAlign :
                                            TextAlign.center,
                                            decoration:
                                            InputDecoration(
                                                border :
                                                outlineInputBorder(),
                                                focusedBorder :
                                                outlineInputBorder(),
                                                enabledBorder :
                                                outlineInputBorder(),
                                                hintText:
                                                'Location',
                                                contentPadding:
                                                const EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
                                                alignLabelWithHint:
                                                true,
                                                hintStyle:
                                                const TextStyle(color: Colors.grey, fontFamily: 'Nunito')),
                                          ),
                                          TextField(
                                            controller:
                                            _phoneNumberController,
                                            textAlign :
                                            TextAlign.center,
                                            decoration:
                                            InputDecoration(
                                                border :
                                                outlineInputBorder(),
                                                focusedBorder :
                                                outlineInputBorder(),
                                                enabledBorder :
                                                outlineInputBorder(),
                                                hintText:
                                                'Phone Number',
                                                contentPadding:
                                                const EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
                                                alignLabelWithHint:
                                                true,
                                                hintStyle:
                                                const TextStyle(color: Colors.grey, fontFamily: 'Nunito')),
                                          ),
                                        ])),
                                        actions:<Widget>[
                                          TextButton(onPressed:
                                              () {
                                            // TODO:
                                            // Implement save logic
                                            Navigator.of(context).pop();
                                          },
                                              child:
                                              const Text('Save',
                                                style:
                                                TextStyle(fontSize: 16, fontFamily: 'Nunito', color: Color(0xFF003366), fontWeight : FontWeight.bold),
                                              )),
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
                ]),
              ),
              Padding(padding :
              const EdgeInsets.only(left :80,top :80),
                  child :
                  Column(crossAxisAlignment :
                  CrossAxisAlignment.start,
                      children:[
                        Row(children:[
                          Icon(Icons.headset_mic,color :
                          Color(0xFF003366),size :40),
                          Padding(padding :
                          const EdgeInsets.only(left :10),
                              child :
                              Text('Support',
                                  style :
                                  TextStyle(color :
                                  Color(0xFF003366),fontSize :20, fontFamily : 'Nunito',fontWeight : FontWeight.bold))
                          )
                        ]),
                        Padding(padding :
                        const EdgeInsets.only(left :50,top :20),
                            child :
                            Column(crossAxisAlignment :
                            CrossAxisAlignment.start,
                                children:[
                                  Text('+254 704 134 095',
                                      style :
                                      TextStyle(color :
                                      Color(0xFF003366),fontSize :16, fontFamily : 'Nunito',fontWeight : FontWeight.bold)),
                                  Text('hello@try.ke',
                                      style :
                                      TextStyle(color :
                                      Color(0xFF003366),fontSize :16, fontFamily : 'Nunito',fontWeight : FontWeight.bold)),
                                ])
                        ),
                        Padding(padding :
                        const EdgeInsets.only(top :150,left :150),
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
                                    ListBody(children:<Widget>[
                                      Text('Terms and Conditions'),
                                      // Insert terms and conditions text here
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
                                child : Text('Terms & Conditions',
                                    style :
                                    TextStyle(color :
                                    Color(0xFF003366),fontSize :20, fontFamily : 'Nunito',fontWeight : FontWeight.bold))
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




