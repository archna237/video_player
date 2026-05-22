import 'package:flutter/material.dart';
import 'package:video_player/core/layout/responsive.dart';
import 'package:video_player/core/widgets/empty_state_lottie.dart';
import 'package:video_player/core/widgets/pro_badge.dart';
import 'package:video_player/core/widgets/segmented_toggle.dart';
import 'package:video_player/features/pro/presentation/pro_screen.dart';
import 'package:video_player/l10n/app_localizations.dart';

class LibraryTab extends StatefulWidget {
  const LibraryTab({super.key});

  @override
  State<LibraryTab> createState() => _LibraryTabState();
}

class _LibraryTabState extends State<LibraryTab> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hPad = Responsive.horizontalPadding(context);
    final emptyMessage = _selectedTab == 0
        ? l10n.emptyProcessing
        : l10n.emptyDownloaded;

    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Responsive.maxContentWidth(context),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.insert_drive_file_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                    Text(
                      l10n.downloadsTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    ProBadge(
                      onTap: () =>
                          Navigator.of(context).pushNamed(ProScreen.routeName),
                      pulse: false,
                      compact: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad),
                child: SegmentedToggle(
                  labels: [l10n.processingTab, l10n.downloadedTab],
                  selectedIndex: _selectedTab,
                  onChanged: (index) => setState(() => _selectedTab = index),
                ),
              ),
              Expanded(
                child: Center(
                  child: EmptyStateLottie(
                    asset: 'assets/animations/empty_box_anim.json',
                    message: emptyMessage,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
