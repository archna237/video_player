import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:video_player/features/pro/presentation/pro_screen.dart';

class LibraryTab extends StatefulWidget {
  const LibraryTab({super.key});

  @override
  State<LibraryTab> createState() => _LibraryTabState();
}

class _LibraryTabState extends State<LibraryTab> {
  int _selectedTab = 0; // 0: Processing, 1: Downloaded

  void _openPro() {
    Navigator.of(context).pushNamed(ProScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final isProcessing = _selectedTab == 0;
    final emptyMessage = isProcessing
        ? 'You have no videos downloading'
        : 'You have no downloaded videos';

    return SafeArea(
      child: Column(
        children: [
          // Top Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.insert_drive_file_rounded, color: Colors.white, size: 24),
                const Text(
                  'Downloaded',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: _openPro,
                  child: Ink(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF9A9E), Color(0xFFFECFEF)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.bolt, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          'PRO',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Tabs
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _LibraryToggleButton(
                    label: 'Processing',
                    selected: _selectedTab == 0,
                    onTap: () => setState(() => _selectedTab = 0),
                  ),
                ),
                Expanded(
                  child: _LibraryToggleButton(
                    label: 'Downloaded',
                    selected: _selectedTab == 1,
                    onTap: () => setState(() => _selectedTab = 1),
                  ),
                ),
              ],
            ),
          ),

          // Empty State
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const OpenBoxStarAnimation(size: 150),
                  const SizedBox(height: 20),
                  Text(
                    emptyMessage,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.92),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 60), // offset for bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LibraryToggleButton extends StatelessWidget {
  const _LibraryToggleButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? Colors.white.withValues(alpha: 0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(26),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: selected ? 1 : 0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class OpenBoxStarAnimation extends StatefulWidget {
  const OpenBoxStarAnimation({super.key, this.size = 140});

  final double size;

  @override
  State<OpenBoxStarAnimation> createState() => _OpenBoxStarAnimationState();
}

class _OpenBoxStarAnimationState extends State<OpenBoxStarAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.size;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = Curves.easeInOut.transform(_controller.value);
        final bob = math.sin(_controller.value * math.pi * 2) * 4;
        final pulse = 0.75 + (0.25 * t);

        return SizedBox(
          width: s,
          height: s,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: s * 0.06,
                child: CustomPaint(
                  size: Size(s * 0.62, s * 0.42),
                  painter: _OpenBoxPainter(
                    color: Colors.white.withValues(alpha: 0.95),
                    strokeWidth: 2.4,
                  ),
                ),
              ),
              Positioned(
                top: s * 0.08 + bob,
                child: Icon(
                  Icons.star_rounded,
                  size: s * 0.22,
                  color: const Color(0xFFFFE264),
                ),
              ),
              Positioned(
                top: s * 0.08 + bob,
                child: CustomPaint(
                  size: Size(s * 0.36, s * 0.18),
                  painter: _SparkPainter(
                    color: const Color(0xFFFFE264).withValues(alpha: pulse),
                    strokeWidth: 2.2,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OpenBoxPainter extends CustomPainter {
  const _OpenBoxPainter({
    required this.color,
    required this.strokeWidth,
  });

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // Bottom box body
    final body = Path()
      ..moveTo(w * 0.18, h * 0.56)
      ..lineTo(w * 0.50, h * 0.72)
      ..lineTo(w * 0.82, h * 0.56)
      ..lineTo(w * 0.82, h * 0.92)
      ..lineTo(w * 0.50, h * 1.00)
      ..lineTo(w * 0.18, h * 0.92)
      ..close();
    canvas.drawPath(body, paint);

    // Center fold
    canvas.drawLine(
      Offset(w * 0.50, h * 0.72),
      Offset(w * 0.50, h * 1.0),
      paint,
    );

    // Left lid flap
    final leftFlap = Path()
      ..moveTo(w * 0.50, h * 0.72)
      ..lineTo(w * 0.10, h * 0.47)
      ..lineTo(w * 0.38, h * 0.33)
      ..lineTo(w * 0.56, h * 0.50)
      ..close();
    canvas.drawPath(leftFlap, paint);

    // Right lid flap
    final rightFlap = Path()
      ..moveTo(w * 0.50, h * 0.72)
      ..lineTo(w * 0.90, h * 0.47)
      ..lineTo(w * 0.62, h * 0.33)
      ..lineTo(w * 0.44, h * 0.50)
      ..close();
    canvas.drawPath(rightFlap, paint);
  }

  @override
  bool shouldRepaint(covariant _OpenBoxPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}

class _SparkPainter extends CustomPainter {
  const _SparkPainter({
    required this.color,
    required this.strokeWidth,
  });

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final r1 = size.width * 0.22;
    final r2 = size.width * 0.34;

    // Left sparkle
    canvas.drawLine(Offset(cx - r2, cy), Offset(cx - r1, cy), paint);
    // Right sparkle
    canvas.drawLine(Offset(cx + r1, cy), Offset(cx + r2, cy), paint);
    // Top-left sparkle
    canvas.drawLine(
      Offset(cx - r1 * 0.8, cy - r1 * 0.95),
      Offset(cx - r2 * 0.9, cy - r2 * 1.0),
      paint,
    );
    // Top-right sparkle
    canvas.drawLine(
      Offset(cx + r1 * 0.8, cy - r1 * 0.95),
      Offset(cx + r2 * 0.9, cy - r2 * 1.0),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _SparkPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}

