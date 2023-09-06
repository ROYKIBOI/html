// responsive_design.dart
import 'package:flutter/material.dart';

class ResponsiveDesign extends StatelessWidget {
  final Widget child;

  const ResponsiveDesign({required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            // Use the constraints and orientation to determine the screen size and aspect ratio
            double deviceWidth = constraints.maxWidth;
            double deviceHeight = constraints.maxHeight;
            double aspectRatio = deviceWidth / deviceHeight;
            // Set a base height to scale the text and other elements of the app
            double baseHeight = 650.0;
            // Adjust the base height for different aspect ratios
            if (aspectRatio > 0.8) {
              baseHeight = 600.0;
            }
            // Set the text scale factor based on the screen size and base height
            double textScaleFactor = deviceHeight / baseHeight;
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: textScaleFactor),
              child: child,
            );
          },
        );
      },
    );
  }
}
