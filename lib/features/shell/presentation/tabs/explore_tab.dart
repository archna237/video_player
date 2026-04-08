import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/features/downloads/domain/download_item.dart';
import 'package:video_player/features/videos/presentation/video_player_screen.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  final _linkController = TextEditingController();

  final List<DownloadItem> _items = List.generate(
    4,
    (i) => DownloadItem(
      title: 'Sample tutorial video ${i + 1}',
      qualityLabel: '720p',
      formatLabel: 'MP4',
      sizeLabel: '24 MB',
    ),
  );

  @override
  void dispose() {
    _linkController.dispose();
    super.dispose();
  }

  Future<void> _openPhotoLibrary() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (!mounted) return;
    if (file == null) return; // user cancelled

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Selected: ${file.name}')),
    );
  }

  Future<void> _openGoogle() async {
    const url = 'https://www.google.com';
    final uri = Uri.parse(url);

    final ok = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!mounted) return;
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open Google.')),
      );
    }
  }

  void _addFromLink() {
    final link = _linkController.text.trim();
    if (link.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Paste a video link first.')),
      );
      return;
    }

    final title = _titleFromUrl(link);
    setState(() {
      _items.insert(
        0,
        DownloadItem(
          title: title,
          qualityLabel: 'Auto',
          formatLabel: 'MP4',
          sizeLabel: 'Queued',
        ),
      );
    });

    _linkController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to recent downloads.')),
    );
  }

  String _titleFromUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return 'New Video';
    if (uri.pathSegments.isNotEmpty) {
      final last = uri.pathSegments.last;
      if (last.isNotEmpty) return last.replaceAll(RegExp(r'[-_]+'), ' ');
    }
    return 'New Video';
  }

  void _openItem(DownloadItem item) {
    Navigator.of(context).pushNamed(
      VideoPlayerScreen.routeName,
      arguments: item,
    );
  }

  void _handleCardTap({required int index, required DownloadItem item}) {
    // Based on your request:
    // - first card => open photo library
    // - second card => open Google
    // - other cards => open player
    if (index == 0) {
      _openPhotoLibrary();
      return;
    }
    if (index == 1) {
      _openGoogle();
      return;
    }
    _openItem(item);
  }

  void _showItemActions(DownloadItem item, int index) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.open_in_full_rounded),
                title: const Text('Open'),
                onTap: () {
                  Navigator.pop(context);
                  _handleCardTap(index: index, item: item);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline_rounded),
                title: const Text('Delete from list'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _items.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Removed.')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary.withValues(alpha: 0.16),
                    Colors.transparent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: colorScheme.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Paste video link',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _linkController,
                          decoration: InputDecoration(
                            hintText: 'https://',
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                          ),
                          style: const TextStyle(fontSize: 14),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _addFromLink(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 44,
                        child: ElevatedButton.icon(
                          onPressed: _addFromLink,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.download_rounded, size: 20),
                          label: const Text('Download'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Supported: MP4, MOV, MKV, AVI and more',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Recent downloads',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: _items.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.02),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.04),
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => _handleCardTap(index: index, item: item),
                        child: Row(
                          children: [
                            Container(
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white.withValues(alpha: 0.06),
                              ),
                              child: const Icon(
                                Icons.play_circle_outline_rounded,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${item.qualityLabel} • ${item.formatLabel} • ${item.sizeLabel}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withValues(alpha: 0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              onPressed: () => _showItemActions(item, index),
                              icon: const Icon(Icons.more_vert_rounded),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


