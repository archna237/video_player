import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/core/theme/app_colors.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

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

  Widget _buildSwitch({required bool value}) {
    return Transform.scale(
      scale: 0.9,
      child: CupertinoSwitch(
        value: value,
        activeColor: AppColors.primary,
        onChanged: (val) {},
      ),
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
            trailing: _buildSwitch(value: true),
          ),

          _buildSectionHeader('GENERAL'),
          _buildTile(
            icon: Icons.wifi_rounded,
            title: 'Download with Wifi only',
            trailing: _buildSwitch(value: false),
          ),
          _buildTile(
            icon: Icons.image_rounded,
            title: 'Sync to Gallery',
            trailing: _buildSwitch(value: false),
          ),
          _buildTile(
            icon: Icons.info_rounded,
            title: 'Disclaimer',
          ),
          _buildTile(
            icon: Icons.help_rounded,
            title: 'How to Download',
          ),
          _buildTile(
            icon: Icons.lock_rounded,
            title: 'Setup Passcode',
          ),

          _buildSectionHeader('MORE'),
          _buildTile(
            icon: Icons.translate_rounded,
            title: 'Language',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'English',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                // Notice language doesn't have a chevron in the image, it's just the purple text! Wait, I don't see a chevron. I will omit it.
              ],
            ),
          ),
          _buildTile(
            icon: Icons.chat_bubble_rounded,
            title: 'Send Feedback',
          ),
          _buildTile(
            icon: Icons.star_rounded,
            title: 'Rate us',
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

