import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop, largeDesktop }

class Responsive {
  final BuildContext context;

  Responsive(this.context);

  // Breakpoints
  static const double mobileBreakpoint = 640;
  static const double tabletBreakpoint = 768;
  static const double desktopBreakpoint = 1024;
  static const double largeDesktopBreakpoint = 1440;

  // Screen dimensions
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
  double get shortestSide => MediaQuery.of(context).size.shortestSide;

  // Device type detection
  DeviceType get deviceType {
    if (width >= largeDesktopBreakpoint) return DeviceType.largeDesktop;
    if (width >= desktopBreakpoint) return DeviceType.desktop;
    if (width >= tabletBreakpoint) return DeviceType.tablet;
    return DeviceType.mobile;
  }

  bool get isMobile => deviceType == DeviceType.mobile;
  bool get isTablet => deviceType == DeviceType.tablet;
  bool get isDesktop => deviceType == DeviceType.desktop;
  bool get isLargeDesktop => deviceType == DeviceType.largeDesktop;

  // Percentage based sizing
  double wp(double percent) => width * (percent / 100);
  double hp(double percent) => height * (percent / 100);
  double sp(double percent) => shortestSide * (percent / 100);

  // Responsive sizing with device scaling
  double size(double baseSize) {
    switch (deviceType) {
      case DeviceType.mobile:
        return baseSize * 0.85;
      case DeviceType.tablet:
        return baseSize * 0.95;
      case DeviceType.desktop:
        return baseSize;
      case DeviceType.largeDesktop:
        return baseSize * 1.1;
    }
  }

  // Grid columns
  int get gridColumns {
    switch (deviceType) {
      case DeviceType.mobile:
        return 1;
      case DeviceType.tablet:
        return 2;
      case DeviceType.desktop:
        return 3;
      case DeviceType.largeDesktop:
        return 4;
    }
  }

  // Content max width
  double get contentMaxWidth {
    switch (deviceType) {
      case DeviceType.mobile:
        return double.infinity;
      case DeviceType.tablet:
        return 720;
      case DeviceType.desktop:
        return 1200;
      case DeviceType.largeDesktop:
        return 1440;
    }
  }

  // Responsive padding
  EdgeInsets get pagePadding {
    final horizontal = isMobile ? 16.0 : (isTablet ? 24.0 : 32.0);
    final vertical = isMobile ? 16.0 : (isTablet ? 24.0 : 32.0);
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  EdgeInsets get sectionPadding {
    final horizontal = isMobile ? 16.0 : (isTablet ? 32.0 : 48.0);
    final vertical = isMobile ? 32.0 : (isTablet ? 40.0 : 48.0);
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  // Responsive value selector
  T value<T>({
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    switch (deviceType) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile;
      case DeviceType.desktop:
        return desktop ?? tablet ?? mobile;
      case DeviceType.largeDesktop:
        return largeDesktop ?? desktop ?? tablet ?? mobile;
    }
  }
}

// Extension for easy access
extension ResponsiveContext on BuildContext {
  Responsive get responsive => Responsive(this);
}