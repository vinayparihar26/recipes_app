import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResponsiveManager {
  static bool isMobile(BuildContext context) =>
      screenWidth(context) < 600;

  static bool isTablet(BuildContext context) =>
      screenWidth(context) >= 600 && screenWidth(context) < 1200;

  static bool isDesktop(BuildContext context) =>
      screenWidth(context) >= 1200;

  static bool isSkiaWeb(BuildContext context) =>
      kIsWeb && !isDesktop(context);

  // Screen dimensions
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  // Responsive sizing
  static double size(BuildContext context, double size) {
    final width = screenWidth(context);
    return size * (width < 400 ? 0.9 : width < 600 ? 1.0 : 1.2);
  }

  // Responsive padding
  static EdgeInsets padding(BuildContext context) =>
      EdgeInsets.all(isTablet(context) ? 16.0 : 12.0);
}
