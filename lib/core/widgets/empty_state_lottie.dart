import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyStateLottie extends StatelessWidget {
  const EmptyStateLottie({
    super.key,
    required this.asset,
    this.size = 150,
    this.message,
  });

  final String asset;
  final double size;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(
          asset,
          width: size,
          height: size,
          fit: BoxFit.contain,
          repeat: true,
        ),
        if (message != null) ...[
          const SizedBox(height: 20),
          Text(
            message!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}
