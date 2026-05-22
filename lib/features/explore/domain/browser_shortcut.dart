import 'package:flutter/material.dart';

class BrowserShortcut {
  const BrowserShortcut({
    required this.label,
    required this.url,
    this.icon,
    this.brandColor,
    this.customIcon,
  });

  final String label;
  final String url;
  final IconData? icon;
  final Color? brandColor;
  final Widget? customIcon;
}
