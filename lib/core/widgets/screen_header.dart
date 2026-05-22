import 'package:flutter/material.dart';
import 'package:video_player/core/widgets/pro_badge.dart';

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    super.key,
    required this.title,
    this.leading,
    this.onProTap,
    this.titleStyle,
  });

  final String title;
  final Widget? leading;
  final VoidCallback? onProTap;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (leading != null) leading!,
        Expanded(
          child: Text(
            title,
            style: titleStyle ??
                const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  letterSpacing: 0.2,
                ),
          ),
        ),
        if (onProTap != null) ProBadge(onTap: onProTap!, pulse: true),
      ],
    );
  }
}
