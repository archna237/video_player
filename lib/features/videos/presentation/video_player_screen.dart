import 'package:flutter/material.dart';
import 'package:video_player/core/widgets/app_logo.dart';
import 'package:video_player/features/downloads/domain/download_item.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({
    super.key,
    required this.item,
  });

  static const routeName = '/player';

  final DownloadItem item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        titleSpacing: 0,
        title: Row(
          children: [
            AppLogo(size: 28, showGlow: false),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Player',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_border_rounded,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.play_circle_outline_rounded,
                    size: 84,
                    color: colorScheme.primary.withValues(alpha: 0.9),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              item.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${item.qualityLabel} • ${item.formatLabel} • ${item.sizeLabel}',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.open_in_full_rounded),
                label: const Text('Open Player'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

