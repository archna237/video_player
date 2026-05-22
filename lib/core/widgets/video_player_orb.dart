import 'package:flutter/material.dart';

class VideoPlayerOrb extends StatelessWidget {
  const VideoPlayerOrb({super.key, this.size = 110});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size * 0.98,
            height: size * 0.98,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFFFF5CA8).withValues(alpha: 0.25),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Transform(
            transform: Matrix4.identity()
              ..rotateX(1.1)
              ..rotateZ(0.15),
            alignment: Alignment.center,
            child: Container(
              width: size * 0.84,
              height: size * 0.24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6AB0), Color(0xFFFFB347)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF6AB0).withValues(alpha: 0.5),
                    blurRadius: 14,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: size * 0.58,
            height: size * 0.58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF9B72FF), Color(0xFF5B3BCC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF7B55FF).withValues(alpha: 0.6),
                  blurRadius: 18,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: size * 0.31,
            ),
          ),
          Positioned(
            top: size * 0.07,
            right: size * 0.13,
            child: _Sparkle(size: size * 0.055),
          ),
          Positioned(
            bottom: size * 0.11,
            left: size * 0.09,
            child: _Sparkle(size: size * 0.036, opacity: 0.6),
          ),
        ],
      ),
    );
  }
}

class _Sparkle extends StatelessWidget {
  const _Sparkle({required this.size, this.opacity = 0.9});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: opacity),
      ),
    );
  }
}
