import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/core/layout/responsive.dart';
import 'package:video_player/core/widgets/downloader_orb.dart';
import 'package:video_player/core/widgets/feature_card.dart';
import 'package:video_player/core/widgets/paste_link_field.dart';
import 'package:video_player/core/widgets/screen_header.dart';
import 'package:video_player/core/widgets/video_player_orb.dart';
import 'package:video_player/features/browser/presentation/browser_screen.dart';
import 'package:video_player/features/home/presentation/paste_link_sheet.dart';
import 'package:video_player/features/pro/presentation/pro_screen.dart';
import 'package:video_player/l10n/app_localizations.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  Future<void> _openGallery(BuildContext context) async {
    final l10n = context.l10n;
    final file = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (!context.mounted || file == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.selectedFile(file.name))),
    );
  }

  void _openDownloader(BuildContext context) {
    Navigator.of(context).pushNamed(
      BrowserScreen.routeName,
      arguments: 'https://www.google.com',
    );
  }

  void _openPro(BuildContext context) {
    Navigator.of(context).pushNamed(ProScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hPad = Responsive.horizontalPadding(context);
    final cardHeight = Responsive.featureCardHeight(context);

    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Responsive.maxContentWidth(context),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenHeader(
                  title: l10n.appName,
                  onProTap: () => _openPro(context),
                ),
                const SizedBox(height: 22),
                PasteLinkField(
                  onTap: () => showPasteLinkSheet(context),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: cardHeight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: FeatureCard(
                          onTap: () => _openGallery(context),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF7B3FDE), Color(0xFF4A2ECC)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          title: l10n.videoPlayerCardTitle,
                          subtitle: l10n.videoPlayerCardSubtitle,
                          illustration: const VideoPlayerOrb(),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: FeatureCard(
                          onTap: () => _openDownloader(context),
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
                          title: l10n.videoDownloaderTitle,
                          subtitle: l10n.videoDownloaderSubtitle,
                          illustration: const DownloaderOrb(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
