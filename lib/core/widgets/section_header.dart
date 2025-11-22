import 'package:flutter/material.dart';
import 'package:hammad_portfolio/core/utils/responsive.dart';

import '../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String label;
  final String title;
  final String? subtitle;
  final Gradient? gradient;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.subtitle,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Column(
      children: [
        // Label badge
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.md,
            vertical: AppTheme.sm,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.glass(0.1),
                AppTheme.glass(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppTheme.glassBorder(0.2),
              width: 1,
            ),
          ),
          child: Text(
            label.toUpperCase(),
            style: AppTheme.overline.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
        ),

        const SizedBox(height: AppTheme.md),

        // Title with gradient
        ShaderMask(
          shaderCallback: (bounds) => (gradient ?? AppTheme.primaryGradient)
              .createShader(bounds),
          child: Text(
            title,
            style: context.scaleText(
                responsive.isMobile ? AppTheme.displaySmall : AppTheme.displayMedium
            ),
            textAlign: TextAlign.center,
          ),
        ),

        if (subtitle != null) ...[
          const SizedBox(height: AppTheme.md),
          Text(
            subtitle!,
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textTertiary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}