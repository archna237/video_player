import 'package:flutter/material.dart';
import 'package:video_player/core/theme/app_colors.dart';

class AppGradientBackground extends StatelessWidget {
  const AppGradientBackground({super.key, required this.child});

  final Widget child;

  Widget _buildGlow({
    required Color color,
    required double size,
    double opacity = 1,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: opacity),
            color.withValues(alpha: 0.0),
          ],
        ),
      ),
    );
  }

//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Container(
//       color: const Color(0xFF13041F),
//       child: Stack(
//         children: [
//           // Top-right purple bloom
//           Positioned(
//             top: -size.width * 0.35,
//             right: -size.width * 0.38,
//             child: _buildGlow(
//               color: const Color(0xFF6E3BFF),
//               size: size.width * 1.65,
//               opacity: 0.82,
//             ),
//           ),
//
//           // Middle-left purple bloom (connects diagonal flow)
//           Positioned(
//             top: size.height * 0.28,
//             left: -size.width * 0.50,
//             child: _buildGlow(
//               color: const Color(0xFF4D2ED8),
//               size: size.width * 1.95,
//               opacity: 0.80,
//             ),
//           ),
//
//           // Bottom-right purple bloom
//           Positioned(
//             bottom: -size.width * 0.62,
//             right: -size.width * 0.35,
//             child: _buildGlow(
//               color: const Color(0xFF3B24B8),
//               size: size.width * 2.05,
//               opacity: 0.9,
//             ),
//           ),
//
//           // Connector haze so all three parts look connected.
//           Positioned(
//             top: size.height * 0.12,
//             left: -size.width * 0.15,
//             child: _buildGlow(
//               color: AppColors.backgroundMid,
//               size: size.width * 1.7,
//               opacity: 0.45,
//             ),
//           ),
//           Positioned(
//             bottom: size.height * 0.02,
//             left: size.width * 0.12,
//             child: _buildGlow(
//               color: AppColors.backgroundMid,
//               size: size.width * 1.8,
//               opacity: 0.4,
//             ),
//           ),
//
//           // Dark diagonal accents: top-right, middle-left, bottom-right.
//           Positioned(
//             top: size.height * 0.00,
//             right: -size.width * 0.10,
//             child: _buildGlow(
//               color: const Color(0xFF090610),
//               size: size.width * 1.30,
//               opacity: 0.55,
//             ),
//           ),
//           Positioned(
//             top: size.height * 0.32,
//             left: -size.width * 0.12,
//             child: _buildGlow(
//               color: const Color(0xFF07050E),
//               size: size.width * 1.15,
//               opacity: 0.58,
//             ),
//           ),
//           Positioned(
//             bottom: -size.height * 0.03,
//             right: -size.width * 0.02,
//             child: _buildGlow(
//               color: const Color(0xFF06040A),
//               size: size.width * 1.22,
//               opacity: 0.62,
//             ),
//           ),
//
//           // Soft edge vignette for contrast.
//           Positioned.fill(
//             child: DecoratedBox(
//               decoration: BoxDecoration(
//                 gradient: RadialGradient(
//                   center: const Alignment(0, -0.2),
//                   radius: 1.22,
//                   colors: [
//                     Colors.transparent,
//                     const Color(0x22000000),
//                     const Color(0x55000000),
//                   ],
//                   stops: const [0.55, 0.82, 1.0],
//                 ),
//               ),
//             ),
//           ),
//
//           child,
//         ],
//       ),
//     );
//   }
// }
//
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF5B3C8A),
            Color(0xFF2A0A4A),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [

          // TOP GLOW
          Positioned(
            top: -size.width * 0.3,
            right: -size.width * 0.3,
            child: _buildGlow(
              color: const Color(0xFF8B5CF6),
              size: size.width * 1.4,
              opacity: 0.30,
            ),
          ),

          // LEFT GLOW
          Positioned(
            top: size.height * 0.3,
            left: -size.width * 0.4,
            child: _buildGlow(
              color: const Color(0xFF6D4AFF),
              size: size.width * 1.6,
              opacity: 0.28,
            ),
          ),

          // BOTTOM GLOW
          Positioned(
            bottom: -size.width * 0.5,
            right: -size.width * 0.2,
            child: _buildGlow(
              color: const Color(0xFF4C2ED8),
              size: size.width * 1.7,
              opacity: 0.25,
            ),
          ),

          // ZIGZAG LAYER 1
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.black.withOpacity(0.25),
                      Colors.transparent,
                      Colors.black.withOpacity(0.18),
                      Colors.transparent,
                      Colors.black.withOpacity(0.22),
                    ],
                    stops: [0.0, 0.3, 0.5, 0.7, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // ZIGZAG LAYER 2
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.15),
                      Colors.transparent,
                      Colors.black.withOpacity(0.18),
                    ],
                    stops: [0.2, 0.45, 0.65, 0.9],
                  ),
                ),
              ),
            ),
          ),

          // VIGNETTE
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0, -0.2),
                    radius: 1.2,
                    colors: [
                      Colors.transparent,
                      Color(0x22000000),
                      Color(0x44000000),
                    ],
                    stops: [0.6, 0.85, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // YOUR UI
          child,
        ],
      ),
    );
  }
}