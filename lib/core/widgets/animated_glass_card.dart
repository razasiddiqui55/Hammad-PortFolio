import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'glass_container.dart';

class AnimatedGlassCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final List<Color>? gradientColors;

  const AnimatedGlassCard({
    super.key,
    required this.child,
    this.onTap,
    this.width,
    this.height,
    this.padding,
    this.borderRadius = AppTheme.radiusXxl,
    this.gradientColors,
  });

  @override
  State<AnimatedGlassCard> createState() => _AnimatedGlassCardState();
}

class _AnimatedGlassCardState extends State<AnimatedGlassCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()
            ..translate(0.0, _isHovered ? -8.0 : 0.0)
            ..scale(_isHovered ? 1.02 : 1.0),
          child: GlassContainer(
            width: widget.width,
            height: widget.height,
            padding: widget.padding,
            borderRadius: widget.borderRadius,
            opacity: _isHovered ? 0.15 : 0.1,
            borderColor: AppTheme.glassBorder(_isHovered ? 0.3 : 0.2),
            boxShadow: _isHovered ? AppTheme.shadowLg(
                widget.gradientColors?.first ?? AppTheme.primary
            ) : null,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}