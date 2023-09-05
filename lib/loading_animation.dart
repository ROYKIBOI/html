import 'package:flutter/material.dart';
import 'dart:math';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // App title
          RichText(
            text: const TextSpan(
              text: 'tuma',
              style: TextStyle(fontSize: 24, fontFamily: 'Nunito', color: Color(0xFF00a896)),
              children: <TextSpan>[
                TextSpan(text: '.', style: TextStyle(color: Color(0xFF003366))),
                TextSpan(text: 'today', style: TextStyle(color: Color(0xFF00a896))),
              ],
            ),
          ),
          // Loading dots
          SizedBox(
            width: 100,
            height: 100,
            child: CustomPaint(
              painter: _LoadingDotsPainter(_animation.value),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingDotsPainter extends CustomPainter {
  final double progress;

  _LoadingDotsPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00a896)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    for (int i = 0; i < 3; i++) {
      final angle = (progress + i / 3) * (2 * pi);
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      canvas.drawCircle(Offset(x, y), 4, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
