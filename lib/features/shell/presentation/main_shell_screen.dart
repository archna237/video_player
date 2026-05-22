import 'package:flutter/material.dart';
import 'package:video_player/core/widgets/app_bottom_nav.dart';
import 'package:video_player/features/shell/presentation/tabs/explore_tab.dart';
import 'package:video_player/features/shell/presentation/tabs/home_tab.dart';
import 'package:video_player/features/shell/presentation/tabs/library_tab.dart';
import 'package:video_player/features/shell/presentation/tabs/settings_tab.dart';
import 'package:video_player/l10n/app_localizations.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  static const routeName = '/main';

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;

  static const _pages = [
    HomeTab(),
    ExploreTab(),
    LibraryTab(),
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final navItems = [
      AppBottomNavItem(icon: Icons.home_filled, semanticLabel: l10n.tabHome),
      AppBottomNavItem(icon: Icons.public, semanticLabel: l10n.tabBrowser),
      AppBottomNavItem(
        icon: Icons.download_rounded,
        semanticLabel: l10n.tabDownloads,
      ),
      AppBottomNavItem(
        icon: Icons.settings_rounded,
        semanticLabel: l10n.tabSettings,
      ),
    ];

    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: KeyedSubtree(
          key: ValueKey<int>(_currentIndex),
          child: _pages[_currentIndex],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onChanged: (index) => setState(() => _currentIndex = index),
        items: navItems,
      ),
    );
  }
}
