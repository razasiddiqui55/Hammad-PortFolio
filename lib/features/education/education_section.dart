import 'package:flutter/material.dart';
import 'dart:ui';
import '../../core/utils/responsive.dart';
import '../../core/widgets/section_header.dart';
import '../../core/theme/app_theme.dart';

class EducationSection extends StatefulWidget {
  final bool isDarkMode;

  const EducationSection({
    super.key,
    required this.isDarkMode,
  });

  @override
  State<EducationSection> createState() => _EducationSectionState();
}

class _EducationSectionState extends State<EducationSection> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() => _isVisible = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Container(
      padding: context.responsive.sectionPadding,
      child: Column(
        children: [
          SectionHeader(
            label: 'Academic Background',
            title: 'Education',
            isDarkMode: widget.isDarkMode,
          ),

          const SizedBox(height: 60),

          Center(
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 800),
              tween: Tween<double>(begin: 0, end: _isVisible ? 1 : 0),
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 30 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Container(
                constraints: const BoxConstraints(maxWidth: 900),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.glass(0.1, widget.isDarkMode),
                      AppTheme.glass(0.05, widget.isDarkMode),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppTheme.glassBorder(0.2, widget.isDarkMode),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.getPrimary(widget.isDarkMode).withOpacity(0.1),
                      blurRadius: 40,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Padding(
                      padding: EdgeInsets.all(responsive.isMobile ? 32 : 48),
                      child: responsive.isMobile
                          ? Column(
                        children: [
                          _buildEducationIcon(),
                          const SizedBox(height: 32),
                          _buildEducationContent(responsive),
                        ],
                      )
                          : Row(
                        children: [
                          _buildEducationIcon(),
                          const SizedBox(width: 48),
                          Expanded(child: _buildEducationContent(responsive)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 60),

          TweenAnimationBuilder(
            duration: const Duration(milliseconds: 1000),
            tween: Tween<double>(begin: 0, end: _isVisible ? 1 : 0),
            builder: (context, double value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 40 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: _buildAchievementsSection(responsive),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationIcon() {
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
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppTheme.primaryGradient(widget.isDarkMode),
          boxShadow: [
            BoxShadow(
              color: AppTheme.getAccent(widget.isDarkMode).withOpacity(0.5),
              blurRadius: 40,
              spreadRadius: 5,
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
              width: 2,
            ),
          ),
          child: Icon(
            Icons.school_rounded,
            size: 60,
            color: AppTheme.getTextPrimary(widget.isDarkMode),
          ),
        ),
      ),
    );
  }

  Widget _buildEducationContent(Responsive responsive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => AppTheme.primaryGradient(widget.isDarkMode).createShader(bounds),
          child: Text(
            'Bahauddin Zakariya University',
            style: TextStyle(
              fontSize: responsive.isMobile ? 24 : 32,
              fontWeight: FontWeight.w800,
              color: AppTheme.getTextPrimary(widget.isDarkMode),
              letterSpacing: -0.5,
            ),
          ),
        ),

        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient(widget.isDarkMode),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppTheme.getPrimary(widget.isDarkMode).withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.emoji_events_rounded,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Bachelor\'s Degree',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: responsive.isMobile ? 15 : 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        _buildInfoRow(
          Icons.location_on_rounded,
          'Multan, Punjab, Pakistan',
          responsive,
        ),

        const SizedBox(height: 16),

        _buildInfoRow(
          Icons.code_rounded,
          'Computer Science & Software Engineering',
          responsive,
        ),

        const SizedBox(height: 24),

        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.glass(0.05, widget.isDarkMode),
                AppTheme.glass(0.02, widget.isDarkMode),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.glassBorder(0.1, widget.isDarkMode),
              width: 1,
            ),
          ),
          child: Text(
            'Developed a strong foundation in computer science principles, software engineering practices, and modern development methodologies. Gained extensive knowledge in algorithms, data structures, and system design.',
            style: TextStyle(
              fontSize: responsive.isMobile ? 14 : 16,
              color: AppTheme.getTextSecondary(widget.isDarkMode),
              height: 1.7,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Responsive responsive) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.glass(0.1, widget.isDarkMode),
                AppTheme.glass(0.05, widget.isDarkMode),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppTheme.glassBorder(0.2, widget.isDarkMode),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: AppTheme.getTextSecondary(widget.isDarkMode),
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: responsive.isMobile ? 15 : 17,
              color: AppTheme.getTextPrimary(widget.isDarkMode),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementsSection(Responsive responsive) {
    final achievements = [
      {
        'icon': Icons.military_tech_rounded,
        'title': 'Academic Excellence',
        'description': 'Consistent high performance',
      },
      {
        'icon': Icons.groups_rounded,
        'title': 'Team Projects',
        'description': 'Collaborative development',
      },
      {
        'icon': Icons.lightbulb_rounded,
        'title': 'Innovation',
        'description': 'Creative problem solving',
      },
    ];

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: achievements.map((achievement) {
        return _buildAchievementCard(
          achievement['icon'] as IconData,
          achievement['title'] as String,
          achievement['description'] as String,
          responsive,
        );
      }).toList(),
    );
  }

  Widget _buildAchievementCard(
      IconData icon,
      String title,
      String description,
      Responsive responsive,
      ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        width: responsive.isMobile ? double.infinity : 260,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.glass(0.1, widget.isDarkMode),
              AppTheme.glass(0.05, widget.isDarkMode),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.glassBorder(0.2, widget.isDarkMode),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient(widget.isDarkMode),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.getPrimary(widget.isDarkMode).withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppTheme.getTextPrimary(widget.isDarkMode),
                letterSpacing: -0.3,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.getTextSecondary(widget.isDarkMode),
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}