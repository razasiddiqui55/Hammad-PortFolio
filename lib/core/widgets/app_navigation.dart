import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import 'dart:ui';

class AppNavigation extends StatefulWidget {
  final String activeSection;
  final Function(int) onNavigate;
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const AppNavigation({
    super.key,
    required this.activeSection,
    required this.onNavigate,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  bool _isMobileMenuOpen = false;

  final List<NavItem> _navItems = const [
    NavItem(id: 'about', label: 'Overview', index: 1),
    NavItem(id: 'education', label: 'Education', index: 2),
    NavItem(id: 'experience', label: 'Experience', index: 3),
    NavItem(id: 'skills', label: 'Skills', index: 4),
    NavItem(id: 'projects', label: 'Projects', index: 5),
    NavItem(id: 'contact', label: 'Contact', index: 6),
  ];

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Positioned(
      top: 20,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: responsive.isMobile
                ? MediaQuery.of(context).size.width - 32
                : 900,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: responsive.isMobile ? 16 : 0,
          ),
          child: Stack(
            children: [
              _buildNavBar(context, responsive),
              if (_isMobileMenuOpen && responsive.isMobile)
                _buildMobileMenu(context, responsive),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavBar(BuildContext context, Responsive responsive) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.glass(0.15, widget.isDarkMode),
                AppTheme.glass(0.08, widget.isDarkMode),
              ],
            ),
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            border: Border.all(
              color: AppTheme.glassBorder(0.2, widget.isDarkMode),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: (widget.isDarkMode ? Colors.black : Colors.grey)
                    .withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: responsive.isMobile ? 16 : 24,
              vertical: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLogo(),
                if (!responsive.isMobile && !responsive.isTablet)
                  _buildDesktopNav(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildThemeToggle(),
                    if (!responsive.isMobile) ...[
                      const SizedBox(width: 12),
                      _buildSocialIcons(),
                    ],
                    if (responsive.isMobile || responsive.isTablet) ...[
                      const SizedBox(width: 12),
                      _buildMobileMenuButton(),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return InkWell(
      onTap: () => widget.onNavigate(0),
      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: ShaderMask(
          shaderCallback: (bounds) =>
              AppTheme.primaryGradient(widget.isDarkMode).createShader(bounds),
          child: Text(
            'HS',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppTheme.getTextPrimary(widget.isDarkMode),
              letterSpacing: -1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle() {
    return InkWell(
      onTap: widget.onThemeToggle,
      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.glass(0.15, widget.isDarkMode),
              AppTheme.glass(0.05, widget.isDarkMode),
            ],
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
          border: Border.all(
            color: AppTheme.glassBorder(0.2, widget.isDarkMode),
            width: 1,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return RotationTransition(
              turns: animation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: Icon(
            widget.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            key: ValueKey(widget.isDarkMode),
            size: 20,
            color: AppTheme.getTextPrimary(widget.isDarkMode),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopNav() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _navItems.map((item) {
        final isActive = widget.activeSection == item.id;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: InkWell(
            onTap: () => widget.onNavigate(item.index),
            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 14,
              ),
              decoration: BoxDecoration(
                gradient: isActive
                    ? AppTheme.primaryGradient(widget.isDarkMode)
                    : null,
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              ),
              child: Text(
                item.label,
                style: AppTheme.caption(widget.isDarkMode).copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isActive
                      ? AppTheme.darkTextPrimary
                      : AppTheme.getTextSecondary(widget.isDarkMode),
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSocialIcon(
          FontAwesomeIcons.github,
          'https://github.com/razasiddiqui55',
        ),
        const SizedBox(width: 8),
        _buildSocialIcon(
          FontAwesomeIcons.linkedin,
          'https://www.linkedin.com/in/hammad-siddiqui-75a124271/',
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.glass(0.15, widget.isDarkMode),
              AppTheme.glass(0.05, widget.isDarkMode),
            ],
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
          border: Border.all(
            color: AppTheme.glassBorder(0.2, widget.isDarkMode),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          size: 16,
          color: AppTheme.getTextPrimary(widget.isDarkMode),
        ),
      ),
    );
  }

  Widget _buildMobileMenuButton() {
    return InkWell(
      onTap: () => setState(() => _isMobileMenuOpen = !_isMobileMenuOpen),
      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.glass(0.15, widget.isDarkMode),
              AppTheme.glass(0.05, widget.isDarkMode),
            ],
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
          border: Border.all(
            color: AppTheme.glassBorder(0.2, widget.isDarkMode),
            width: 1,
          ),
        ),
        child: Icon(
          _isMobileMenuOpen ? Icons.close_rounded : Icons.menu_rounded,
          size: 24,
          color: AppTheme.getTextPrimary(widget.isDarkMode),
        ),
      ),
    );
  }

  Widget _buildMobileMenu(BuildContext context, Responsive responsive) {
    return Positioned(
      top: 72,
      left: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.glass(0.15, widget.isDarkMode),
                  AppTheme.glass(0.08, widget.isDarkMode),
                ],
              ),
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              border: Border.all(
                color: AppTheme.glassBorder(0.2, widget.isDarkMode),
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ..._navItems.map((item) {
                  final isActive = widget.activeSection == item.id;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      onTap: () {
                        widget.onNavigate(item.index);
                        setState(() => _isMobileMenuOpen = false);
                      },
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          gradient: isActive
                              ? AppTheme.primaryGradient(widget.isDarkMode)
                              : null,
                          color: isActive
                              ? null
                              : AppTheme.glass(0.05, widget.isDarkMode),
                          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                        ),
                        child: Row(
                          children: [
                            Text(
                              item.label,
                              style: AppTheme.bodyMedium(widget.isDarkMode).copyWith(
                                fontWeight: FontWeight.w600,
                                color: isActive
                                    ? AppTheme.darkTextPrimary
                                    : AppTheme.getTextSecondary(widget.isDarkMode),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppTheme.glassBorder(0.1, widget.isDarkMode),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildMobileSocialButton(
                          FontAwesomeIcons.github,
                          'GitHub',
                          'https://github.com/razasiddiqui55',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMobileSocialButton(
                          FontAwesomeIcons.linkedin,
                          'LinkedIn',
                          'https://www.linkedin.com/in/hammad-siddiqui-75a124271/',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileSocialButton(IconData icon, String label, String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.glass(0.1, widget.isDarkMode),
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(
            color: AppTheme.glassBorder(0.2, widget.isDarkMode),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: AppTheme.getTextPrimary(widget.isDarkMode)),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTheme.bodySmall(widget.isDarkMode).copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class NavItem {
  final String id;
  final String label;
  final int index;

  const NavItem({
    required this.id,
    required this.label,
    required this.index,
  });
}