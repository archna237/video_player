import 'package:flutter/material.dart';
import 'package:video_player/core/widgets/gradient_cta_button.dart';
import 'package:video_player/l10n/app_localizations.dart';

class ProScreen extends StatefulWidget {
  const ProScreen({super.key});

  static const routeName = '/pro';

  @override
  State<ProScreen> createState() => _ProScreenState();
}

class _ProScreenState extends State<ProScreen>
    with SingleTickerProviderStateMixin {
  int _selectedPlan = 0;

  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1A0A2E),
                    Color(0xFF13052A),
                    Color(0xFF0D0318),
                  ],
                  stops: [0.0, 0.55, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            top: -80,
            left: -60,
            child: _glowBlob(300, const Color(0xFF6B3FBF), 0.35),
          ),
          Positioned(
            top: 60,
            right: -80,
            child: _glowBlob(260, const Color(0xFF9B59D0), 0.20),
          ),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.12),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  _buildTopCollage(),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      l10n.appNamePro,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 0.5,
                        height: 1.1,
                        shadows: [
                          Shadow(
                            color: Color(0x88B48BFF),
                            blurRadius: 18,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  _BenefitLine(text: l10n.benefitAdFree),
                  _BenefitLine(text: l10n.benefitDownloadAll),
                  _BenefitLine(text: l10n.benefitPlayer),
                  _BenefitLine(text: l10n.benefitHd),
                  const SizedBox(height: 22),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      children: [
                        _PlanTile(
                          selected: _selectedPlan == 0,
                          title: l10n.planWeekly,
                          subtitle: l10n.planTrialSubtitle,
                          price: l10n.planWeeklyPrice,
                          period: '/week',
                          showTag: true,
                          bestValueLabel: l10n.bestValueTag,
                          pulseAnim: _pulseAnim,
                          onTap: () => setState(() => _selectedPlan = 0),
                        ),
                        const SizedBox(height: 12),
                        _PlanTile(
                          selected: _selectedPlan == 1,
                          title: l10n.planMonthly,
                          price: l10n.planMonthlyPrice,
                          period: '/month',
                          pulseAnim: _pulseAnim,
                          onTap: () => setState(() => _selectedPlan = 1),
                        ),
                        const SizedBox(height: 12),
                        _PlanTile(
                          selected: _selectedPlan == 2,
                          title: l10n.planYearly,
                          price: l10n.planYearlyPrice,
                          period: '/year',
                          pulseAnim: _pulseAnim,
                          onTap: () => setState(() => _selectedPlan = 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF3B7ED4),
                        ),
                        padding: const EdgeInsets.all(3),
                        child: const Icon(
                          Icons.shield_rounded,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.noPaymentNow,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: GradientCtaButton(
                      label: l10n.startFreeTrial,
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.renewNote,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.65),
                      fontSize: 12.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glowBlob(double size, Color color, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withValues(alpha: opacity), Colors.transparent],
        ),
      ),
    );
  }

  Widget _buildTopCollage() {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRect(
              child: Image.asset(
                'assets/images/drama_collage.jpg',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _fallbackCollage(),
              ),
            ),
          ),
          Positioned.fill(child: _collageFade()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 120,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.25),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.6),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child: Image.asset(
                  'assets/images/drama_collage.jpg',
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, -0.5),
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.movie_rounded,
                    color: Colors.white54,
                    size: 48,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _collageFade() {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFF1A0A2E).withValues(alpha: 0.65),
            const Color(0xFF13052A),
          ],
          stops: const [0.0, 0.72, 1.0],
        ),
      ),
    );
  }

  Widget _fallbackCollage() {
    final colors = [
      const Color(0xFF6B3482),
      const Color(0xFF4A2172),
      const Color(0xFF7E4590),
      const Color(0xFF3B1A5F),
      const Color(0xFF5C2E80),
    ];
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 0.65,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: 20,
      itemBuilder: (_, i) => ColoredBox(color: colors[i % colors.length]),
    );
  }
}

class _BenefitLine extends StatelessWidget {
  const _BenefitLine({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.check_rounded, size: 18, color: Colors.white),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanTile extends StatelessWidget {
  const _PlanTile({
    required this.selected,
    required this.title,
    required this.price,
    required this.period,
    required this.onTap,
    required this.pulseAnim,
    this.subtitle = '',
    this.showTag = false,
    this.bestValueLabel = '',
  });

  final bool selected;
  final String title;
  final String subtitle;
  final String price;
  final String period;
  final VoidCallback onTap;
  final Animation<double> pulseAnim;
  final bool showTag;
  final String bestValueLabel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: pulseAnim,
        builder: (context, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: selected
                  ? const Color(0xFF2A1650).withValues(alpha: 0.85)
                  : Colors.white.withValues(alpha: 0.04),
              border: Border.all(
                width: selected ? 2 : 1.2,
                color: selected
                    ? const Color(0xFF9E80FF)
                    : Colors.white.withValues(alpha: 0.22),
              ),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: const Color(0xFF7B55FF)
                            .withValues(alpha: 0.28 * pulseAnim.value),
                        blurRadius: 18 * pulseAnim.value,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
            child: child,
          );
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (subtitle.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.75),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: price,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: period,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.65),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (showTag && selected)
              Positioned(
                top: -11,
                right: 14,
                child: Container(
                  height: 22,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    bestValueLabel,
                    style: const TextStyle(
                      color: Color(0xFF5B2BAA),
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
