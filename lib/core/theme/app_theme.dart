import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const primary = Color(0xFF6366F1);
  static const primaryDark = Color(0xFF4F46E5);
  static const accent = Color(0xFFA855F7);
  static const accentDark = Color(0xFF9333EA);
  static const secondary = Color(0xFF06B6D4);
  static const tertiary = Color(0xFFEC4899);
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);

  static const background = Color(0xFF0F172A);
  static const backgroundLight = Color(0xFF1E293B);
  static const surface = Color(0xFF334155);

  static const textPrimary = Color(0xFFF8FAFC);
  static const textSecondary = Color(0xFFCBD5E1);
  static const textTertiary = Color(0xFF94A3B8);

  // Gradients
  static const primaryGradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const accentGradient = LinearGradient(
    colors: [accent, tertiary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const warmGradient = LinearGradient(
    colors: [tertiary, warning],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Spacing
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;

  // Border Radius
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 20;
  static const double radiusXxl = 24;

  // Text Styles
  static TextStyle displayLarge = GoogleFonts.inter(
    fontSize: 80,
    fontWeight: FontWeight.w900,
    height: 1.1,
    letterSpacing: -2,
    color: textPrimary,
  );

  static TextStyle displayMedium = GoogleFonts.inter(
    fontSize: 56,
    fontWeight: FontWeight.w900,
    height: 1.2,
    letterSpacing: -1.5,
    color: textPrimary,
  );

  static TextStyle displaySmall = GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.w900,
    height: 1.3,
    letterSpacing: -1,
    color: textPrimary,
  );

  static TextStyle h1 = GoogleFonts.inter(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    height: 1.2,
    letterSpacing: -1.2,
    color: textPrimary,
  );

  static TextStyle h2 = GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    height: 1.3,
    letterSpacing: -0.8,
    color: textPrimary,
  );

  static TextStyle h3 = GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: -0.5,
    color: textPrimary,
  );

  static TextStyle h4 = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: -0.3,
    color: textPrimary,
  );

  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.8,
    letterSpacing: 0.3,
    color: textSecondary,
  );

  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.7,
    letterSpacing: 0.3,
    color: textSecondary,
  );

  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6,
    letterSpacing: 0.2,
    color: textSecondary,
  );

  static TextStyle button = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: textPrimary,
  );

  static TextStyle caption = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 1,
    color: textTertiary,
  );

  static TextStyle overline = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 2,
    color: textTertiary,
  );

  // Shadows
  static List<BoxShadow> shadowSm(Color color) => [
    BoxShadow(
      color: color.withOpacity(0.1),
      blurRadius: 10,
      spreadRadius: 1,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> shadowMd(Color color) => [
    BoxShadow(
      color: color.withOpacity(0.2),
      blurRadius: 20,
      spreadRadius: 2,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> shadowLg(Color color) => [
    BoxShadow(
      color: color.withOpacity(0.3),
      blurRadius: 40,
      spreadRadius: 5,
      offset: const Offset(0, 8),
    ),
  ];

  // Glass Effect Colors
  static Color glass(double opacity) => Colors.white.withOpacity(opacity);
  static Color glassBorder(double opacity) => Colors.white.withOpacity(opacity);

  // Gradient Helpers
  static List<List<Color>> projectGradients = [
    [primary, accent],
    [accent, tertiary],
    [tertiary, warning],
    [success, secondary],
    [secondary, primary],
    [warning, error],
  ];

  static LinearGradient getProjectGradient(int index) {
    final colors = projectGradients[index % projectGradients.length];
    return LinearGradient(
      colors: colors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
}

// Responsive Text Styles Extension
extension ResponsiveTextStyles on BuildContext {
  double get _scaleFactor {
    final width = MediaQuery.of(this).size.width;
    if (width < 640) return 0.85;
    if (width < 768) return 0.95;
    if (width < 1024) return 1.0;
    if (width < 1440) return 1.1;
    return 1.2;
  }

  TextStyle scaleText(TextStyle style) {
    return style.copyWith(
      fontSize: (style.fontSize ?? 16) * _scaleFactor,
    );
  }
}