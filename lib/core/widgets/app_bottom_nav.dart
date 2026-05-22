import 'package:flutter/material.dart';
import 'package:video_player/core/theme/app_colors.dart';

class AppBottomNavItem {
  const AppBottomNavItem({required this.icon, required this.semanticLabel});

  final IconData icon;
  final String semanticLabel;
}

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onChanged,
    required this.items,
  });

  final int currentIndex;
  final ValueChanged<int> onChanged;
  final List<AppBottomNavItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.navBar),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final selected = currentIndex == index;
            return Semantics(
              label: item.semanticLabel,
              selected: selected,
              button: true,
              child: GestureDetector(
                onTap: () => onChanged(index),
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 60,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                        height: 4,
                        width: 32,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: selected ? AppColors.primary : Colors.transparent,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                          boxShadow: selected
                              ? [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(alpha: 0.6),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : [],
                        ),
                      ),
                      Icon(
                        item.icon,
                        color: selected
                            ? AppColors.primary
                            : Colors.white.withValues(alpha: 0.4),
                        size: 26,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
