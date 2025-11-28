import 'package:flutter/material.dart';
import 'package:hammad_portfolio/core/utils/responsive.dart';
import '../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String label;
  final String title;
  final String? subtitle;
  final Gradient? gradient;
  final bool isDarkMode;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.subtitle,
    this.gradient,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Column(
      children: [
        // Label badge
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.md,
            vertical: AppTheme.sm,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.glass(0.1, isDarkMode),
                AppTheme.glass(0.05, isDarkMode),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppTheme.glassBorder(0.2, isDarkMode),
              width: 1,
            ),
          ),
          child: Text(
            label.toUpperCase(),
            style: AppTheme.overline(isDarkMode).copyWith(
              color: AppTheme.getTextSecondary(isDarkMode),
            ),
          ),
        ),

        const SizedBox(height: AppTheme.md),

        // Title with gradient
        ShaderMask(
          shaderCallback: (bounds) => (gradient ?? AppTheme.primaryGradient(isDarkMode))
              .createShader(bounds),
          child: Text(
            title,
            style: context.scaleText(
                responsive.isMobile
                    ? AppTheme.displaySmall(isDarkMode)
                    : AppTheme.displayMedium(isDarkMode)
            ),
            textAlign: TextAlign.center,
          ),
        ),

        if (subtitle != null) ...[
          const SizedBox(height: AppTheme.md),
          Text(
            subtitle!,
            style: AppTheme.bodyMedium(isDarkMode).copyWith(
              color: AppTheme.getTextTertiary(isDarkMode),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}