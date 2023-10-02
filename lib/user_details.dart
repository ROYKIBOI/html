// user_details.dart
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'assets/splash_screen.dart'; // Import the splash screen
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

// Import the pages
import 'home.dart';
import 'user_session.dart';

// Function that returns an OutlineInputBorder with the desired properties
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: const BorderSide(color: Color(0xFF003366), width: 3),
  );
}



// THE USER SIGN UP AND LOGIN DETAIL CODES:
// 1.THE LOGIN PAGE
// 2.THE SIGNUP PAGE
// 3.FORGOT PASSWORD AND RESET PAGE
// 4.BUSINESS SIGN UP PAGE


// THE LOGIN WIDGET
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //final _formKey = GlobalKey<FormState>();
  final _logInEmailController = TextEditingController();
  final _logInPasswordController = TextEditingController();

  bool _obscureText = true; // for revealing the password


  bool _isLoading = false;

  // Toggles the visibility of the password
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //Error message
  void _showErrorMessage(String message) {
    Flushbar(
      messageText: Text(message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.transparent,
      barBlur: 0.0,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.only(bottom: 80, left: 2, right: 2),
      maxWidth: 350,
      borderRadius: BorderRadius.circular(25),
      duration: const Duration(seconds: 10),
    ).show(context);
  }
  // Displays a success message
  void _showSuccessMessage(String message) {
    Flushbar(
      messageText: Text(message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green.withOpacity(1.0),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.only(top: 70, left: 8, right: 8),
      maxWidth: 350,
      borderRadius: BorderRadius.circular(25),
      duration: const Duration(seconds: 10),
    ).show(context);
  }


  Future<void> attemptLogin() async {
    final email = _logInEmailController.text;
    final password = _logInPasswordController.text;

    final response = await http.post(
      Uri.parse('http://localhost:8000/login_view/'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {

      // set the user's email in the environment variables
      Provider.of<UserSession>(context, listen: false).setUserEmail(email);

      // Credentials are correct, navigate to the home page
      Navigator.pushReplacement( context, MaterialPageRoute( builder: (context) => const SplashScreen( nextPage: HomePage(),),),);

    } else {
      // Credentials are incorrect, show an error message
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      _showErrorMessage('Invalid email or password');
      _isLoading = false;
    }
  }


  @override
  Widget build(BuildContext context) {
    // Get screen size
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(  // This makes the page scrollable
        child: Center(
          child: Stack(
            children: <Widget>[

              // Logo
              Positioned(
                top: screenSize.height * 0.02,
                left: screenSize.width * 0.35,
                child: Image.asset('images/logo.png', width: screenSize.width * 0.3, height: screenSize.height * 0.5),
              ),

              // Container to move the following widgets up
              Container(
                margin: EdgeInsets.only(top: screenSize.height * 0.4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    // Email input field
                    SizedBox(width: 300, height: 50,
                      child: Center(
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
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Password input field
                    SizedBox(width: 300, height: 50,
                      child: Center( // This will center the TextField within the SizedBox
                        child: TextField(
                            controller: _logInPasswordController,
                            obscureText: _obscureText,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                border : outlineInputBorder(),
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
                      ),
                    ),
                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: _isLoading ? null : () async {
                        _showSuccessMessage('Loading, please wait.');


                        // Set _isLoading to true and rebuild the widget
                        setState(() {
                          _isLoading = true;
                        }); try {
                          // Check if email and password fields are not empty
                          if (_logInEmailController.text.isEmpty || _logInPasswordController.text.isEmpty) {
                            // Show error message if either one or all fields are empty
                            _showErrorMessage('Please enter your email and password');
                            return;
                          }


                          // Attempt login
                          await attemptLogin();

                          // Show a message informing the user to check their email
                        } catch (e) {


                        } finally{
                          // Set _isLoading back to false after the request is completed
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF003366),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                      child: const Text('Log In', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height : 30),


                    // Sign Up and Forgot Password buttons
                    Row(mainAxisAlignment : MainAxisAlignment.center, children:<Widget>[

                      // Forgot Password button - redirects to ForgotPasswordPage when pressed
                      TextButton(onPressed : () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => ForgotPasswordPage()));
                      },
                          child : const Text('Forgot Password?', style : TextStyle(fontFamily : 'Nunito', color : Color(0xFF003366), fontWeight : FontWeight.bold))),
                      const SizedBox(width : 50),

                      // Sign Up button - redirects to SignUpPage when pressed
                      TextButton(onPressed : () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) => const SignUpPage()));
                      },
                          child : const Text('Sign Up', style : TextStyle(fontFamily : 'Nunito', color : Color(0xFF003366), fontWeight : FontWeight.bold))),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




// THE SIGN UP WIDGET
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
  final FocusNode emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    emailFocusNode.addListener(() {
      if (emailFocusNode.hasFocus) {
        _showSuccessMessage('Please make sure that the email you enter is valid. It will be used to complete setting up your account and for communication purposes.');
      }
    });
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    super.dispose();
  }

  // Variables to control the visibility of the password fields
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool _isLoading = false;


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

  // Displays an error message as a popup
  void _showErrorMessage(String message) {
    Flushbar(
      messageText: Text(message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.transparent,
      barBlur: 0.0,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.only(bottom: 20, left: 2, right: 2),
      maxWidth: 350,
      borderRadius: BorderRadius.circular(25),
      duration: const Duration(seconds: 10),
    ).show(context);
  }


  // Displays a success message as a popup with green, almost transparent background at the top center of the window for 10 seconds
  void _showSuccessMessage(String message) {
    Flushbar(
      messageText: Text(message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green.withOpacity(1.0),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.only(top: 70, left: 8, right: 8),
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


  Future<void> _saveContact() async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/save_contact/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userEmail': _signUpEmailController.text,
        'userPassword': _signUpPasswordController.text,
      }),
    );
    if (response.statusCode == 200) {
      _signUpEmailController.clear();
      _signUpPasswordController.clear();

      // TO BE DELETED
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BusinessDetailsPage(),
        ),
      );
    } else {
      _showErrorMessage('Failed to save user: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // This makes the page scrollable
        child: Center(
          child: Stack(
            alignment: Alignment.center, // This will center the children
            children: <Widget>[
              // Logo
              Transform.translate(
                offset: const Offset(0, -100),
                child: Image.asset('images/logo.png',
                  width: screenSize.width * 0.3, // 50% of screen width
                  height: screenSize.height * 0.5, // 50% of screen height
                ),
              ),

              // Container to move the following widgets up
              Container(
                margin: EdgeInsets.only(top: screenSize.height * 0.4, left: screenSize.width * 0.0), // moves the widget up by 30% of screen height and left by 10% of screen width
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Email input field
                    SizedBox(width: 300, height: 50,
                      child: TextField(
                        controller: _signUpEmailController, // Controls the text of the email field
                        focusNode: emailFocusNode,
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
                    ), const SizedBox(height: 20),// Space is 2% of screen height


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
                                  onPressed : _togglePasswordVisibility1) // Toggles the visibility of the password field when pressed
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
                              contentPadding :const EdgeInsets.symmetric(horizontal :50.0, vertical :10.0),
                              alignLabelWithHint:true,
                              hintStyle :const TextStyle(color :Colors.grey, fontFamily :'Nunito'),
                              suffixIcon :
                              IconButton(icon : Icon(_obscureText2 ?
                              Icons.visibility_off :
                              Icons.visibility),
                                  onPressed : _togglePasswordVisibility2) // Toggles the visibility of the confirm password field when pressed
                          )),
                    ), const SizedBox(height :20),

                    // Confirmation button
                    ElevatedButton( onPressed: _isLoading ? null : () async {
                      // Set _isLoading to true and rebuild the widget
                      setState(() {
                        _isLoading = true;
                      }); try {
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
                          _showErrorMessage('Password must be 8 characters long, alphanumeric (0-9, a-z, A-Z) and special characters');
                          return;
                        }

                        // Save details in the database
                        await _saveContact();

                        // Show a message informing the user to check their email
                        _showSuccessMessage('Please check your email for the link to continue with the sign-up process.');
                      } catch (e) {


                      } finally{
                        // Set _isLoading back to false after the request is completed
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                        style :ElevatedButton.styleFrom(primary :const Color(0xFF003366),
                            shape :RoundedRectangleBorder(borderRadius :BorderRadius.circular(25))),
                        child: _isLoading ? const CircularProgressIndicator() :const Text('Confirm', style :TextStyle(color :Colors.white))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





// FORGOT PASSWORD WIDGET
class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  bool _isLoading = false;
  bool _isSubmitted = false;
  int _counter = 20;



  @override
  void initState() {
    super.initState();
    emailFocusNode.addListener(() {
      if (emailFocusNode.hasFocus) {
        setState(() {
          _isSubmitted = false;
          _counter = 20;
        });
      }
    });
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    super.dispose();
  }

  // Displays an error message as a popup
  void _showErrorMessage(BuildContext context, String message) {
    Flushbar(
      messageText: Text(message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.transparent,
      barBlur: 0.0,
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




  Future<void> attemptPassword(BuildContext context) async {
    final email = emailController.text;

    final response = await http.post(
      Uri.parse('http://localhost:8000/forgot_password/'),
      body: {'email': email},
    );

    if (response.statusCode == 200) {
      // Email exists in the database, navigate to the reset page
      // Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordPage()));

      // Email exists in the database, navigate to the reset page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPasswordPage(email: email),
        ),
      );

    } else {
      // Email does not exist in the database, show an error message
      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
      _showErrorMessage(context, 'Email not found. Please ensure you have signed up.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // This makes the page scrollable
        child: Center(
          child: Stack(
            alignment: Alignment.center, // This will center the children
            children: <Widget>[
              // Logo
              Transform.translate(
                offset: const Offset(0, -40),
                child: Image.asset('images/logo.png',
                  width: screenSize.width * 0.3, // 50% of screen width
                  height: screenSize.height * 0.5, // 50% of screen height
                ),
              ),

              // Container to move the following widgets up
              Container(
                margin: EdgeInsets.only(top: screenSize.height * 0.4, left: screenSize.width * 0.0), // moves the widget up by 30% of screen height and left by 10% of screen width
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    // Email input field
                    SizedBox(width: 300, height: 50,
                      child: TextField(
                        // The controller is attached to the TextField. It will hold the current value of the TextField.
                        controller: emailController,
                        focusNode: emailFocusNode,
                        enabled: !_isSubmitted || _counter == 0,
                        textAlign : TextAlign.center,
                        decoration: InputDecoration(
                            border : outlineInputBorder(),
                            focusedBorder : outlineInputBorder(),
                            enabledBorder : outlineInputBorder(),
                            hintText: _isSubmitted ? emailController.text : 'Enter Email',
                            contentPadding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
                            alignLabelWithHint: true,
                            hintStyle: const TextStyle(color: Colors.grey, fontFamily:'Nunito')),
                      ),
                    ), const SizedBox(height: 20),

                    // Submit button
                    ElevatedButton(
                        onPressed: _isLoading ? null : () async {
                          setState(() {
                            _isLoading = true;
                            _isSubmitted = true;
                          });

                          // Start the counter when the button is pressed
                          Timer.periodic(const Duration(seconds: 1), (timer) {
                            if (_counter > 0) {
                              setState(() {
                                _counter--;
                              });
                            } else {
                              timer.cancel();
                            }
                          });


                          // Call the password attempt
                          await attemptPassword(context);

                          setState(() {
                            _isLoading = false;
                          });
                        },
                        style:ElevatedButton.styleFrom(primary:const Color(0xFF003366),
                            shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(25))),
                        child: _isLoading ? const CircularProgressIndicator() : Text(_isSubmitted ? 'Resend' : 'Submit', style:const TextStyle(color:Colors.white))),
                    const SizedBox(height: 10),

                    if (_isSubmitted && _counter > 0)
                      Text('$_counter', style: const TextStyle(color: Color(0xFF00a896), fontFamily:'Nunito', fontSize: 16, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}




// RESET PASSWORD
class ResetPasswordPage extends StatefulWidget {
  final String email;

  ResetPasswordPage({Key? key, required this.email}) : super(key: key);

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

  // Displays an error message as a popup
  void _showErrorMessage(String message) {
    Flushbar(
      messageText: Text(message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.transparent,
      barBlur: 0.0,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.only(bottom: 80, left: 2, right: 2),
      maxWidth: 350,
      borderRadius: BorderRadius.circular(25),
      duration: const Duration(seconds: 10),
    ).show(context);
  }


  Future<void> resetPassword(BuildContext context, String email, String newPassword) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/reset_password/'), // Update the URL
      body: {
        'email': email,
        'new_password': newPassword,
      },
    );

    if (response.statusCode == 200) {
      // set the user's email in the environmental variables
      Provider.of<UserSession>(context, listen: false).setUserEmail(email);


      // Password reset successful, you can navigate to a success page or the home page
      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));


      // Password reset successful, you can navigate to splash screen
      Navigator.pushReplacement( context, MaterialPageRoute( builder: (context) => const SplashScreen( nextPage: HomePage(),),),);
    } else {
      // Password reset failed, show an error message
      _showErrorMessage('Password reset failed. Please try again.');
    }
  }





  @override
  Widget build(BuildContext context) {

    // Access the passed email
    final email = widget.email;

    // Get the screen size
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // This makes the page scrollable
        child: Center(
          child: Stack(
            alignment: Alignment.center, // This will center the children
            children: <Widget>[
              // Logo
              Transform.translate(
                offset: const Offset(0, -40),
                child: Image.asset('images/logo.png',
                  width: screenSize.width * 0.3, // 50% of screen width
                  height: screenSize.height * 0.5, // 50% of screen height
                ),
              ),

              // Container to move the following widgets up
              Container(
                margin: EdgeInsets.only(top: screenSize.height * 0.5, left: screenSize.width * 0.0), // moves the widget up by 30% of screen height and left by 10% of screen width
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    // New Password input field
                    SizedBox(width: 300, height: 50,
                      child: TextField(
                          controller:_resetPasswordController,
                          obscureText:_obscureText1,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(border :
                          outlineInputBorder(),
                              focusedBorder : outlineInputBorder(),
                              enabledBorder : outlineInputBorder(),
                              hintText:'New Password',
                              contentPadding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                              alignLabelWithHint:true,
                              hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Nunito'),
                              suffixIcon:
                              IconButton(icon: Icon(_obscureText1 ?
                              Icons.visibility : Icons.visibility_off),
                                  onPressed:_togglePasswordVisibility1)
                          )),
                    ), const SizedBox(height: 20),

                    // Confirm password input field
                    SizedBox(width: 300, height: 50,
                      child: TextField(
                          controller:_resetConfirmPasswordController,
                          obscureText:_obscureText2,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border : outlineInputBorder(),
                              focusedBorder : outlineInputBorder(),
                              enabledBorder : outlineInputBorder(),
                              hintText:'Confirm Password',
                              contentPadding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
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
                          _showErrorMessage('Password must be 8 characters long, alphanumeric (0-9, a-z, A-Z) and special characters');
                          return;
                        }

                        await resetPassword(context, email, newPassword);

                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF003366),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                      child: const Text('Confirm', style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





// SIGN UP BUSINESS DETAILS PAGE
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
  final TextEditingController _emailController = TextEditingController();
  String? _businessCategory;
  String _errorMessage = '';
  // Boolean to check if terms and conditions are accepted
  bool _termsAndConditionsAccepted = false;

  // Displays an error message as a popup
  void _showErrorMessage(String message) {
    Flushbar(
      messageText: Text(message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.transparent,
      barBlur: 0.0,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.only(bottom: 10, left: 2, right: 2),
      maxWidth: 350,
      borderRadius: BorderRadius.circular(25),
      duration: const Duration(seconds: 10),
    ).show(context);
  }

  // Validate email function
  bool isValidEmail(String email) {
    // Implement your email validation logic here
    // For simplicity, we assume any non-empty email is valid
    return email.isNotEmpty;
  }

  Future<http.Response> sendBusinessDetails() async {
    final body = jsonEncode({
      'businessName': _businessNameController.text,
      'phoneNumber': _phoneNumberController.text,
      'businessLocation': _businessLocationController.text,
      'businessCategory': _businessCategoryController.text,
      'email': _emailController.text,
    });

    return await http.post(
      Uri.parse('http://localhost:8000/business_signup/'), // Replace with your Django backend URL
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
  }



  @override
  Widget build(BuildContext context) {
    // Get the screen size
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // This makes the page scrollable
        child: Center(
          child: Stack(
            alignment: Alignment.center, // This will center the children
            children: <Widget>[
              // Logo
              Transform.translate(
                offset: const Offset(0, -200),
                child: Image.asset('images/logo.png',
                  width: screenSize.width * 0.3, // 50% of screen width
                  height: screenSize.height * 0.5, // 50% of screen height
                ),
              ),

              // Container to move the following widgets up
              Container(
                margin: EdgeInsets.only(top: screenSize.height * 0.3, left: screenSize.width * 0.0), // moves the widget up by 30% of screen height and left by 10% of screen width
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

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

                    // Email input field
                    SizedBox(width: 300, height: 50, child:
                    TextField(
                        controller: _emailController,
                        textAlign : TextAlign.center,
                        decoration: InputDecoration(
                            border : outlineInputBorder(),
                            focusedBorder : outlineInputBorder(),
                            enabledBorder : outlineInputBorder(),
                            hintText: 'Email',
                            contentPadding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
                            alignLabelWithHint: true,
                            hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Nunito')))),

                    const SizedBox(height: 20),



                    // Location input field
                    SizedBox(width: 300, height: 50, child:
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
                            hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Nunito')))),
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
                                      ...<String>['Jewellery', 'Cosmetics', 'Home Decor', 'Perfume', 'Clothes', 'Fashion Accessories',]
                                          .map<Widget>((value) {
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
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: TextField(
                                          controller: _customCategoryController,
                                          decoration: const InputDecoration(
                                              hintText: 'Other',
                                              alignLabelWithHint: true,
                                              hintStyle: TextStyle(color: Color(0xFF003366), fontFamily: 'Nunito')
                                          ),
                                          style: const TextStyle(color: Color(0xFF003366), fontFamily: 'Nunito'), // Set text color to #003366
                                        ),
                                      ), const SizedBox(height: 10),
                                      // Add a space of 10px
                                      Padding(
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 16.0),
                                        child: TextButton(onPressed:
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
                                            child: const Text('OK', style: TextStyle(fontSize: 14, fontFamily: 'Nunito', color: Color(0xFF003366), fontWeight : FontWeight.bold),
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
                    ), const SizedBox(height: 5),

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
                    ), const SizedBox(height: 10),

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

                          // Call the sendBusinessDetails function for saving
                          final response = await sendBusinessDetails();
                          if (response.statusCode == 200) {

                            // Save the email in the environment variable
                            final userSession = Provider.of<UserSession>(context, listen: false);
                            userSession.setUserEmail(_emailController.text);


                            // navigate to the next screen
                            Navigator.pushReplacement( context, MaterialPageRoute( builder: (context) => const SplashScreen( nextPage: HomePage(),),),);
                          } else if (response.statusCode == 400) {
                            // Handle validation error
                            setState(() {
                              // _errorMessage = 'Please enter correct data';
                              _showErrorMessage('Please share valid data');
                            });
                          } else if (response.statusCode == 500) {
                            // Handle server error
                            setState(() {
                              _errorMessage = 'Server error';
                            });
                          }

                          // Perform validation and submission logic here
                          // If they are accepted, it navigates to the HomePage.

                        },
                        style:ElevatedButton.styleFrom(primary:const Color(0xFF003366),
                            shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(25))),
                        child:const Text('Get Started', style:TextStyle(color:Colors.white))),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}