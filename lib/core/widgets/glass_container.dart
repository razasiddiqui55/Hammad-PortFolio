import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double blur;
  final double opacity;
  final Gradient? gradient;
  final Color? borderColor;
  final double borderWidth;
  final List<BoxShadow>? boxShadow;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius = AppTheme.radiusXxl,
    this.blur = 20,
    this.opacity = 0.1,
    this.gradient,
    this.borderColor,
    this.borderWidth = 1,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        gradient: gradient ?? LinearGradient(
          colors: [
            AppTheme.glass(opacity),
            AppTheme.glass(opacity * 0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? AppTheme.glassBorder(0.2),
          width: borderWidth,
        ),
        boxShadow: boxShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(AppTheme.lg),
            child: child,
          ),
        ),
      ),
    );
  }
}