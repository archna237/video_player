import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/core/theme/app_colors.dart';
import 'package:video_player/features/browser/presentation/browser_screen.dart';
import 'package:video_player/l10n/app_localizations.dart';

Future<void> showPasteLinkSheet(BuildContext context) async {
  final controller = TextEditingController();
  final clipboard = await Clipboard.getData(Clipboard.kTextPlain);
  if (clipboard?.text?.isNotEmpty ?? false) {
    controller.text = clipboard!.text!;
  }

  if (!context.mounted) return;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: const Color(0xFF18122B),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      final sheetL10n = sheetContext.l10n;
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.viewInsetsOf(sheetContext).bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              sheetL10n.pasteLinkTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: sheetL10n.pasteLinkHint,
                suffixIcon: IconButton(
                  onPressed: () async {
                    final data = await Clipboard.getData(Clipboard.kTextPlain);
                    if (data?.text != null) {
                      controller.text = data!.text!;
                    }
                  },
                  icon: const Icon(Icons.content_paste_rounded),
                ),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                final link = controller.text.trim();
                if (link.isEmpty) {
                  ScaffoldMessenger.of(sheetContext).showSnackBar(
                    SnackBar(content: Text(sheetL10n.pasteLinkEmpty)),
                  );
                  return;
                }
                final uri = Uri.tryParse(link);
                final url = uri != null && uri.hasScheme
                    ? link
                    : 'https://$link';
                Navigator.pop(sheetContext);
                Navigator.of(context).pushNamed(
                  BrowserScreen.routeName,
                  arguments: url,
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size.fromHeight(48),
              ),
              child: Text(sheetL10n.openLink),
            ),
          ],
        ),
      );
    },
  );

  controller.dispose();
}
