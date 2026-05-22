import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:video_player/core/locale/locale_controller.dart';
import 'package:video_player/core/routing/app_routes.dart';
import 'package:video_player/core/theme/app_theme.dart';
import 'package:video_player/core/widgets/app_gradient_background.dart';
import 'package:video_player/l10n/app_localizations.dart';

class VideoPlayerApp extends StatelessWidget {
  const VideoPlayerApp({super.key, required this.localeController});

  final LocaleController localeController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: localeController,
      builder: (context, _) {
        final l10n = AppLocalizations(localeController.locale);
        return MaterialApp(
          title: l10n.appName,
          debugShowCheckedModeBanner: false,
          locale: localeController.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: AppTheme.dark(),
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          builder: (context, child) {
            return AppGradientBackground(
              child: child ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}
