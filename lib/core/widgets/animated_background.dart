import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/app_theme.dart';

class AnimatedBackground extends StatefulWidget {
  final bool isDarkMode;

  const AnimatedBackground({
    super.key,
    required this.isDarkMode,
  });

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    final random = math.Random();
    for (int i = 0; i < 14; i++) {
      _particles.add(Particle(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: random.nextDouble() * 3 + 1,
        speedX: (random.nextDouble() - 0.5) * 0.0003,
        speedY: (random.nextDouble() - 0.5) * 0.0003,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: Stack(
        children: [
          // Base gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: widget.isDarkMode ? [
                  AppTheme.darkBackground,
                  AppTheme.darkBackgroundLight,
                  AppTheme.darkBackground,
                ] : [
                  AppTheme.lightBackground,
                  AppTheme.lightBackgroundLight,
                  AppTheme.lightBackground,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Faint circuit grid — reinforces the "code-inspired" tech feel
          RepaintBoundary(
            child: CustomPaint(
              painter: _GridPainter(widget.isDarkMode),
              size: Size.infinite,
            ),
          ),

          // Gradient Orbs
          RepaintBoundary(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Stack(
                  children: List.generate(4, (index) {
                    return _buildGradientOrb(context, index);
                  }),
                );
              },
            ),
          ),

          // Particles
          RepaintBoundary(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: ParticlePainter(
                    _particles,
                    _controller.value,
                    widget.isDarkMode,
                  ),
                  size: Size.infinite,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientOrb(BuildContext context, int index) {
    const positions = [
      Alignment(-0.8, -0.6),
      Alignment(0.8, -0.4),
      Alignment(-0.6, 0.5),
      Alignment(0.7, 0.7),
    ];

    // Kept strictly within the cyan/purple family for a cohesive,
    // non-neon "premium tech" glow rather than a scattered rainbow.
    final colors = widget.isDarkMode ? [
      [AppTheme.darkPrimary, AppTheme.darkAccent],
      [AppTheme.darkAccent, AppTheme.darkTertiary],
      [AppTheme.darkSecondary, AppTheme.darkPrimary],
      [AppTheme.darkTertiary, AppTheme.darkAccentDark],
    ] : [
      [AppTheme.lightPrimary, AppTheme.lightAccent],
      [AppTheme.lightAccent, AppTheme.lightTertiary],
      [AppTheme.lightSecondary, AppTheme.lightPrimary],
      [AppTheme.lightTertiary, AppTheme.lightAccentDark],
    ];

    const sizes = [600.0, 500.0, 550.0, 480.0];

    final screenSize = MediaQuery.of(context).size;
    final offset = math.sin(_controller.value * 2 * math.pi + index) * 50;

    return Positioned(
      top: (screenSize.height * 0.5) + offset,
      left: (screenSize.width * 0.5) + offset * 1.5,
      child: Transform.translate(
        offset: Offset(
          positions[index].x * screenSize.width / 2,
          positions[index].y * screenSize.height / 2,
        ),
        child: Container(
          width: sizes[index],
          height: sizes[index],
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                colors[index][0].withOpacity(widget.isDarkMode ? 0.3 : 0.2),
                colors[index][1].withOpacity(widget.isDarkMode ? 0.15 : 0.1),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Particle {
  double x;
  double y;
  final double size;
  final double speedX;
  final double speedY;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speedX,
    required this.speedY,
  });

  void update() {
    x += speedX;
    y += speedY;

    if (x < 0) x = 1;
    if (x > 1) x = 0;
    if (y < 0) y = 1;
    if (y > 1) y = 0;
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double animationValue;
  final bool isDarkMode;

  ParticlePainter(this.particles, this.animationValue, this.isDarkMode);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = (isDarkMode ? AppTheme.darkPrimary : AppTheme.lightTextSecondary)
          .withOpacity(isDarkMode ? 0.35 : 0.25)
      ..style = PaintingStyle.fill;

    for (var particle in particles) {
      particle.update();
      canvas.drawCircle(
        Offset(particle.x * size.width, particle.y * size.height),
        particle.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) => true;
}

/// Very faint circuit-board style grid — a quiet nod to "code" without
/// competing with the glass cards on top of it.
class _GridPainter extends CustomPainter {
  final bool isDarkMode;
  const _GridPainter(this.isDarkMode);

  @override
  void paint(Canvas canvas, Size size) {
    if (!isDarkMode) return; // keep light mode clean/minimal

    final linePaint = Paint()
      ..color = AppTheme.darkPrimary.withOpacity(0.035)
      ..strokeWidth = 1;

    const spacing = 64.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    // A handful of brighter "node" dots at grid intersections for a
    // subtle circuit-board accent.
    final nodePaint = Paint()..color = AppTheme.darkAccent.withOpacity(0.12);
    final random = math.Random(7);
    for (int i = 0; i < 18; i++) {
      final gx = (random.nextInt((size.width / spacing).ceil()) * spacing);
      final gy = (random.nextInt((size.height / spacing).ceil()) * spacing);
      canvas.drawCircle(Offset(gx, gy), 2.2, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) =>
      oldDelegate.isDarkMode != isDarkMode;
}