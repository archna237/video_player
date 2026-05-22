import 'package:flutter/material.dart';

class BrowserHistoryEntry {
  const BrowserHistoryEntry({
    required this.title,
    required this.url,
    this.faviconLetter = 'G',
    this.faviconColor = const Color(0xFF4285F4),
  });

  final String title;
  final String url;
  final String faviconLetter;
  final Color faviconColor;
}
