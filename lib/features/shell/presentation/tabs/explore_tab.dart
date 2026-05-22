import 'package:flutter/material.dart';
import 'package:video_player/core/layout/responsive.dart';
import 'package:video_player/core/theme/app_colors.dart';
import 'package:video_player/core/widgets/pro_badge.dart';
import 'package:video_player/core/widgets/search_pill.dart';
import 'package:video_player/features/browser/presentation/browser_screen.dart';
import 'package:video_player/features/explore/data/browser_shortcuts.dart';
import 'package:video_player/features/explore/domain/browser_history_entry.dart';
import 'package:video_player/features/explore/presentation/widgets/history_list_tile.dart';
import 'package:video_player/features/explore/presentation/widgets/quick_link_tile.dart';
import 'package:video_player/features/pro/presentation/pro_screen.dart';
import 'package:video_player/l10n/app_localizations.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  final List<BrowserHistoryEntry> _history = [
    const BrowserHistoryEntry(
      title: 'Google',
      url: 'https://www.google.com/',
    ),
    const BrowserHistoryEntry(
      title: 'Google',
      url: 'https://www.google.com/',
    ),
  ];

  void _openBrowser(String url) {
    Navigator.of(context).pushNamed(BrowserScreen.routeName, arguments: url);
  }

  void _openPro() => Navigator.of(context).pushNamed(ProScreen.routeName);

  void _clearHistory() => setState(() => _history.clear());

  void _removeAt(int index) => setState(() => _history.removeAt(index));

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hPad = Responsive.horizontalPadding(context);

    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Responsive.maxContentWidth(context),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad - 4),
                child: Row(
                  children: [
                    Expanded(
                      child: SearchPill(
                        hint: l10n.searchHint,
                        onTap: () => _openBrowser('https://www.google.com'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ProBadge(onTap: _openPro, compact: true, pulse: false),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad),
                child: Wrap(
                  spacing: 18,
                  runSpacing: 18,
                  children: BrowserShortcuts.all.map((shortcut) {
                    return QuickLinkTile(
                      shortcut: shortcut,
                      onTap: () => _openBrowser(shortcut.url),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 28),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.historyTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (_history.isNotEmpty)
                      GestureDetector(
                        onTap: _clearHistory,
                        child: Text(
                          l10n.clearAll,
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
              Expanded(
                child: _history.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.history_rounded,
                              color: Colors.white.withValues(alpha: 0.15),
                              size: 56,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              l10n.noBrowsingHistory,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.35),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: hPad - 4),
                        itemCount: _history.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final entry = _history[index];
                          return HistoryListTile(
                            entry: entry,
                            onTap: () => _openBrowser(entry.url),
                            onDelete: () => _removeAt(index),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
