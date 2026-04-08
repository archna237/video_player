import 'package:flutter/material.dart';
import 'package:video_player/core/routing/app_routes.dart';
import 'package:video_player/core/theme/app_theme.dart';
import 'package:video_player/core/widgets/app_gradient_background.dart';

class VideoPlayerApp extends StatelessWidget {
  const VideoPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      builder: (context, child) {
        return AppGradientBackground(
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}

