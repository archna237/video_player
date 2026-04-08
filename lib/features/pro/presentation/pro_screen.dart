import 'package:flutter/material.dart';

class ProScreen extends StatefulWidget {
  const ProScreen({super.key});

  static const routeName = '/pro';

  @override
  State<ProScreen> createState() => _ProScreenState();
}

class _ProScreenState extends State<ProScreen>
    with SingleTickerProviderStateMixin {
  int _selectedPlan = 0; // 0=Weekly, 1=Monthly, 2=Yearly

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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // ── Dark Deep Purple Background ──────────────────────────────
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1A0A2E), // very dark top
                    Color(0xFF13052A), // dark mid
                    Color(0xFF0D0318), // near-black bottom
                  ],
                  stops: [0.0, 0.55, 1.0],
                ),
              ),
            ),
          ),

          // ── Subtle purple glow blob at top ───────────────────────────
          Positioned(
            top: -80,
            left: -60,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF6B3FBF).withValues(alpha: 0.35),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF9B59D0).withValues(alpha: 0.20),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // ── Main Scrollable Content ──────────────────────────────────
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Close button
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, top: 4),
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
                  ),

                  // ── Top Drama Poster Collage ──────────────────────────
                  _buildTopCollage(),

                  const SizedBox(height: 18),

                  // ── "Video Player PRO" Title ──────────────────────────
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Video Player PRO',
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

                  // ── Benefits ─────────────────────────────────────────
                  const _BenefitLine(text: '100% Ad-Free'),
                  const _BenefitLine(text: 'Unlock Download all video'),
                  const _BenefitLine(text: 'Unlock Video player'),
                  const _BenefitLine(text: 'HD video'),

                  const SizedBox(height: 22),

                  // ── Plan Tiles ────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      children: [
                        _PlanTile(
                          selected: _selectedPlan == 0,
                          title: 'Weekly',
                          subtitle: '3 days free trial',
                          price: 'Then ₹430.00',
                          period: '/week',
                          showTag: true,
                          onTap: () => setState(() => _selectedPlan = 0),
                          pulseAnim: _pulseAnim,
                        ),
                        const SizedBox(height: 12),
                        _PlanTile(
                          selected: _selectedPlan == 1,
                          title: 'Monthly',
                          subtitle: '',
                          price: '₹850.00',
                          period: '/month',
                          onTap: () => setState(() => _selectedPlan = 1),
                          pulseAnim: _pulseAnim,
                        ),
                        const SizedBox(height: 12),
                        _PlanTile(
                          selected: _selectedPlan == 2,
                          title: 'Yearly',
                          subtitle: '',
                          price: '₹1,600.00',
                          period: '/year',
                          onTap: () => setState(() => _selectedPlan = 2),
                          pulseAnim: _pulseAnim,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── No Payment Now ────────────────────────────────────
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
                      const Text(
                        'No Payment Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ── CTA Button ────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: _GradientButton(
                      onTap: () {},
                      label: 'Start with free trial',
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ── Renew Note ────────────────────────────────────────
                  Text(
                    'Renew ₹430.00/week  Cancel anytime!',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.65),
                      fontSize: 12.5,
                      letterSpacing: 0.1,
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

  // ── Drama Poster Collage Layout ────────────────────────────────────────────
  Widget _buildTopCollage() {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          // Full-width semi-transparent drama grid background
          Positioned.fill(
            child: ClipRect(
              child: Image.asset(
                'assets/images/drama_collage.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildFallbackCollage(),
              ),
            ),
          ),

          // Bottom gradient fade so it blends into background
          Positioned.fill(
            child: DecoratedBox(
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
            ),
          ),

          // Side fade-outs
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFF1A0A2E).withValues(alpha: 0.6),
                    Colors.transparent,
                    Colors.transparent,
                    const Color(0xFF1A0A2E).withValues(alpha: 0.6),
                  ],
                  stops: const [0.0, 0.18, 0.82, 1.0],
                ),
              ),
            ),
          ),

          // Center raised card (featured image highlighted)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0),
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
                    errorBuilder: (context, error, stackTrace) => Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF7B4FA6), Color(0xFF3C1F6B)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Icon(
                        Icons.movie_rounded,
                        color: Colors.white54,
                        size: 48,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackCollage() {
    final colors = [
      const Color(0xFF6B3482),
      const Color(0xFF4A2172),
      const Color(0xFF7E4590),
      const Color(0xFF3B1A5F),
      const Color(0xFF5C2E80),
      const Color(0xFF8B4FAA),
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
      itemBuilder: (context, i) => Container(color: colors[i % colors.length]),
    );
  }
}

// ── Benefit Row ────────────────────────────────────────────────────────────────

class _BenefitLine extends StatelessWidget {
  const _BenefitLine({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 5),
      child: Row(
        children: [
          const Icon(
            Icons.check_rounded,
            size: 18,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Plan Tile ──────────────────────────────────────────────────────────────────

class _PlanTile extends StatelessWidget {
  const _PlanTile({
    required this.selected,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.period,
    required this.onTap,
    required this.pulseAnim,
    this.showTag = false,
  });

  final bool selected;
  final String title;
  final String subtitle;
  final String price;
  final String period;
  final VoidCallback onTap;
  final Animation<double> pulseAnim;
  final bool showTag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: pulseAnim,
        builder: (context, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
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
                            .withValues(alpha: 0.28 * (pulseAnim.value)),
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
            // Main content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left: title + subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: selected
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.9),
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.1,
                          ),
                        ),
                        if (subtitle.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.75),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Right: price
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: price,
                          style: TextStyle(
                            color: selected
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.85),
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: period,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.65),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // White pill tag at top-right (only when selected)
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
                  child: const Text(
                    'Best Value',
                    style: TextStyle(
                      color: Color(0xFF5B2BAA),
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
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

// ── Gradient CTA Button ────────────────────────────────────────────────────────

class _GradientButton extends StatefulWidget {
  const _GradientButton({required this.onTap, required this.label});

  final VoidCallback onTap;
  final String label;

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: Container(
          width: double.infinity,
          height: 58,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [
                Color(0xFFE17BFF), // light pink-purple left
                Color(0xFFB560FF), // mid purple
                Color(0xFF9B4FF0), // deep purple right
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFB048FF).withValues(alpha: 0.45),
                blurRadius: 22,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Text(
            'Start with free trial',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
