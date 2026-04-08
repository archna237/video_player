import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/core/theme/app_colors.dart';
import 'package:video_player/features/pro/presentation/pro_screen.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  // ── Quick-link shortcuts ──────────────────────────────────────────────
  static const _shortcuts = <_ShortcutData>[
    _ShortcutData('Fb', Icons.facebook_rounded, Color(0xFF1877F2), 'https://www.facebook.com'),
    _ShortcutData('Ins', Icons.camera_alt_rounded, Color(0xFFE4405F), 'https://www.instagram.com'),
    _ShortcutData('Tic', Icons.music_note_rounded, Color(0xFF010101), 'https://www.tiktok.com'),
    _ShortcutData('Thrs', Icons.tag_rounded, Color(0xFF000000), 'https://www.threads.net'),
    _ShortcutData('Tw', Icons.close, Color(0xFF000000), 'https://www.x.com'),        // X logo
    _ShortcutData('Daimo', Icons.play_circle_filled_rounded, Color(0xFF0066DC), 'https://www.dailymotion.com'),
    _ShortcutData('Vmeo', Icons.play_circle_outline_rounded, Color(0xFF1AB7EA), 'https://www.vimeo.com'),
  ];

  // ── History entries ───────────────────────────────────────────────────
  final List<_HistoryEntry> _history = [
    _HistoryEntry('Google', 'https://www.google.com/'),
    _HistoryEntry('Google', 'https://www.google.com/'),
    _HistoryEntry('Google', 'https://www.google.com/'),
  ];

  // ── Actions ───────────────────────────────────────────────────────────
  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!mounted) return;
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open $url')),
      );
    }
  }

  void _onSearchTap() {
    // Open Google as a fallback search
    _openUrl('https://www.google.com');
  }

  void _clearAllHistory() {
    setState(() => _history.clear());
  }

  void _removeHistoryAt(int index) {
    setState(() => _history.removeAt(index));
  }

  void _openPro() => Navigator.of(context).pushNamed(ProScreen.routeName);

  // ── Build ─────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 12),

          // ── Search bar + PRO badge ──────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Search pill
                Expanded(
                  child: GestureDetector(
                    onTap: _onSearchTap,
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search_rounded,
                              color: Colors.white.withValues(alpha: 0.5), size: 22),
                          const SizedBox(width: 10),
                          Text(
                            'Search or type URL',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.45),
                              fontSize: 14.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // PRO badge
                GestureDetector(
                  onTap: _openPro,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF8C00), Color(0xFFFF4DA6)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF4DA6).withValues(alpha: 0.35),
                          blurRadius: 12,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.bolt_rounded, color: Colors.white, size: 16),
                        SizedBox(width: 3),
                        Text(
                          'PRO',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 12.5,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Quick-link grid ─────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              spacing: 18,
              runSpacing: 18,
              children: _shortcuts.map((s) {
                return _QuickLinkTile(
                  data: s,
                  onTap: () => _openUrl(s.url),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 28),

          // ── History header ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'History',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (_history.isNotEmpty)
                  GestureDetector(
                    onTap: _clearAllHistory,
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        color: AppColors.primary.withValues(alpha: 0.85),
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ── History list ────────────────────────────────────────────
          Expanded(
            child: _history.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.history_rounded,
                            color: Colors.white.withValues(alpha: 0.15), size: 56),
                        const SizedBox(height: 12),
                        Text(
                          'No browsing history',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.35),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _history.length,
                    separatorBuilder: (_, _a) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final entry = _history[index];
                      return _HistoryTile(
                        entry: entry,
                        onTap: () => _openUrl(entry.url),
                        onDelete: () => _removeHistoryAt(index),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Data classes ────────────────────────────────────────────────────────────────

class _ShortcutData {
  const _ShortcutData(this.label, this.icon, this.brandColor, this.url);
  final String label;
  final IconData icon;
  final Color brandColor;
  final String url;
}

class _HistoryEntry {
  const _HistoryEntry(this.title, this.url);
  final String title;
  final String url;
}

// ── Quick-link tile ─────────────────────────────────────────────────────────────

class _QuickLinkTile extends StatelessWidget {
  const _QuickLinkTile({required this.data, required this.onTap});

  final _ShortcutData data;
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
            // Icon container — glassmorphic dark card
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
                  BoxShadow(
                    color: data.brandColor.withValues(alpha: 0.12),
                    blurRadius: 12,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: _buildShortcutIcon(data),
              ),
            ),
            const SizedBox(height: 8),
            // Label
            Text(
              data.label,
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

  Widget _buildShortcutIcon(_ShortcutData s) {
    // For "Tw" (X/Twitter) use a bold "X" text instead of the close icon
    if (s.label == 'Tw') {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            '𝕏',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.black,
              height: 1.1,
            ),
          ),
        ),
      );
    }

    // For "Thrs" (Threads) use @ symbol
    if (s.label == 'Thrs') {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            '@',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black,
              height: 1.2,
            ),
          ),
        ),
      );
    }

    // For "Daimo" use a 'd' character in brand style
    if (s.label == 'Daimo') {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [s.brandColor, s.brandColor.withValues(alpha: 0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            'd',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              height: 1.1,
            ),
          ),
        ),
      );
    }

    // For "Vmeo" use a 'V' character
    if (s.label == 'Vmeo') {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [s.brandColor, s.brandColor.withValues(alpha: 0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            'V',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.1,
            ),
          ),
        ),
      );
    }

    // For "Ins" (Instagram) use gradient background
    if (s.label == 'Ins') {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF833AB4), // purple
              Color(0xFFE4405F), // pink
              Color(0xFFF77737), // orange
              Color(0xFFFCAF45), // yellow
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 18),
      );
    }

    // For "Tic" (TikTok) use the music note
    if (s.label == 'Tic') {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.music_note_rounded, color: Colors.white, size: 18),
      );
    }

    // Default: Fb
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: s.brandColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(s.icon, color: Colors.white, size: 20),
    );
  }
}

// ── History tile ────────────────────────────────────────────────────────────────

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({
    required this.entry,
    required this.onTap,
    required this.onDelete,
  });

  final _HistoryEntry entry;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.06),
            ),
          ),
          child: Row(
            children: [
              // Favicon / brand circle
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'G',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: _googleColor(entry.title),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              // Title + URL
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      entry.url,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.40),
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Delete button
              GestureDetector(
                onTap: onDelete,
                child: Icon(
                  Icons.close_rounded,
                  color: Colors.white.withValues(alpha: 0.35),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _googleColor(String title) {
    // Multi-colored G to mimic the Google logo
    return const Color(0xFF4285F4); // Google blue
  }
}
