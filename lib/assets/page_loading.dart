import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  _LoadingAnimationState createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
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
    return Container(
      width: 50, height: 50,
      child: CustomPaint(
        painter: DotsPainter(
          progress: _animation.value,
          color: const Color(0xFF00a896),
        ),
      ),
    );
  }
}

class DotsPainter extends CustomPainter {
  final double progress;
  final Color color;

  DotsPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    final double radius = math.min(size.width, size.height) / 2;
    final double dotRadius = radius / 5;
    const double angle = (2 * math.pi) / 10;

    for (int i = 0; i < 10; i++) {
      final double x = size.width / 2 + radius * math.cos(angle * i - math.pi / 2 + (2 * math.pi) * progress);
      final double y = size.height / 2 + radius * math.sin(angle * i - math.pi / 2 + (2 * math.pi) * progress);
      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}