import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;
import '../theme/app_theme.dart';

/// A futuristic "app-in-development" visual for the hero section:
/// a glass device frame with mock syntax-highlighted code lines,
/// orbited by a few floating tech chips. Built entirely from
/// existing design tokens (AppTheme) so it stays on-brand in both
/// themes and needs no image assets.
class HeroVisual extends StatefulWidget {
  final bool isDarkMode;
  final double size;

  const HeroVisual({
    super.key,
    required this.isDarkMode,
    this.size = 360,
  });

  @override
  State<HeroVisual> createState() => _HeroVisualState();
}

class _HeroVisualState extends State<HeroVisual>
    with TickerProviderStateMixin {
  late final AnimationController _driftController;

  static const _chips = [
    _TechChip('Flutter', Icons.flutter_dash),
    _TechChip('Firebase', Icons.local_fire_department_rounded),
    _TechChip('GetX', Icons.bolt_rounded),
    _TechChip('REST API', Icons.api_rounded),
  ];

  @override
  void initState() {
    super.initState();
    _driftController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _driftController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.size;

    return SizedBox(
      width: s,
      height: s,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Ambient glow behind the device
          Container(
            width: s * 0.75,
            height: s * 0.75,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppTheme.getPrimary(widget.isDarkMode).withOpacity(0.25),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Central device / code card
          AnimatedBuilder(
            animation: _driftController,
            builder: (context, child) {
              final t = _driftController.value * 2 * 3.14159;
              return Transform.translate(
                offset: Offset(0, 6 * math.sin(t)),
                child: child,
              );
            },
            child: _buildDeviceCard(s),
          ),

          // Orbiting tech chips
          for (int i = 0; i < _chips.length; i++)
            AnimatedBuilder(
              animation: _driftController,
              builder: (context, child) {
                final phase = (i / _chips.length) * 2 * 3.14159;
                final t = _driftController.value * 2 * 3.14159 + phase;
                final dx = math.cos(t * 0.5 + phase) * (s * 0.42);
                final dy = math.sin(t * 0.5 + phase) * (s * 0.30);
                return Transform.translate(
                  offset: Offset(dx, dy - s * 0.02),
                  child: child,
                );
              },
              child: _buildChip(_chips[i]),
            ),
        ],
      ),
    );
  }

  Widget _buildDeviceCard(double s) {
    final w = s * 0.62;
    final h = s * 0.86;

    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: w,
          height: h,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.glass(0.14, widget.isDarkMode),
                AppTheme.glass(0.06, widget.isDarkMode),
              ],
            ),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: AppTheme.glassBorder(0.35, widget.isDarkMode),
              width: 1.2,
            ),
            boxShadow: AppTheme.shadowLg(
              AppTheme.getPrimary(widget.isDarkMode),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Window controls
              Row(
                children: [
                  _dot(AppTheme.error),
                  const SizedBox(width: 6),
                  _dot(AppTheme.warning),
                  const SizedBox(width: 6),
                  _dot(AppTheme.success),
                  const Spacer(),
                  Icon(
                    Icons.flutter_dash,
                    size: 16,
                    color: AppTheme.getPrimary(widget.isDarkMode),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Mock syntax-highlighted code lines
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _codeLine(0.9, AppTheme.darkAccent),
                    _codeLine(0.6, AppTheme.darkPrimary, indent: 1),
                    _codeLine(0.75, AppTheme.getTextSecondary(widget.isDarkMode), indent: 2),
                    _codeLine(0.4, AppTheme.darkTertiary, indent: 2),
                    _codeLine(0.55, AppTheme.darkPrimary, indent: 1),
                    _codeLine(0.3, AppTheme.getTextSecondary(widget.isDarkMode)),
                    _codeLine(0.8, AppTheme.darkAccent),
                    _codeLine(0.5, AppTheme.darkPrimary, indent: 1),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              // Little status pill: "Building..."
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient(widget.isDarkMode),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.bolt_rounded, size: 12, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      'Shipping',
                      style: AppTheme.caption(widget.isDarkMode).copyWith(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dot(Color color) => Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: color.withOpacity(0.85), shape: BoxShape.circle),
      );

  Widget _codeLine(double widthFactor, Color color, {int indent = 0}) {
    return Padding(
      padding: EdgeInsets.only(left: indent * 12, bottom: 2),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: widthFactor.clamp(0.0, 1.0),
        child: Container(
          height: 6,
          decoration: BoxDecoration(
            color: color.withOpacity(widget.isDarkMode ? 0.55 : 0.4),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }

  Widget _buildChip(_TechChip chip) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.glass(0.18, widget.isDarkMode),
                AppTheme.glass(0.08, widget.isDarkMode),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.glassBorder(0.3, widget.isDarkMode),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.getAccent(widget.isDarkMode).withOpacity(0.18),
                blurRadius: 16,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(chip.icon, size: 14, color: AppTheme.getPrimary(widget.isDarkMode)),
              const SizedBox(width: 6),
              Text(
                chip.label,
                style: AppTheme.caption(widget.isDarkMode).copyWith(fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TechChip {
  final String label;
  final IconData icon;
  const _TechChip(this.label, this.icon);
}
