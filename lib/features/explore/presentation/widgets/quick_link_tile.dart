import 'package:flutter/material.dart';
import 'package:video_player/features/explore/domain/browser_shortcut.dart';

class QuickLinkTile extends StatelessWidget {
  const QuickLinkTile({
    super.key,
    required this.shortcut,
    required this.onTap,
  });

  final BrowserShortcut shortcut;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.08),
                ),
                boxShadow: [
                  if (shortcut.brandColor != null)
                    BoxShadow(
                      color: shortcut.brandColor!.withValues(alpha: 0.12),
                      blurRadius: 12,
                    ),
                ],
              ),
              child: Center(child: _icon()),
            ),
            const SizedBox(height: 8),
            Text(
              shortcut.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _icon() {
    if (shortcut.customIcon != null) return shortcut.customIcon!;
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: shortcut.brandColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(shortcut.icon, color: Colors.white, size: 20),
    );
  }
}
