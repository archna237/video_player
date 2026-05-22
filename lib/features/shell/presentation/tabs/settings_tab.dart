import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/core/constants/app_config.dart';
import 'package:video_player/core/locale/locale_controller.dart';
import 'package:video_player/core/theme/app_colors.dart';
import 'package:video_player/core/widgets/section_header.dart';
import 'package:video_player/core/widgets/settings_tile.dart';
import 'package:video_player/features/settings/presentation/disclaimer_dialog.dart';
import 'package:video_player/features/settings/presentation/how_to_download_screen.dart';
import 'package:video_player/l10n/app_localizations.dart';
import 'package:video_player/main.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool _ongoingNotification = true;
  bool _wifiOnly = false;
  bool _syncToGallery = false;

  LocaleController get _localeController => localeController;

  Widget _switch({required bool value, required ValueChanged<bool> onChanged}) {
    return Transform.scale(
      scale: 0.9,
      child: CupertinoSwitch(
        value: value,
        activeTrackColor: AppColors.primary,
        onChanged: onChanged,
      ),
    );
  }

  Future<void> _openUrl(String url) async {
    final l10n = context.l10n;
    final ok = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
    if (!mounted || ok) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.couldNotOpenLink)),
    );
  }

  Future<void> _shareApp() async {
    final l10n = context.l10n;
    await SharePlus.instance.share(
      ShareParams(
        title: l10n.appName,
        text: '${l10n.shareAppMessage} ${AppConfig.storeUrl}',
      ),
    );
  }

  Future<void> _showLanguageDialog() async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final dialogL10n = dialogContext.l10n;
        return AlertDialog(
          backgroundColor: const Color(0xFF18122B),
          title: Text(dialogL10n.chooseLanguage),
          content: SizedBox(
            width: 320,
            child: ListView(
              shrinkWrap: true,
              children: AppLocalizations.languageCodes.map((code) {
                final selected =
                    _localeController.locale.languageCode == code;
                return ListTile(
                  title: Text(dialogL10n.languageNameFor(code)),
                  trailing: Icon(
                    selected
                        ? Icons.radio_button_checked_rounded
                        : Icons.radio_button_unchecked_rounded,
                    color: selected
                        ? AppColors.primary
                        : Colors.white.withValues(alpha: 0.6),
                  ),
                  onTap: () async {
                    await _localeController.setLanguageCode(code);
                    if (dialogContext.mounted) Navigator.pop(dialogContext);
                    if (mounted) setState(() {});
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final currentLang =
        l10n.languageNameFor(_localeController.locale.languageCode);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(top: 16, bottom: 40),
        children: [
          Center(
            child: Text(
              l10n.settingsTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          SectionHeader(title: l10n.sectionShortcuts),
          SettingsTile(
            icon: Icons.notifications_rounded,
            title: l10n.ongoingNotification,
            trailing: _switch(
              value: _ongoingNotification,
              onChanged: (v) => setState(() => _ongoingNotification = v),
            ),
            onTap: () =>
                setState(() => _ongoingNotification = !_ongoingNotification),
          ),
          SectionHeader(title: l10n.sectionGeneral),
          SettingsTile(
            icon: Icons.wifi_rounded,
            title: l10n.wifiOnly,
            trailing: _switch(
              value: _wifiOnly,
              onChanged: (v) => setState(() => _wifiOnly = v),
            ),
            onTap: () => setState(() => _wifiOnly = !_wifiOnly),
          ),
          SettingsTile(
            icon: Icons.image_rounded,
            title: l10n.syncGallery,
            trailing: _switch(
              value: _syncToGallery,
              onChanged: (v) => setState(() => _syncToGallery = v),
            ),
            onTap: () => setState(() => _syncToGallery = !_syncToGallery),
          ),
          SettingsTile(
            icon: Icons.info_rounded,
            title: l10n.disclaimer,
            onTap: () => showDisclaimerDialog(context),
          ),
          SettingsTile(
            icon: Icons.help_rounded,
            title: l10n.howToDownload,
            onTap: () => Navigator.of(context).pushNamed(
              HowToDownloadScreen.routeName,
            ),
          ),
          SettingsTile(
            icon: Icons.lock_rounded,
            title: l10n.setupPasscode,
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.passcodeComingSoon)),
            ),
          ),
          SectionHeader(title: l10n.sectionMore),
          SettingsTile(
            icon: Icons.translate_rounded,
            title: l10n.language,
            trailing: Text(
              currentLang,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: _showLanguageDialog,
          ),
          SettingsTile(
            icon: Icons.chat_bubble_rounded,
            title: l10n.sendFeedback,
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.feedbackComingSoon)),
            ),
          ),
          SettingsTile(
            icon: Icons.star_rounded,
            title: l10n.rateUs,
            onTap: () => _openUrl(AppConfig.storeUrl),
          ),
          SettingsTile(
            icon: Icons.share_rounded,
            title: l10n.shareApp,
            onTap: _shareApp,
          ),
          SettingsTile(
            icon: Icons.privacy_tip_rounded,
            title: l10n.privacyPolicy,
            onTap: () => _openUrl(AppConfig.storeUrl),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
