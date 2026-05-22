import 'package:flutter/material.dart';

/// Breakpoints and helpers for phone / tablet layouts.
abstract final class Responsive {
  static const tabletBreakpoint = 600.0;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletBreakpoint;

  static double horizontalPadding(BuildContext context) =>
      isTablet(context) ? 32.0 : 20.0;

  static double maxContentWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return isTablet(context) ? width.clamp(0, 720) : width;
  }

  static double featureCardHeight(BuildContext context) =>
      isTablet(context) ? 220.0 : 195.0;
}
