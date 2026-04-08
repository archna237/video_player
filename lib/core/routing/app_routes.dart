import 'package:flutter/material.dart';
import 'package:video_player/features/downloads/domain/download_item.dart';
import 'package:video_player/features/shell/presentation/main_shell_screen.dart';
import 'package:video_player/features/splash/presentation/splash_screen.dart';
import 'package:video_player/features/videos/presentation/video_player_screen.dart';

abstract final class AppRoutes {
  static const splash = '/';
  static const main = MainShellScreen.routeName;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SplashScreen(),
        );
      case main:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const MainShellScreen(),
        );
      case VideoPlayerScreen.routeName:
        final args = settings.arguments;
        if (args is DownloadItem) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => VideoPlayerScreen(item: args),
          );
        }
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const _PlayerMissingArgsScreen(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => _UnknownRouteScreen(routeName: settings.name),
        );
    }
  }
}

class _PlayerMissingArgsScreen extends StatelessWidget {
  const _PlayerMissingArgsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Player'),
      ),
      body: const Center(
        child: Text('Missing video arguments for player screen.'),
      ),
    );
  }
}

class _UnknownRouteScreen extends StatelessWidget {
  const _UnknownRouteScreen({required this.routeName});

  final String? routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Unknown route: ${routeName ?? 'null'}'),
      ),
    );
  }
}

