import 'package:flutter/material.dart';

class DownloaderOrb extends StatelessWidget {
  const DownloaderOrb({super.key, this.size = 100});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.folder_rounded,
            size: size * 0.9,
            color: const Color(0xFF8B7BFF).withValues(alpha: 0.55),
          ),
          Positioned(
            bottom: size * 0.08,
            child: Container(
              width: size * 0.36,
              height: size * 0.36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF7B6FF0).withValues(alpha: 0.85),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7B6FF0).withValues(alpha: 0.5),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_downward_rounded,
                color: Colors.white,
                size: size * 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
