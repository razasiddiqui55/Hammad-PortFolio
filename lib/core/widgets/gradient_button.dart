import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GradientButton extends StatefulWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isPrimary;
  final double? width;
  final bool isDarkMode;

  const GradientButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.isPrimary = true,
    this.width,
    required this.isDarkMode,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width,
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.xl,
            vertical: AppTheme.md,
          ),
          decoration: BoxDecoration(
            gradient: widget.isPrimary
                ? AppTheme.primaryGradient(widget.isDarkMode)
                : LinearGradient(
              colors: [
                AppTheme.glass(0.1, widget.isDarkMode),
                AppTheme.glass(0.05, widget.isDarkMode),
              ],
            ),
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            border: widget.isPrimary
                ? null
                : Border.all(
              color: AppTheme.glassBorder(0.2, widget.isDarkMode),
              width: 1,
            ),
            boxShadow: widget.isPrimary && _isHovered
                ? AppTheme.shadowMd(AppTheme.getPrimary(widget.isDarkMode))
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  color: widget.isPrimary
                      ? Colors.white
                      : AppTheme.getTextPrimary(widget.isDarkMode),
                  size: 18,
                ),
                const SizedBox(width: AppTheme.sm),
              ],
              Text(
                widget.text,
                style: AppTheme.button(widget.isDarkMode).copyWith(
                  color: widget.isPrimary
                      ? Colors.white
                      : AppTheme.getTextPrimary(widget.isDarkMode),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}