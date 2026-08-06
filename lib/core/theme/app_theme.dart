import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  
  // ============ DARK THEME COLORS — Premium Futuristic Tech ============
  // Cyan + purple duo on a deep navy/black canvas
  static const darkPrimary = Color(0xFF22D3EE);      // electric cyan
  static const darkPrimaryDark = Color(0xFF06B6D4);   // deeper cyan
  static const darkAccent = Color(0xFF8B5CF6);        // violet/purple
  static const darkAccentDark = Color(0xFF7C3AED);    // deeper violet
  static const darkSecondary = Color(0xFF38BDF8);     // sky-cyan (secondary highlight)
  static const darkTertiary = Color(0xFFC084FC);      // soft purple (used sparingly)

  static const darkBackground = Color(0xFF05070D);       // near-black navy canvas
  static const darkBackgroundLight = Color(0xFF0B0F1C);  // slightly lifted navy panel
  static const darkSurface = Color(0xFF141A2E);          // card/surface navy

  static const darkTextPrimary = Color(0xFFF3F6FC);
  static const darkTextSecondary = Color(0xFFAEB9D4);
  static const darkTextTertiary = Color(0xFF7C8AAE);

  // ============ LIGHT THEME COLORS ============
  static const lightPrimary = Color(0xFF0891B2);
  static const lightPrimaryDark = Color(0xFF0E7490);
  static const lightAccent = Color(0xFF7C3AED);
  static const lightAccentDark = Color(0xFF6D28D9);
  static const lightSecondary = Color(0xFF0284C7);
  static const lightTertiary = Color(0xFF9333EA);

  static const lightBackground = Color(0xFFF3F6FB);
  static const lightBackgroundLight = Color(0xFFFFFFFF);
  static const lightSurface = Color(0xFFE4E9F3);

  static const lightTextPrimary = Color(0xFF0B0F1C);
  static const lightTextSecondary = Color(0xFF374151);
  static const lightTextTertiary = Color(0xFF4B5563);

  // Common colors — unchanged
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);

  // Spacing — unchanged
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;

  // Border Radius — unchanged
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 20;
  static const double radiusXxl = 24;

  // ============ TEXT STYLES — unchanged ============
  static TextStyle _baseDisplayLarge(Color color) => GoogleFonts.inter(
    fontSize: 80,
    fontWeight: FontWeight.w900,
    height: 1.1,
    letterSpacing: -2,
    color: color,
  );

  static TextStyle _baseDisplayMedium(Color color) => GoogleFonts.inter(
    fontSize: 56,
    fontWeight: FontWeight.w900,
    height: 1.2,
    letterSpacing: -1.5,
    color: color,
  );

  static TextStyle _baseDisplaySmall(Color color) => GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.w900,
    height: 1.3,
    letterSpacing: -1,
    color: color,
  );

  static TextStyle _baseH1(Color color) => GoogleFonts.inter(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    height: 1.2,
    letterSpacing: -1.2,
    color: color,
  );

  static TextStyle _baseH2(Color color) => GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    height: 1.3,
    letterSpacing: -0.8,
    color: color,
  );

  static TextStyle _baseH3(Color color) => GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: -0.5,
    color: color,
  );

  static TextStyle _baseH4(Color color) => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: -0.3,
    color: color,
  );

  static TextStyle _baseBodyLarge(Color color) => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.8,
    letterSpacing: 0.3,
    color: color,
  );

  static TextStyle _baseBodyMedium(Color color) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.7,
    letterSpacing: 0.3,
    color: color,
  );

  static TextStyle _baseBodySmall(Color color) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6,
    letterSpacing: 0.2,
    color: color,
  );

  static TextStyle _baseButton(Color color) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: color,
  );

  static TextStyle _baseCaption(Color color) => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 1,
    color: color,
  );

  static TextStyle _baseOverline(Color color) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 2,
    color: color,
  );

  // ============ GET TEXT STYLES BY THEME ============
  static TextStyle displayLarge(bool isDark) => _baseDisplayLarge(isDark ? darkTextPrimary : lightTextPrimary);
  static TextStyle displayMedium(bool isDark) => _baseDisplayMedium(isDark ? darkTextPrimary : lightTextPrimary);
  static TextStyle displaySmall(bool isDark) => _baseDisplaySmall(isDark ? darkTextPrimary : lightTextPrimary);
  static TextStyle h1(bool isDark) => _baseH1(isDark ? darkTextPrimary : lightTextPrimary);
  static TextStyle h2(bool isDark) => _baseH2(isDark ? darkTextPrimary : lightTextPrimary);
  static TextStyle h3(bool isDark) => _baseH3(isDark ? darkTextPrimary : lightTextPrimary);
  static TextStyle h4(bool isDark) => _baseH4(isDark ? darkTextPrimary : lightTextPrimary);
  static TextStyle bodyLarge(bool isDark) => _baseBodyLarge(isDark ? darkTextSecondary : lightTextSecondary);
  static TextStyle bodyMedium(bool isDark) => _baseBodyMedium(isDark ? darkTextSecondary : lightTextSecondary);
  static TextStyle bodySmall(bool isDark) => _baseBodySmall(isDark ? darkTextSecondary : lightTextSecondary);
  static TextStyle button(bool isDark) => _baseButton(isDark ? darkTextPrimary : lightTextPrimary);
  static TextStyle caption(bool isDark) => _baseCaption(isDark ? darkTextTertiary : lightTextTertiary);
  static TextStyle overline(bool isDark) => _baseOverline(isDark ? darkTextTertiary : lightTextTertiary);

  // ============ GRADIENTS — unchanged ============
  static LinearGradient primaryGradient(bool isDark) => LinearGradient(
    colors: isDark ? [darkPrimary, darkAccent] : [lightPrimary, lightAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient accentGradient(bool isDark) => LinearGradient(
    colors: isDark ? [darkAccent, darkTertiary] : [lightAccent, lightTertiary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient warmGradient(bool isDark) => LinearGradient(
    colors: isDark ? [darkTertiary, warning] : [lightTertiary, warning],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadows — unchanged
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

  // ============ GLASS EFFECT — Premium glassmorphism ============
  // Dark mode: cool cyan-tinted white glass for a "frosted display" feel.
  // Light mode: white-based glass so cards stay clearly visible.
  static Color glass(double opacity, bool isDark) =>
      isDark
          ? const Color(0xFFCFF4FF).withOpacity(opacity)
          : Colors.white.withOpacity(1 - (opacity * 1.5).clamp(0.0, 0.95));

  // Dark mode border gets a faint cyan tint instead of flat white for a
  // "glowing edge" look; light mode keeps crisp dark borders.
  static Color glassBorder(double opacity, bool isDark) =>
      isDark
          ? const Color(0xFF9AE8FF).withOpacity((opacity * 0.9).clamp(0.0, 1.0))
          : Colors.black.withOpacity((opacity * 1.2).clamp(0.0, 1.0));

  // Project Gradients — kept within the cyan/purple family for a cohesive,
  // premium tech palette (no scattered rainbow accents).
  static List<List<Color>> projectGradients(bool isDark) => isDark ? [
    [darkPrimary, darkAccent],
    [darkAccent, darkTertiary],
    [darkSecondary, darkPrimary],
    [success, darkSecondary],
    [darkTertiary, darkPrimaryDark],
    [darkAccentDark, darkSecondary],
  ] : [
    [lightPrimary, lightAccent],
    [lightAccent, lightTertiary],
    [lightSecondary, lightPrimary],
    [success, lightSecondary],
    [lightTertiary, lightPrimaryDark],
    [lightAccentDark, lightSecondary],
  ];

  static LinearGradient getProjectGradient(int index, bool isDark) {
    final colors = projectGradients(isDark)[index % projectGradients(isDark).length];
    return LinearGradient(
      colors: colors,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  // Get theme colors — unchanged
  static Color getBackground(bool isDark) => isDark ? darkBackground : lightBackground;
  static Color getBackgroundLight(bool isDark) => isDark ? darkBackgroundLight : lightBackgroundLight;
  static Color getSurface(bool isDark) => isDark ? darkSurface : lightSurface;
  static Color getTextPrimary(bool isDark) => isDark ? darkTextPrimary : lightTextPrimary;
  static Color getTextSecondary(bool isDark) => isDark ? darkTextSecondary : lightTextSecondary;
  static Color getTextTertiary(bool isDark) => isDark ? darkTextTertiary : lightTextTertiary;
  static Color getPrimary(bool isDark) => isDark ? darkPrimary : lightPrimary;
  static Color getAccent(bool isDark) => isDark ? darkAccent : lightAccent;
}

// Responsive Text Styles Extension — unchanged
extension ResponsiveTextStyles on BuildContext {
  double get _scaleFactor {
    final width = MediaQuery.of(this).size.width;
    if (width < 640) return 0.75;
    if (width < 768) return 0.85;
    if (width < 1024) return 0.95;
    if (width < 1440) return 1.0;
    return 1.1;
  }

  TextStyle scaleText(TextStyle style) {
    return style.copyWith(
      fontSize: (style.fontSize ?? 16) * _scaleFactor,
    );
  }
}