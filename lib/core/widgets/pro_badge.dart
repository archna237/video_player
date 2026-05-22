import 'package:flutter/material.dart';
import 'package:video_player/core/theme/app_colors.dart';
import 'package:video_player/l10n/app_localizations.dart';

class ProBadge extends StatefulWidget {
  const ProBadge({
    super.key,
    required this.onTap,
    this.pulse = true,
    this.compact = false,
  });

  final VoidCallback onTap;
  final bool pulse;
  final bool compact;

  @override
  State<ProBadge> createState() => _ProBadgeState();
}

class _ProBadgeState extends State<ProBadge> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _scale;

  @override
  void initState() {
    super.initState();
    if (widget.pulse) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1600),
      )..repeat(reverse: true);
      _scale = Tween<double>(begin: 1.0, end: 1.04).animate(
        CurvedAnimation(parent: _controller!, curve: Curves.easeInOut),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final padding = widget.compact
        ? const EdgeInsets.symmetric(horizontal: 12, vertical: 7)
        : const EdgeInsets.symmetric(horizontal: 14, vertical: 8);
    final fontSize = widget.compact ? 12.5 : 13.0;
    final iconSize = widget.compact ? 16.0 : 17.0;

    final badge = GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.proGradientStart, AppColors.proGradientEnd],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.proGradientEnd.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bolt_rounded, color: Colors.white, size: iconSize),
            const SizedBox(width: 4),
            Text(
              l10n.proBadge,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: fontSize,
                letterSpacing: 0.7,
              ),
            ),
          ],
        ),
      ),
    );

    if (_scale == null) return badge;

    return AnimatedBuilder(
      animation: _scale!,
      builder: (_, child) => Transform.scale(scale: _scale!.value, child: child),
      child: badge,
    );
  }
}
