import 'package:flutter/material.dart';
import 'dart:async';
import 'package:client_app/home.dart';

class SplashScreen extends StatefulWidget {
  // final Widget nextPage;

  // const SplashScreen({required this.nextPage});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animationTuma;
  late Animation<Offset> _animationToday;
  late Animation<double> _animationDot;
  late Animation<double> _animationTagline;



  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    // Define the animations
    _animationTuma = Tween<Offset>(begin: const Offset(-2, 0.0), end: const Offset(-0.25, 0.0)).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _animationToday = Tween<Offset>(begin: const Offset(2, 0.0), end: const Offset(0.24, 0.0)).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _animationDot = Tween<double>(begin: -300.0, end: 0.0).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
    _animationTagline = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
      // Start the animation
    _controller.forward();
    // Navigate to the next page after a delay of 3 seconds
    Timer(const Duration(seconds: 3), () => Navigator.pushNamed(context, '/home'));  }


  @override
  void dispose() {
    // Dispose of the animation controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
    body: SingleChildScrollView( // Add this
    child: Center(
    child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            // Animate the app's name and tagline
            Stack(
              children:<Widget>[
                Transform.translate(
                  offset: const Offset(20,-30),
                  child: SlideTransition(
                    position:_animationTuma,
                    child: Image.asset('logo/tuma.png', width:600, height:600),
                  ),
                ),
                AnimatedBuilder(
                  animation:_animationDot,
                  builder:(BuildContext context, Widget? child) {
                    return Transform.translate(
                      offset: Offset(0.0,_animationDot.value),
                      child: Image.asset('logo/dot.png', width:600, height:600),
                    );
                  },
                ),
                Transform.translate(
                  offset: const Offset(0,-22),
                  child: SlideTransition(
                    position:_animationToday,
                    child: Image.asset('logo/today.png', width:600, height:600),
                  ),
                ),
              ],
            ),
            Transform.translate(
              offset: Offset(0.0, -470.0),
              child: FadeTransition(
                opacity:_animationTagline,
                child: Image.asset('logo/tagline.png', width:450, height:430),
              ),
            ),
          ],
    ),
    ),
    ),
    );
  }
}