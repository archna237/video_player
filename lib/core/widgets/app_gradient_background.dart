import 'package:flutter/material.dart';
import 'package:video_player/core/theme/app_colors.dart';

class AppGradientBackground extends StatelessWidget {
  const AppGradientBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // 0xFF120322 is a deep, little black/purple base color
    final size = MediaQuery.of(context).size;

    return Container(
      color: const Color(0xFF120322), 
      child: Stack(
        children: [
          // 1. Dark purple/black color starting from RIGHT side (Top Right)
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: size.width * 1.2,
              height: size.width * 1.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.backgroundBottom, // very dark #220b43
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          
          // 2. Then goes LEFT (Lighter purple blobs blooming from the left side)
          Positioned(
            top: size.height * 0.25,
            left: -150,
            child: Container(
              width: size.width * 1.3,
              height: size.width * 1.3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.backgroundTop.withValues(alpha: 0.6), // bright #6446a6
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // 3. Middle purple binding them together 
          Positioned(
            top: size.height * 0.1,
            left: 0,
            right: 0,
            child: Container(
              height: size.width * 1.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.backgroundMid.withValues(alpha: 0.5), // mid #4c2e86
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // 4. Then goes RIGHT again (Dark purple returning at the bottom right)
          Positioned(
            bottom: -50,
            right: -100,
            child: Container(
              width: size.width * 1.2,
              height: size.width * 1.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.backgroundBottom.withValues(alpha: 0.8), // dark #220b43 again
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // App Content
          child,
        ],
      ),
    );
  }
}

