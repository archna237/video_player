import 'package:flutter/material.dart';
import 'package:video_player/features/explore/domain/browser_shortcut.dart';

abstract final class BrowserShortcuts {
  static const all = <BrowserShortcut>[
    BrowserShortcut(
      label: 'Fb',
      url: 'https://www.facebook.com',
      icon: Icons.facebook_rounded,
      brandColor: Color(0xFF1877F2),
    ),
    BrowserShortcut(
      label: 'Ins',
      url: 'https://www.instagram.com',
      customIcon: _InstagramIcon(),
    ),
    BrowserShortcut(
      label: 'Tic',
      url: 'https://www.tiktok.com',
      customIcon: _TikTokIcon(),
    ),
    BrowserShortcut(
      label: 'Thrs',
      url: 'https://www.threads.net',
      customIcon: _ThreadsIcon(),
    ),
    BrowserShortcut(
      label: 'Tw',
      url: 'https://www.x.com',
      customIcon: _XIcon(),
    ),
    BrowserShortcut(
      label: 'Daimo',
      url: 'https://www.dailymotion.com',
      customIcon: _DailymotionIcon(),
    ),
    BrowserShortcut(
      label: 'Vmeo',
      url: 'https://www.vimeo.com',
      customIcon: _VimeoIcon(),
    ),
  ];
}

class _InstagramIcon extends StatelessWidget {
  const _InstagramIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF833AB4),
            Color(0xFFE4405F),
            Color(0xFFF77737),
            Color(0xFFFCAF45),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 18),
    );
  }
}

class _TikTokIcon extends StatelessWidget {
  const _TikTokIcon();

  @override
  Widget build(BuildContext context) {
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
}

class _ThreadsIcon extends StatelessWidget {
  const _ThreadsIcon();

  @override
  Widget build(BuildContext context) {
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
}

class _XIcon extends StatelessWidget {
  const _XIcon();

  @override
  Widget build(BuildContext context) {
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
}

class _DailymotionIcon extends StatelessWidget {
  const _DailymotionIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF0066DC),
            const Color(0xFF0066DC).withValues(alpha: 0.7),
          ],
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
}

class _VimeoIcon extends StatelessWidget {
  const _VimeoIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1AB7EA),
            const Color(0xFF1AB7EA).withValues(alpha: 0.7),
          ],
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
}
