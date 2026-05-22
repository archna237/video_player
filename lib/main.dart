import 'package:flutter/material.dart';
import 'package:video_player/app.dart';
import 'package:video_player/core/locale/locale_controller.dart';

final localeController = LocaleController();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await localeController.load();
  runApp(VideoPlayerApp(localeController: localeController));
}
