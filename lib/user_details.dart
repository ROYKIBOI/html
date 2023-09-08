// user_details.dart
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'assets/loading_animation.dart'; // Import the LoadingAnimation widget
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'assets/splash_screen.dart'; // Import the splash screen

// Import the pages
import 'home.dart';


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


                  // Check if email and password are correct and found in the database (this will be done in the backend)
                  // TODO : bool isValid = await checkCredentials(_logInEmailController.text, _logInPasswordController.text);
                  // TODO : if (isValid) {
                  // Redirect to home page if email and password are valid
                  Navigator.push( context, MaterialPageRoute( builder: (context) => SplashScreen( nextPage: const HomePage(),
                      ),
                    ),
                  );
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

              // When the button is pressed, it retrieves the current value of the email input field.
              //String email = emailController.text;


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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPasswordPage()));
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
            ), const SizedBox(height: 30),

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
                    IconButton(icon: Icon(_obscureText1 ?
                    Icons.visibility : Icons.visibility_off),
                        onPressed:_togglePasswordVisibility1)
                )),
            ), const SizedBox(height: 20),

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



                Navigator.push( context, MaterialPageRoute( builder: (context) => SplashScreen( nextPage: const HomePage(),
                      ),
                    ),
                  );
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
  final TextEditingController _businessLocationController = TextEditingController();
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
                    controller: _businessLocationController,
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
                    _businessLocationController.text = suggestion;
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

                    // Perform validation and submission logic here
                    // If they are accepted, it navigates to the HomePage.
                    Navigator.push( context, MaterialPageRoute( builder: (context) => SplashScreen( nextPage: const HomePage(),
                          ),
                        ),
                    );                  },
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