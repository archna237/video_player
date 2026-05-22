import 'package:flutter/material.dart';
import 'package:video_player/core/theme/app_colors.dart';
import 'package:video_player/core/widgets/pill_gradient_button.dart';
import 'package:video_player/features/settings/presentation/widgets/how_to_phone_mockups.dart';
import 'package:video_player/l10n/app_localizations.dart';

class HowToDownloadScreen extends StatefulWidget {
  const HowToDownloadScreen({super.key});

  static const routeName = '/how-to-download';

  @override
  State<HowToDownloadScreen> createState() => _HowToDownloadScreenState();
}

class _HowToDownloadScreenState extends State<HowToDownloadScreen> {
  int _methodIndex = 0;

  static const _bg = Color(0xFF0F1018);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        ),
        title: Text(
          l10n.howToDownload,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(
              Icons.shield_outlined,
              color: Colors.white.withValues(alpha: 0.85),
              size: 22,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: _MethodToggle(
              methodIndex: _methodIndex,
              method1Label: l10n.method1,
              method2Label: l10n.method2,
              onChanged: (i) => setState(() => _methodIndex = i),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              _methodIndex == 0 ? l10n.htdMethod1Step : l10n.htdMethod2Step,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 280),
              child: _methodIndex == 0
                  ? HowToMethod1Mockup(
                      key: const ValueKey(0),
                      l10n: l10n,
                    )
                  : const HowToMethod2Mockup(key: ValueKey(1)),
            ),
          ),
          _PageDots(
            count: 2,
            index: _methodIndex,
            onDotTap: (i) => setState(() => _methodIndex = i),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: PillGradientButton(
              label: l10n.gotIt,
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _MethodToggle extends StatelessWidget {
  const _MethodToggle({
    required this.methodIndex,
    required this.method1Label,
    required this.method2Label,
    required this.onChanged,
  });

  final int methodIndex;
  final String method1Label;
  final String method2Label;
  final ValueChanged<int> onChanged;

  static const _trackColor = Color(0xFF252530);
  static const _gradient = LinearGradient(
    colors: [Color(0xFFA07CFF), Color(0xFFC38BFF)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: _trackColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Expanded(
            child: _MethodTab(
              label: method1Label,
              selected: methodIndex == 0,
              gradient: _gradient,
              onTap: () => onChanged(0),
            ),
          ),
          Expanded(
            child: _MethodTab(
              label: method2Label,
              selected: methodIndex == 1,
              gradient: _gradient,
              onTap: () => onChanged(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _MethodTab extends StatelessWidget {
  const _MethodTab({
    required this.label,
    required this.selected,
    required this.gradient,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final LinearGradient gradient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: selected ? gradient : null,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.white.withValues(alpha: 0.45),
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({
    required this.count,
    required this.index,
    this.onDotTap,
  });

  final int count;
  final int index;
  final ValueChanged<int>? onDotTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == index;
        return GestureDetector(
          onTap: onDotTap != null ? () => onDotTap!(i) : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: active ? 28 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: active
                  ? AppColors.primary
                  : Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}
