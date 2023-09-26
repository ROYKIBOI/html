// responsive_ui.dart
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget child;

  const Responsive({
    Key? key,
    required this.child,
  }) : super(key: key);

  /// mobile < 650
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  /// tablet >= 650
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
          MediaQuery.of(context).size.width < 1100;

  ///desktop >= 1100
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 1100) {
        return const SingleChildScrollView();
      } else if (constraints.maxWidth >= 650) {
        return const SingleChildScrollView();
      } else {
        return const SingleChildScrollView();
      }
    });
  }
}
