import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/core/theme/app_colors.dart';
import 'package:video_player/features/pro/presentation/pro_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late final AnimationController _proPulse;
  late final Animation<double> _proScale;

  @override
  void initState() {
    super.initState();
    _proPulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
    _proScale = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _proPulse, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _proPulse.dispose();
    super.dispose();
  }

  Future<void> _openPhotoLibrary() async {
    final picker = ImagePicker();
    final file = await picker.pickVideo(source: ImageSource.gallery);
    if (!mounted) return;
    if (file == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Selected: ${file.name}')),
    );
  }

  Future<void> _openGoogle() async {
    const uri = 'https://www.google.com';
    final ok = await launchUrl(Uri.parse(uri), mode: LaunchMode.externalApplication);
    if (!mounted) return;
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open downloader.')),
      );
    }
  }

  Future<void> _pasteLink() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (!mounted) return;
    final text = data?.text ?? '';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text.isEmpty ? 'Clipboard is empty' : 'Link: $text')),
    );
  }

  void _openPro() => Navigator.of(context).pushNamed(ProScreen.routeName);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top Bar ──────────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // "Video Player" italic title
                const Text(
                  'Video Player',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),

                // ⚡ PRO badge — orange→pink gradient
                AnimatedBuilder(
                  animation: _proScale,
                  builder: (_, child) =>
                      Transform.scale(scale: _proScale.value, child: child),
                  child: GestureDetector(
                    onTap: _openPro,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFF8C00), // orange
                            Color(0xFFFF4DA6), // hot pink
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF4DA6).withValues(alpha: 0.45),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.bolt_rounded, color: Colors.white, size: 17),
                          SizedBox(width: 4),
                          Text(
                            'PRO',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 13,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // ── Paste Link Pill ───────────────────────────────────────────
            GestureDetector(
              onTap: _pasteLink,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.link_rounded,
                      color: Colors.grey.shade500,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Paste link video to watc...',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    // Purple clipboard icon button
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.content_paste_rounded,
                        color: AppColors.primary,
                        size: 19,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ── Two Feature Cards ────────────────────────────────────────
            SizedBox(
              height: 195,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // LEFT — Video Player Card
                  Expanded(
                    child: _FeatureCard(
                      onTap: _openPhotoLibrary,
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF7B3FDE), // bright purple
                          Color(0xFF4A2ECC), // deep indigo-purple
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      title: 'Video Player',
                      subtitle: '(mp4, mov..)',
                      child: _VideoPlayerOrb(),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // RIGHT — Video Downloader Card
                  Expanded(
                    child: _FeatureCard(
                      onTap: _openGoogle,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF1E1040).withValues(alpha: 0.95),
                          const Color(0xFF120A2A).withValues(alpha: 0.95),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                        width: 1.2,
                      ),
                      title: 'Video',
                      subtitle: 'Downloader',
                      child: const _DownloaderIcon(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Reusable Feature Card ──────────────────────────────────────────────────────

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.onTap,
    required this.gradient,
    required this.title,
    required this.subtitle,
    required this.child,
    this.border,
  });

  final VoidCallback onTap;
  final LinearGradient gradient;
  final String title;
  final String subtitle;
  final Widget child;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(22),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        splashColor: Colors.white.withValues(alpha: 0.08),
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(22),
            border: border,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.78),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                ),
                const Spacer(),
                Center(child: child),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── 3-D Video Orb Icon (left card) ────────────────────────────────────────────

class _VideoPlayerOrb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 110,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer glow ring
          Container(
            width: 108,
            height: 108,
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
          // Pink-orange orbit ellipse (horizontal)
          Transform(
            transform: Matrix4.identity()
              ..rotateX(1.1)
              ..rotateZ(0.15),
            alignment: Alignment.center,
            child: Container(
              width: 92,
              height: 26,
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
          // Main sphere
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF9B72FF),
                  Color(0xFF5B3BCC),
                ],
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
            child: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 34,
            ),
          ),
          // Sparkle dots
          Positioned(
            top: 8,
            right: 14,
            child: _Sparkle(size: 6, color: Colors.white.withValues(alpha: 0.9)),
          ),
          Positioned(
            bottom: 12,
            left: 10,
            child: _Sparkle(size: 4, color: Colors.white.withValues(alpha: 0.6)),
          ),
        ],
      ),
    );
  }
}

class _Sparkle extends StatelessWidget {
  const _Sparkle({required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

// ── Folder-Download Icon (right card) ─────────────────────────────────────────

class _DownloaderIcon extends StatelessWidget {
  const _DownloaderIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // folder body
          Icon(
            Icons.folder_rounded,
            size: 90,
            color: const Color(0xFF8B7BFF).withValues(alpha: 0.55),
          ),
          // download arrow overlay
          Positioned(
            bottom: 8,
            child: Container(
              width: 36,
              height: 36,
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
              child: const Icon(
                Icons.arrow_downward_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
