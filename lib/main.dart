import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Import the splash screen
import 'responsive_design.dart'; // Import the responsive design widget
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:another_flushbar/flushbar_route.dart';
//import 'package:sendgrid_mailer/sendgrid_mailer.dart';
import 'loading_animation.dart'; // Import the LoadingAnimation widget
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';


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

  Future<bool> checkCredentials(String email, String password) async {
    // TODO: Implement code to check email and password against database
    // Return true if email and password are valid, false otherwise
    return false;
  }
  bool _obscureText = true;

  // Toggles the visibility of the password
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Displays an error message as a popup with red, almost transparent background at the top center of the window for 15 seconds
  void _showErrorMessage(String message) {
    Flushbar(
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white.withOpacity(1.0),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.only(bottom: 80, left: 2, right: 2),
      maxWidth: 350,
      borderRadius: BorderRadius.circular(25),
      duration: const Duration(seconds: 10),
    ).show(context);
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
                    style: TextStyle( fontSize: 70, fontFamily: 'Nunito', color: Color(0xFF003366), fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(text: '.', style: TextStyle(color: Color(0xFF00a896))),
                      TextSpan(text: 'today', style: TextStyle(color: Color(0xFF003366))),
                    ],
                  ),
                ),
                const Positioned(
                  top: 70, left: 65,
                  child: Text('swift. secure. seamless',
                      style: TextStyle( fontSize: 22, fontFamily: 'Nunito', color: Color(0xFF00a896),
                      )),
                ),
              ],
            ), const SizedBox(height: 30),

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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
                  alignLabelWithHint: true,
                  hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Nunito'),
                ),
              ),
            ), const SizedBox(height: 20),

            // Password input field
            SizedBox(width: 300, height: 50,
              child:
              TextField(controller: _logInPasswordController,
                  obscureText: _obscureText,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(border :
                  outlineInputBorder(),
                      focusedBorder : outlineInputBorder(),
                      enabledBorder : outlineInputBorder(),
                      hintText: 'Password',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
                      alignLabelWithHint: true,
                      hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Nunito'),
                      suffixIcon:
                      IconButton(icon: Icon(_obscureText ?
                      Icons.visibility : Icons.visibility_off),
                          onPressed: _togglePasswordVisibility)
                  )),
            ), const SizedBox(height: 20),

            ElevatedButton(
                onPressed :() async {
                  // Check if email and password fields are not empty
                  if (_logInEmailController.text.isEmpty || _logInPasswordController.text.isEmpty) {
                    // Show error message if either one or all fields are empty
                    _showErrorMessage('Please enter your email and password');
                    return;
                  }

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

                  // Check if email and password are correct and found in the database (this will be done in the backend)
                  // TODO : bool isValid = await checkCredentials(_logInEmailController.text, _logInPasswordController.text);
                  // TODO : if (isValid) {
                  // Redirect to home page if email and password are valid
                  Navigator.push(context, MaterialPageRoute(builder:(context) => const HomePage()));
                  // TODO : } else {
                  // Show error message if email or password is invalid
                  // TODO : _showErrorMessage('Invalid email or password');
                  // TODO : }
                },
                style:ElevatedButton.styleFrom(primary : const Color(0xFF003366),
                    shape : RoundedRectangleBorder(borderRadius : BorderRadius.circular(25))),
                child : const Text('Log In', style : TextStyle(color : Colors.white))
            ),

            //When the user clicks the Log In button, the email and password entered by the user will be checked against the database to see if they are valid.
            //If the email and password are found to be valid, the user will be redirected to the home page of the app.
            //If the email and password are not valid, an error message will be displayed
            const SizedBox(height : 30),

            // Sign Up and Forgot Password buttons
            Row(mainAxisAlignment : MainAxisAlignment.center, children:<Widget>[
              // Forgot Password button - redirects to ForgotPasswordPage when pressed
              TextButton(onPressed : () { Navigator.push(context, MaterialPageRoute(builder:(context) => ForgotPasswordPage())); }, child : const Text('Forgot Password?', style : TextStyle(fontFamily : 'Nunito', color : Color(0xFF003366), fontWeight : FontWeight.bold))),
              const SizedBox(width : 50),

              // Sign Up button - redirects to SignUpPage when pressed
              TextButton(onPressed : () { Navigator.push(context, MaterialPageRoute(builder:(context) => const SignUpPage())); }, child : const Text('Sign Up', style : TextStyle(fontFamily : 'Nunito', color : Color(0xFF003366), fontWeight : FontWeight.bold))),
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
  _SignUpPageState createState() => _SignUpPageState(); // Creates the mutable state for this widget
}

class _SignUpPageState extends State<SignUpPage> {
  // Controllers for the text fields
  final _signUpEmailController = TextEditingController();
  final _signUpPasswordController = TextEditingController();
  final _signUpConfirmPasswordController = TextEditingController();

  // Variables to control the visibility of the password fields
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  // Toggles the visibility of the password field
  void _togglePasswordVisibility1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  // Toggles the visibility of the confirm password field
  void _togglePasswordVisibility2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  // Displays an error message as a popup with red, almost transparent background at the top center of the window for 15 seconds
  void _showErrorMessage(String message) {
    Flushbar(
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white.withOpacity(1.0),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.only(bottom: 60, left: 2, right: 2),
      maxWidth: 350,
      borderRadius: BorderRadius.circular(25),
      duration: const Duration(seconds: 10),
    ).show(context);
  }

  // Validates email using regex
  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // Validates password strength using regex
  bool _isPasswordStrong(String password) {
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return passwordRegex.hasMatch(password);
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
            ), const SizedBox(height: 30),

            // Email input field
            SizedBox(width: 300, height: 50,
              child: TextField(
                controller: _signUpEmailController, // Controls the text of the email field
                textAlign : TextAlign.center,
                decoration: InputDecoration(
                    border : outlineInputBorder(),
                    focusedBorder : outlineInputBorder(),
                    enabledBorder : outlineInputBorder(),
                    hintText: 'Email',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
                    alignLabelWithHint: true,
                    hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Nunito')),
              ),
            ), const SizedBox(height: 20),

            // Password input field
            SizedBox(width: 300, height: 50,
              child: TextField(
                  controller: _signUpPasswordController, // Controls the text of the password field
                  obscureText: _obscureText1, // Controls the visibility of the password field
                  textAlign : TextAlign.center,
                  decoration : InputDecoration(
                      border : outlineInputBorder(),
                      focusedBorder : outlineInputBorder(),
                      enabledBorder : outlineInputBorder(),
                      hintText : 'Enter Password',
                      contentPadding : const EdgeInsets.symmetric(horizontal :50.0, vertical :10.0),
                      alignLabelWithHint : true,
                      hintStyle : const TextStyle(color : Colors.grey, fontFamily :'Nunito'),
                      suffixIcon :
                      IconButton(icon : Icon(_obscureText1 ?
                      Icons.visibility : Icons.visibility_off),
                          onPressed :
                          _togglePasswordVisibility1) // Toggles the visibility of the password field when pressed
                  )),
            ),
            const SizedBox(height :20),

            // Confirm password input field
            SizedBox(width :300, height :50,
              child : TextField(
                  controller :_signUpConfirmPasswordController, // Controls the text of the confirm password field
                  obscureText :_obscureText2, // Controls the visibility of the confirm password field
                  textAlign : TextAlign.center,
                  decoration : InputDecoration(
                      border : outlineInputBorder(),
                      focusedBorder : outlineInputBorder(),
                      enabledBorder : outlineInputBorder(),
                      hintText :'Confirm Password',
                      contentPadding :const EdgeInsets.symmetric(horizontal :70.0, vertical :10.0),
                      alignLabelWithHint:true,
                      hintStyle :const TextStyle(color :Colors.grey, fontFamily :'Nunito'),
                      suffixIcon :
                      IconButton(icon : Icon(_obscureText2 ?
                      Icons.visibility_off :
                      Icons.visibility),
                          onPressed :
                          _togglePasswordVisibility2) // Toggles the visibility of the confirm password field when pressed
                  )),
            ), const SizedBox(height :20),

            // Confirmation button
            ElevatedButton(onPressed :() async {
              // Check if any of the fields are empty
              if (_signUpEmailController.text.isEmpty || _signUpPasswordController.text.isEmpty || _signUpConfirmPasswordController.text.isEmpty) {
                // Show error message if either one or all fields are empty
                _showErrorMessage('Please fill in all the fields');
                return;
              }

              // Check if email is valid
              if (!_isEmailValid(_signUpEmailController.text)) {
                // Show error message if email is invalid
                _showErrorMessage('Please enter a valid email');
                return;
              }

              // Check if passwords match
              if (_signUpPasswordController.text != _signUpConfirmPasswordController.text) {
                // Show error message if passwords do not match
                _showErrorMessage('Passwords do not match');
                return;
              }

              // Check if password is strong enough
              if (!_isPasswordStrong(_signUpPasswordController.text)) {
                // Show error message if password is not strong enough
                _showErrorMessage('Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one number, and one special character');
                return;
              }

              // Navigate to the BusinessDetailsPage
              Navigator.push(context, MaterialPageRoute(builder :(context) =>const BusinessDetailsPage())); // Navigates to the BusinessDetailsPage when pressed

              // Send email with link to business details page
              //Perform your validation checks here...
              // If all checks pass, save the email and password to the database
             // ...
             // Send an email to the user with a link to the business details page
              // TODO:    final mailer = SendGridMailer('YOUR_SENDGRID_API_KEY');
              // TODO:   final email = Email(
              // TODO:     from: 'your_email@example.com',
              // TODO:     to: [_signUpEmailController.text],
              //  TODO:    subject: 'Business Details',
              // TODO:     htmlContent: '<p>Please click this link to go to the business details page: <a href="https://yourdomain.com/business-details">https://yourdomain.com/business-details</a></p>',
              // TODO:   );
              // TODO:   await mailer.send(email);
            },
                style :ElevatedButton.styleFrom(primary :const Color(0xFF003366),
                    shape :RoundedRectangleBorder(borderRadius :BorderRadius.circular(25))),
                child :const Text('Confirm', style :TextStyle(color :Colors.white))),
          ],
        ),
      ),
    );
  }
}


// The forgot password page widget
class ForgotPasswordPage extends StatelessWidget {
  // This controller will hold the value of the email input field
  final TextEditingController emailController = TextEditingController();
  ForgotPasswordPage({super.key});

  /// Displays an error message as a popup with red, almost transparent background at the top center of the window for 15 seconds
  void _showErrorMessage(BuildContext context, String message) {
    Flushbar(
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white.withOpacity(1.0),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.only(bottom: 100, left: 2, right: 2),
      maxWidth: 350,
      borderRadius: BorderRadius.circular(25),
      duration: const Duration(seconds: 10),
    ).show(context);
  }


// Displays a success message as a popup with green, almost transparent background at the top center of the window for 10 seconds
  void _showSuccessMessage(BuildContext context, String message) {
    Flushbar(
      messageText: Text(message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green.withOpacity(1.0),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.only(top: 80, left: 8, right: 8),
      maxWidth: 350,
      borderRadius: BorderRadius.circular(25),
      duration: const Duration(seconds: 10),
    ).show(context);
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
                // The controller is attached to the TextField. It will hold the current value of the TextField.
                controller: emailController,
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

                  // When the button is pressed, it retrieves the current value of the email input field.
              String email = emailController.text;


              // TODO action to send an email with a link to reset password.
              // TODO function sendEmail() should be implemented to send an email with a reset password link.
              // TODO sendEmail(email, 'Reset Password', 'Please click this link to reset your password: <URL>');
                // Check if email field is not empty
                if (emailController.text.isEmpty) {
                // Show error message if email field is empty
                _showErrorMessage(context, 'Please enter your email');
                return;
                }

                // TODO Check if email is valid and registered with us during sign up
                // TODO Check if email matches the one stored in our database

                // If email is valid and matches the one stored in our database
                // TODO Send reset password link to valid registered email
                // Show success message telling user to check their email for reset password link
                _showSuccessMessage(context, 'Please check your email for a link to reset your password');
                  // TODO Wait for user to click the link sent to their email before proceeding
                  // TODO Implement a mechanism to verify that the user has clicked the link sent to their email

                  // If user has clicked the link sent to their email
                  // Navigate to the ResetPasswordPage.
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPasswordPage()));
                },
              style:ElevatedButton.styleFrom(primary:const Color(0xFF003366),
                shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(25))),
                child:const Text('Submit', style:TextStyle(color:Colors.white))),
          ],
        ),
      ),
    );
  }
}



// Reset password page
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _resetPasswordController = TextEditingController();
  final _resetConfirmPasswordController = TextEditingController();
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  // Toggles the visibility of the new password field
  void _togglePasswordVisibility1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  // Toggles the visibility of the confirm new password field
  void _togglePasswordVisibility2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  // Displays an error message as a popup with red, almost transparent background at the top center of the window for 15 seconds
  void _showErrorMessage(String message) {
    Flushbar(
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white.withOpacity(1.0),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.only(bottom: 100, left: 2, right: 2),
      maxWidth: 350,
      borderRadius: BorderRadius.circular(25),
      duration: const Duration(seconds: 10),
    ).show(context);
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
            TextField(
                controller:_resetPasswordController,
                obscureText:_obscureText1,
                textAlign:
                TextAlign.center,
                decoration:
                InputDecoration(border :
                outlineInputBorder(),
                    focusedBorder : outlineInputBorder(),
                    enabledBorder : outlineInputBorder(),
                    hintText:'New Password',
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal:
                    50.0, vertical:
                    10.0),
                    alignLabelWithHint:true,
                    hintStyle:
                    const TextStyle(color:
                    Colors.grey, fontFamily:
                    'Nunito'),
                    suffixIcon:
                    IconButton(icon:
                    Icon(_obscureText1 ?
                    Icons.visibility :
                    Icons.visibility_off),
                        onPressed:_togglePasswordVisibility1)
                )),
            ),
            const SizedBox(height: 20),

            // Confirm password input field
            SizedBox(width: 300, height: 50,
              child:
              TextField(
                  controller:_resetConfirmPasswordController,
                  obscureText:_obscureText2,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border : outlineInputBorder(),
                      focusedBorder : outlineInputBorder(),
                      enabledBorder : outlineInputBorder(),
                      hintText:'Confirm Password',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 10.0),
                      alignLabelWithHint:true,
                      hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Nunito'),
                      suffixIcon:
                      IconButton(icon: Icon(_obscureText2 ?
                      Icons.visibility : Icons.visibility_off),
                          onPressed:_togglePasswordVisibility2)
                  )),
            ),  const SizedBox(height: 20),

            // Confirm button
            ElevatedButton(
              onPressed: () async {
                // When the button is pressed, it retrieves the current value of the new password and confirm new password input fields.
                String newPassword = _resetPasswordController.text;
                String confirmNewPassword = _resetConfirmPasswordController.text;
                // Check if the password fields are not empty
                if (_resetPasswordController.text.isEmpty || _resetConfirmPasswordController.text.isEmpty) {
                  // Show error message if either one or all fields are empty
                  _showErrorMessage('Please enter and confirm your new password');
                  return;
                }

                // It then checks if the new password and confirm new password are the same.
                if (newPassword != confirmNewPassword) {
                  // Show error message if new password and confirm new password do not match
                  _showErrorMessage('The passwords do not match');
                  return;
                }
                // Check if the password is strong enough
                String password = _resetPasswordController.text;
                bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
                bool hasDigits = password.contains(RegExp(r'[0-9]'));
                bool hasLowercase = password.contains(RegExp(r'[a-z]'));
                bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&£*(),.?":{}|<>]'));
                bool hasMinLength = password.length >= 8;

                if (!hasUppercase || !hasDigits || !hasLowercase || !hasSpecialCharacters || !hasMinLength) {
                  // Show error message if the password is not strong enough
                  _showErrorMessage('The password should be at least 8 characters long, contain uppercase and lowercase letters, digits, and special characters');
                  return;
                }

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

                // TODO action to update the user's password in the database.

                // Wait for 5 seconds to simulate updating user's password in database
                await Future.delayed(const Duration(seconds: 5));

                // Dismiss loading animation
                Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
              },
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF003366),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
              child: const Text('Confirm', style: TextStyle(color: Colors.white)),
            )

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
  // Controllers for each TextField
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _businessCategoryController = TextEditingController();
  String? _businessCategory;
  // Boolean to check if terms and conditions are accepted
  bool _termsAndConditionsAccepted = false;

  // Displays an error message as a popup with red, almost transparent background at the top center of the window for 15 seconds
  void _showErrorMessage(String message) {
    Flushbar(
      messageText: Text(message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white.withOpacity(1.0),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.only(bottom: 20, left: 2, right: 2),
      maxWidth: 350,
      borderRadius: BorderRadius.circular(25),
      duration: const Duration(seconds: 10),
    ).show(context);
  }
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
                      style: TextStyle( fontSize: 70, fontFamily: 'Nunito', color: Color(0xFF003366),
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: '.', style: TextStyle(color: Color(0xFF00a896))),
                        TextSpan(text: 'today', style: TextStyle(color: Color(0xFF003366))),
                      ],
                    ),
                  ),
                  const Positioned( top: 70, left: 65,
                    child: Text('swift. secure. seamless',
                        style: TextStyle( fontSize: 22, fontFamily: 'Nunito', color: Color(0xFF00a896),
                        )),
                  ),
                ],
              ), const SizedBox(height: 30),

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
                      contentPadding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
                      alignLabelWithHint: true,
                      hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Nunito')),
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
                      contentPadding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
                      alignLabelWithHint: true,
                      hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Nunito')))),
              const SizedBox(height: 20),

              // Location input field
                SizedBox(width: 300, height: 50,
                  child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                  controller: _locationController,
                  textAlign : TextAlign.center,
                  decoration: InputDecoration(
                    border: outlineInputBorder(),
                    focusedBorder: outlineInputBorder(),
                    enabledBorder: outlineInputBorder(),
                    hintText: 'Location',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
                    alignLabelWithHint: true,
                    hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Nunito'),
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  // Get place predictions from Google Maps API
                  final response = await http.get(
                    Uri.parse(
                      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$pattern'
                          '&key=AIzaSyCFpsDz1unugy3fOZPjIN1qjHrUB-jFnXE',
                    ),
                  );
                  final data = jsonDecode(response.body);
                  final predictions = data['predictions'] as List<dynamic>;
                  return predictions.map((prediction) => prediction['description'] as String).toList();
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  // Set the selected place's description as the text of the TextField
                  _locationController.text = suggestion;
                    },
                  ),
                ), const SizedBox(height: 20),

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
                      hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Nunito')),
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
                                // TextField for entering a custom category
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal:
                                  16.0),
                                  child:
                                  TextField(
                                    controller: _customCategoryController,
                                    decoration: const InputDecoration(
                                      hintText: 'Other',
                                    alignLabelWithHint: true,
                                    hintStyle: TextStyle(color: Color(0xFF003366), fontFamily: 'Nunito')
                                    ),
                                    style: const TextStyle(color: Color(0xFF003366), fontFamily: 'Nunito'), // Set text color to #003366
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // Add a space of 10px
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal:
                                  16.0),
                                  child:
                                  TextButton(onPressed:
                                      () {
                                    // Add the custom category to the list of selected categories
                                    if (_customCategoryController.text.isNotEmpty) {
                                      _selectedCategories.add(_customCategoryController.text);
                                    }
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
              ), const SizedBox(height: 30),

              // Terms and conditions checkbox and text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    value: _termsAndConditionsAccepted,
                    onChanged: (bool? newValue) {
                      setState(() {
                        // When the checkbox is tapped, its new value is saved to _termsAndConditionsAccepted.
                        _termsAndConditionsAccepted = newValue ?? false;
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () {

                      // Show terms and conditions dialog
                      // When the terms and conditions text is tapped, an AlertDialog showing the terms and conditions is displayed.
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
              ), const SizedBox(height: 20),

              // Get started button
              ElevatedButton(
                  onPressed: () async {
                    // Validate phone number
                    String phoneNumber = _phoneNumberController.text;
                    if (phoneNumber.isEmpty || phoneNumber.length != 10 || !phoneNumber.startsWith('07')) {
                      // Show error message if phone number is invalid
                      _showErrorMessage('Please enter a valid phone number');
                      return;
                    }
                    // Check if terms and conditions are accepted
                    if (!_termsAndConditionsAccepted) {
                      // Show error message if terms and conditions are not accepted
                      _showErrorMessage('Please accept the terms and conditions');
                      return;
                    }

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

                    // Perform validation and submission logic here
                    // If they are accepted, it navigates to the HomePage.
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                  },
                  style:ElevatedButton.styleFrom(primary:const Color(0xFF003366),
                      shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(25))),
                  child:const Text('Get Started', style:TextStyle(color:Colors.white))),

            ],
          ),
        ),
      ),
    );
  }
}


//home page widget
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: SafeArea(
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
                            const SizedBox(width: 20, height: 50,),

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
    );
  }
}

// Custom Text Form Field widget
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
  List<Map<String, dynamic>> _deliveries = [];

  @override
  void initState() {
    super.initState();
    _deliveries.addAll(widget.deliveries);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Stack(children: [
              Column(children: [
// Nav bar
                Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
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
                                child:
                                Icon(Icons.person, size: 60, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 300),

// Menu
                          Row(children: [
                            Padding(
                              padding:
                              const EdgeInsets.only(top: 20), // Add this line
                              child: Container(
                                width: 180,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(30),
                                    border:
                                    Border.all(color:
                                    const Color(0xFF003366),
                                        width:
                                        2)),
                                child:
                                DropdownButtonHideUnderline(child:
                                DropdownButton<String>(
                                  value:
                                  _filter,
                                  iconSize:
                                  30,
                                  iconEnabledColor:
                                  const Color(0xFF00a896),
                                  onChanged:
                                      (String? newValue) {
                                    setState(() {
                                      _filter = newValue!;
                                    });
                                  },
                                  items:
                                  <String>['All', 'Today', 'Last 7 days', 'Last month', 'Older']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                            value:value,child:
                                        Padding(padding:
                                        const EdgeInsets.only(left:
                                        20),child:
                                        Text(value)));
                                      }).toList(),),),),),
                            const SizedBox(width :10),

// Nav bar icon
                            IconButton(icon:
                            const Icon(Icons.menu,color :Color(0xFF003366),size :50),onPressed :
                                () {
                              setState(() =>_showPopup =!_showPopup);
                            },),

                          ])
                        ])),
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
                                : delivery['status'] =='En-Route' ?const Color(0xFF1B5E20)
                                : const Color(0xFF003366)))))),
                          ])
                        ]))));
                      }).toList()

                    ]))
                  ])
                ]))
                ),
              ]),
              // Menu popup
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
                      border:
                      Border.all(color: const Color(0xFF00a896), width: 2),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          const SizedBox(height: 20),
                          // Home button
                          ListTile(
                            leading:
                            const Icon(Icons.home, color:
                            Color(0xFF003366), size: 44),
                            title:
                            const Text('Home',
                                style:
                                TextStyle(fontSize:
                                20, fontFamily:'Nunito', fontWeight : FontWeight.bold, color:
                                Color(0xFF00a896))),
                            onTap : () {
                              // Navigate to the home page
                              Navigator.push(context, MaterialPageRoute(builder:
                                  (context) => const HomePage()));
                            },
                          ),const SizedBox(height: 40),

                          // Deliveries button
                          ListTile(
                            leading:
                            const Icon(Icons.motorcycle, color:
                            Color(0xFF003366), size: 44),
                            title:
                            const Text('Deliveries',
                                style:
                                TextStyle(fontSize:
                                20, fontFamily:'Nunito', fontWeight : FontWeight.bold, color:
                                Color(0xFF00a896))),
                            onTap : () { Navigator.push( context,
                                  MaterialPageRoute( builder: (context) => DeliveriesPage(deliveries: _deliveries)));
                            },
                          ),const SizedBox(height: 40),

                          // Log out button
                          ListTile(
                            leading:
                            const Icon(Icons.logout, color:
                            Color(0xFF003366), size: 44),
                            title:
                            const Text('Log Out',
                                style:
                                TextStyle(fontSize:
                                20, fontFamily:'Nunito', fontWeight : FontWeight.bold, color:
                                Color(0xFF00a896))),
                            onTap : () {

                              // Log out and navigate to the login page
                              Navigator.push(context, MaterialPageRoute(builder:
                                  (context) => const LoginPage()));
                            },
                          ),const SizedBox(height: 210),

// My account section
                          Padding(padding :const EdgeInsets.all(8.0),
                              child :Row(mainAxisAlignment :
                              MainAxisAlignment.spaceBetween,
                                  children:[
                                    ElevatedButton(onPressed : () {
                                      Navigator.push(context, MaterialPageRoute(builder:(context) => const AccountPage()));
                                    }, child :const Text('My Account',
                                        style :TextStyle(color :Colors.white)),
                                        style :ElevatedButton.styleFrom(primary :
                                        const Color(0xFF00a896),
                                            shape :
                                            RoundedRectangleBorder(borderRadius :
                                            BorderRadius.circular(25)))),
                                    const CircleAvatar(radius :20,
                                        backgroundColor :Colors.grey,
                                        // TODO:
                                        // Replace with the actual profile picture of the rider
                                        child :
                                        Icon(Icons.person, size :40,
                                            color :Colors.white))
                                  ])),
                        ]),
                  ),
                ),
            ])
        ));
  }
}

//my account page widget
class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController _locationController = TextEditingController();
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
                                            controller: _locationController,
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




