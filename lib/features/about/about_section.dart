import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hammad_portfolio/core/utils/responsive.dart';
import 'dart:ui';
import '../../core/widgets/section_header.dart';
import '../../core/theme/app_theme.dart';

class AboutSection extends StatefulWidget {
  final bool isDarkMode;

  const AboutSection({
    super.key,
    required this.isDarkMode,
  });

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() => _isVisible = true);
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Container(
      padding: context.responsive.sectionPadding,
      child: Column(
        children: [
          SectionHeader(
            label: 'GET TO KNOW ME',
            title: 'About Me',
            isDarkMode: widget.isDarkMode,
          ),

          const SizedBox(height: 60),

          AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 800),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1100),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.glass(0.1, widget.isDarkMode),
                    AppTheme.glass(0.05, widget.isDarkMode)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                    color: AppTheme.glassBorder(0.2, widget.isDarkMode),
                    width: 1
                ),
                boxShadow: [
                  BoxShadow(
                      color: AppTheme.getPrimary(widget.isDarkMode).withOpacity(0.1),
                      blurRadius: 40,
                      spreadRadius: 5
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Padding(
                    padding: EdgeInsets.all(responsive.isMobile ? 32 : 56),
                    child: responsive.isMobile
                        ? Column(
                      children: [
                        _buildProfileImage(context),
                        const SizedBox(height: 40),
                        _buildStats(),
                        const SizedBox(height: 40),
                        _buildTextContent(responsive),
                        const SizedBox(height: 40),
                        _buildSkillsHighlight(responsive),
                      ],
                    )
                        : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            _buildProfileImage(context),
                            const SizedBox(height: 130),
                            _buildStats(),
                          ],
                        ),
                        const SizedBox(width: 56),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTextContent(responsive),
                              const SizedBox(height: 40),
                              _buildSkillsHighlight(responsive),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1000),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Transform.rotate(
            angle: (1 - value) * 0.5,
            child: child,
          ),
        );
      },
      child: Container(
        width: 220,
        height: 220,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppTheme.primaryGradient(widget.isDarkMode),
          boxShadow: [
            BoxShadow(
                color: AppTheme.getAccent(widget.isDarkMode).withOpacity(0.5),
                blurRadius: 40,
                spreadRadius: 5
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppTheme.getBackgroundLight(widget.isDarkMode),
            border: Border.all(
                color: AppTheme.glassBorder(0.1, widget.isDarkMode),
                width: 2
            ),
          ),
          child: ClipOval(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.getPrimary(widget.isDarkMode).withOpacity(0.3),
                        AppTheme.getAccent(widget.isDarkMode).withOpacity(0.3)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Image.asset('assets/images/profile.png', fit: BoxFit.cover),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextContent(Responsive responsive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TweenAnimationBuilder(
          duration: const Duration(milliseconds: 600),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, double value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: child
              ),
            );
          },
          child: ShaderMask(
            shaderCallback: (bounds) => AppTheme.primaryGradient(widget.isDarkMode)
                .createShader(bounds),
            child: Text(
              'Hello! I\'m Hammad 👋',
              style: TextStyle(
                  fontSize: responsive.isMobile ? 28 : 36,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.getTextPrimary(widget.isDarkMode),
                  letterSpacing: -0.5
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        ..._buildAnimatedParagraphs([
          "I'm a certified Flutter Developer with over two years of professional experience in cross-platform mobile app development. I specialize in building user-friendly, high-performance applications using clean architecture, efficient state management, and Firebase integration. I create modern, pixel-perfect UI/UX designs and write well-structured, maintainable code. I'm currently learning backend technologies to further expand my skill set.",
        ], responsive),
      ],
    );
  }

  Widget _buildStats() {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1000),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
              offset: Offset(0, 30 * (1 - value)),
              child: child
          ),
        );
      },
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          _buildStatCard(context, '15+', 'Projects', FontAwesomeIcons.briefcase),
          _buildStatCard(context, '2+', 'Years', FontAwesomeIcons.solidClock),
          _buildStatCard(context, '100%', 'Satisfaction', FontAwesomeIcons.solidThumbsUp),
        ],
      ),
    );
  }

  List<Widget> _buildAnimatedParagraphs(List<String> paragraphs, Responsive responsive) {
    return paragraphs.asMap().entries.map((entry) {
      return TweenAnimationBuilder(
        duration: Duration(milliseconds: 700 + (entry.key * 200)),
        tween: Tween<double>(begin: 0, end: 1),
        builder: (context, double value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
                offset: Offset(0, 20 * (1 - value)),
                child: child
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            entry.value,
            style: TextStyle(
                fontSize: responsive.isMobile ? 15 : 17,
                color: AppTheme.getTextSecondary(widget.isDarkMode),
                height: 1.8,
                letterSpacing: 0.3
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildStatCard(BuildContext context, String value, String label, IconData icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                AppTheme.getPrimary(widget.isDarkMode).withOpacity(0.3),
                AppTheme.getAccent(widget.isDarkMode).withOpacity(0.3)
              ]
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: AppTheme.glassBorder(0.2, widget.isDarkMode),
              width: 1
          ),
          boxShadow: [
            BoxShadow(
                color: AppTheme.getPrimary(widget.isDarkMode).withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 2
            )
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.getTextPrimary(widget.isDarkMode), size: 24),
            const SizedBox(height: 8),
            Text(
                value,
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.getTextPrimary(widget.isDarkMode),
                    letterSpacing: -0.5
                )
            ),
            const SizedBox(height: 4),
            Text(
                label,
                style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.getTextSecondary(widget.isDarkMode),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsHighlight(Responsive responsive) {
    final skills = [
      {'label': 'Flutter & Dart', 'icon': 'assets/svg/flutter.svg'},
      {'label': '🔥 Firebase', 'icon': null},
      {'label': '🏗️ Clean Architecture', 'icon': null},
      {'label': '⚡ GetX', 'icon': null},
      {'label': '🎨 UI/UX Design', 'icon': null},
      {'label': '📱 Cross-Platform', 'icon': null},
    ];

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1200),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(opacity: value, child: child);
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                AppTheme.glass(0.05, widget.isDarkMode),
                AppTheme.glass(0.02, widget.isDarkMode)
              ]
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: AppTheme.glassBorder(0.1, widget.isDarkMode),
              width: 1
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient(widget.isDarkMode),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Icon(
                      Icons.code_rounded,
                      color: AppTheme.getTextPrimary(widget.isDarkMode),
                      size: 20
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                    'Core Expertise',
                    style: TextStyle(
                        fontSize: responsive.isMobile ? 16 : 18,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.getTextPrimary(widget.isDarkMode)
                    )
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: skills.map((item) {
                final String? label = item['label'];
                final String? iconPath = item['icon'];

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.glass(0.1, widget.isDarkMode),
                        AppTheme.glass(0.05, widget.isDarkMode)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: AppTheme.glassBorder(0.2, widget.isDarkMode),
                        width: 1
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (iconPath != null)
                        SvgPicture.asset(iconPath, width: 15, height: 15),
                      if (iconPath != null) const SizedBox(width: 8),
                      Text(
                        label.toString(),
                        style: TextStyle(
                          color: AppTheme.getTextSecondary(widget.isDarkMode),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}