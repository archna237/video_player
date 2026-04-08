import 'package:flutter/material.dart';
import 'package:video_player/core/theme/app_colors.dart';
import 'package:video_player/features/shell/presentation/tabs/home_tab.dart';
import 'package:video_player/features/shell/presentation/tabs/explore_tab.dart';
import 'package:video_player/features/shell/presentation/tabs/library_tab.dart';
import 'package:video_player/features/shell/presentation/tabs/settings_tab.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  static const routeName = '/main';

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 3; // Setting initially to 3 since user is viewing settings screenshot

  final _pages = const [
    HomeTab(),
    ExploreTab(),
    LibraryTab(),
    SettingsTab(),
  ];

  Widget _buildNavItem(int index, IconData icon) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top glowing indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 4,
              width: 32,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.6),
                          blurRadius: 8,
                          spreadRadius: 1,
                        )
                      ]
                    : [],
              ),
            ),
            Icon(
              icon,
              color: isSelected
                  ? AppColors.primary
                  : Colors.white.withValues(alpha: 0.4),
              size: 26,
            ),
            const SizedBox(height: 16), // Bottom padding
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Let background render behind nav if needed
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF130626), // Dark purple/black matching the base image dark spot
        ),
        child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_filled),
              _buildNavItem(1, Icons.public),
              _buildNavItem(2, Icons.download_rounded),
              _buildNavItem(3, Icons.settings_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

