

import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  final Widget nextPage;

  const SplashScreen({required this.nextPage});

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
    _animationTuma = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _animationToday = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _animationDot = Tween<double>(begin: -50.0, end: 0.0).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
    _animationTagline = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    // Start the animation
    _controller.forward();
    // Navigate to the next page after a delay of 3 seconds
    Timer(const Duration(seconds: 3), () => Navigator.push(context, MaterialPageRoute(builder: (context) => widget.nextPage)));
  }

  @override
  void dispose() {
    // Dispose of the animation controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003366),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            // Animate the app's name and tagline
            Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children:<Widget>[
                SlideTransition(
                  position:_animationTuma,
                  child: RichText(
                    text: const TextSpan(text:'tuma',
                      style: TextStyle(fontSize: 100, fontFamily:'Nunito', color: Colors.white, fontWeight : FontWeight.bold),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation:_animationDot,
                  builder:(BuildContext context, Widget? child) {
                    return Transform.translate(
                      offset: Offset(0.0,_animationDot.value),
                      child: const Text('.',
                          style: TextStyle(fontSize: 100, fontFamily:'Nunito', color: Color(0xFF00a896), fontWeight : FontWeight.bold)),
                    );
                  },
                ),
                SlideTransition(
                  position:_animationToday,
                  child: RichText(text:
                    const TextSpan( text:'today',
                      style: TextStyle(fontSize: 100, fontFamily:'Nunito', color: Colors.white, fontWeight : FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),

            FadeTransition(
              opacity:_animationTagline,
              child: const Text('swift.secure.seamless',
                  style: TextStyle(fontSize: 24, fontFamily:'Nunito', color: Color(0xFF00a896))),
            ),
          ],
        ),
      ),
    );
  }
}

