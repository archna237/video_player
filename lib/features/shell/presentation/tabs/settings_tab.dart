import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/core/theme/app_colors.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool _ongoingNotification = true;
  bool _wifiOnly = false;
  bool _syncToGallery = false;
  String _selectedLanguage = 'English';

  final List<String> _languages = const [
    'English',
    'Hindi',
    'Spanish',
    'Portuguese',
    'Arabic',
  ];

  static const String _storeUrl =
      'https://play.google.com/store/apps/details?id=com.videosaver.downloadvideo.mp4.app';
  static const String _privacyPolicyUrl =
      'https://play.google.com/store/apps/details?id=com.videosaver.downloadvideo.mp4.app';

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 24, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha: 0.1),
              Colors.white.withValues(alpha: 0.0),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(2, 4),
            )
          ],
        ),
        child: Icon(icon, color: Colors.white.withValues(alpha: 0.95), size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing ?? const Icon(Icons.chevron_right, color: Colors.white54, size: 20),
      onTap: onTap ?? () {},
    );
  }

  Widget _buildSwitch({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
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
    final ok = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
    if (!mounted || ok) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not open link.')),
    );
  }

  Future<void> _shareApp() async {
    await SharePlus.instance.share(
      ShareParams(
        title: 'Video Player',
        text: 'Try this app: $_storeUrl',
      ),
    );
  }

  Future<void> _showLanguageDialog() async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF18122B),
          title: const Text('Select language'),
          content: SizedBox(
            width: 320,
            child: ListView(
              shrinkWrap: true,
              children: _languages.map((language) {
                final selected = language == _selectedLanguage;
                return ListTile(
                  title: Text(language),
                  trailing: Icon(
                    selected
                        ? Icons.radio_button_checked_rounded
                        : Icons.radio_button_unchecked_rounded,
                    color: selected
                        ? AppColors.primary
                        : Colors.white.withValues(alpha: 0.6),
                  ),
                  onTap: () {
                    setState(() => _selectedLanguage = language);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void _showComingSoon(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title coming soon')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(top: 16, bottom: 40),
        children: [
          Center(
            child: Text(
              'Settings',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          
          _buildSectionHeader('SHORTCUTS'),
          _buildTile(
            icon: Icons.notifications_rounded,
            title: 'On-going Notification',
            trailing: _buildSwitch(
              value: _ongoingNotification,
              onChanged: (val) => setState(() => _ongoingNotification = val),
            ),
            onTap: () => setState(() => _ongoingNotification = !_ongoingNotification),
          ),

          _buildSectionHeader('GENERAL'),
          _buildTile(
            icon: Icons.wifi_rounded,
            title: 'Download with Wifi only',
            trailing: _buildSwitch(
              value: _wifiOnly,
              onChanged: (val) => setState(() => _wifiOnly = val),
            ),
            onTap: () => setState(() => _wifiOnly = !_wifiOnly),
          ),
          _buildTile(
            icon: Icons.image_rounded,
            title: 'Sync to Gallery',
            trailing: _buildSwitch(
              value: _syncToGallery,
              onChanged: (val) => setState(() => _syncToGallery = val),
            ),
            onTap: () => setState(() => _syncToGallery = !_syncToGallery),
          ),
          _buildTile(
            icon: Icons.info_rounded,
            title: 'Disclaimer',
            onTap: () => _showComingSoon('Disclaimer'),
          ),
          _buildTile(
            icon: Icons.help_rounded,
            title: 'How to Download',
            onTap: () => _showComingSoon('How to Download'),
          ),
          _buildTile(
            icon: Icons.lock_rounded,
            title: 'Setup Passcode',
            onTap: () => _showComingSoon('Setup Passcode'),
          ),

          _buildSectionHeader('MORE'),
          _buildTile(
            icon: Icons.translate_rounded,
            title: 'Language',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _selectedLanguage,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            onTap: _showLanguageDialog,
          ),
          _buildTile(
            icon: Icons.chat_bubble_rounded,
            title: 'Send Feedback',
            onTap: () => _showComingSoon('Send Feedback'),
          ),
          _buildTile(
            icon: Icons.star_rounded,
            title: 'Rate us',
            onTap: () => _openUrl(_storeUrl),
          ),
          _buildTile(
            icon: Icons.share_rounded,
            title: 'Share app',
            onTap: _shareApp,
          ),
          _buildTile(
            icon: Icons.privacy_tip_rounded,
            title: 'Privacy Policy',
            onTap: () => _openUrl(_privacyPolicyUrl),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

