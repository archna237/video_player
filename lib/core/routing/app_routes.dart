import 'package:flutter/material.dart';
import 'package:video_player/features/browser/presentation/browser_screen.dart';
import 'package:video_player/features/downloads/domain/download_item.dart';
import 'package:video_player/features/pro/presentation/pro_screen.dart';
import 'package:video_player/features/settings/presentation/how_to_download_screen.dart';
import 'package:video_player/features/settings/presentation/info_screen.dart';
import 'package:video_player/features/shell/presentation/main_shell_screen.dart';
import 'package:video_player/features/splash/presentation/splash_screen.dart';
import 'package:video_player/features/videos/presentation/video_player_screen.dart';
import 'package:video_player/l10n/app_localizations.dart';

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
      case ProScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ProScreen(),
        );
      case BrowserScreen.routeName:
        final url = settings.arguments;
        if (url is String && url.isNotEmpty) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => BrowserScreen(initialUrl: url),
          );
        }
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const BrowserScreen(initialUrl: 'https://www.google.com'),
        );
      case HowToDownloadScreen.routeName:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HowToDownloadScreen(),
        );
      case InfoScreen.routeName:
        final args = settings.arguments;
        if (args is InfoScreenArgs) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => InfoScreen(
              title: args.title,
              body: args.body,
              bullets: args.bullets,
            ),
          );
        }
        return MaterialPageRoute(
          settings: settings,
          builder: (ctx) => InfoScreen(title: 'Info', body: ctx.l10n.disclaimerBody),
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
          builder: (ctx) => _PlayerMissingArgsScreen(l10n: ctx.l10n),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (ctx) => _UnknownRouteScreen(
            routeName: settings.name,
            l10n: ctx.l10n,
          ),
        );
    }
  }
}

class _PlayerMissingArgsScreen extends StatelessWidget {
  const _PlayerMissingArgsScreen({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(l10n.player),
      ),
      body: Center(
        child: Text(l10n.missingVideoArgs),
      ),
    );
  }
}

class _UnknownRouteScreen extends StatelessWidget {
  const _UnknownRouteScreen({required this.routeName, required this.l10n});

  final String? routeName;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(l10n.unknownRoute(routeName)),
      ),
    );
  }
}
