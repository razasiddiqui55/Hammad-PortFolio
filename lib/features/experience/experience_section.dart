import 'package:flutter/material.dart';
import 'dart:ui';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/glass_container.dart';
import '../../data/models/experience_model.dart';


class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
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
    final experiences = ExperienceModel.getExperiences();
    final responsive = Responsive(context);

    return Container(
      padding: context.responsive.sectionPadding,
      child: Column(
        children: [
          // Animated section header
          const SectionHeader(
            label: "My Journey",
            title: "Professional Experience",
            subtitle: "Explore my career path and key milestones achieved along the way.",
          ),

          const SizedBox(height: 60),

          // Experience cards in a clean grid/column layout
          if (responsive.isMobile)
            _buildMobileLayout(experiences)
          else
            _buildDesktopLayout(experiences),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(List<ExperienceModel> experiences) {
    return Column(
      children: experiences.asMap().entries.map((entry) {
        return _buildExperienceCard(
          entry.value,
          entry.key,
        );
      }).toList(),
    );
  }

  Widget _buildDesktopLayout(List<ExperienceModel> experiences) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          children: experiences.asMap().entries.map((entry) {
            return _buildExperienceCard(
              entry.value,
              entry.key,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildExperienceCard(ExperienceModel experience, int index) {
    final colors = [
      [const Color(0xFF2563EB), const Color(0xFF9333EA)],
      [const Color(0xFF9333EA), const Color(0xFFEC4899)],
      [const Color(0xFFEC4899), const Color(0xFFF59E0B)],
      [const Color(0xFF10B981), const Color(0xFF06B6D4)],
    ];

    final colorPair = colors[index % colors.length];

    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 600 + (index * 150)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: _AnimatedExperienceCard(
        colorPair: colorPair,
        experience: experience,
        index: index,
      ),
    );
  }
}

class _AnimatedExperienceCard extends StatefulWidget {
  final List<Color> colorPair;
  final ExperienceModel experience;
  final int index;

  const _AnimatedExperienceCard({
    required this.colorPair,
    required this.experience,
    required this.index,
  });

  @override
  State<_AnimatedExperienceCard> createState() => _AnimatedExperienceCardState();
}

class _AnimatedExperienceCardState extends State<_AnimatedExperienceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -12.0 : 0.0)
          ..scale(_isHovered ? 1.02 : 1.0),
        margin: const EdgeInsets.only(bottom: 32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withValues(alpha:0.1),
              Colors.white.withValues(alpha:0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withValues(alpha:0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.colorPair[0].withValues(alpha:0.15),
              blurRadius: 30,
              spreadRadius: 3,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Column(
              children: [
                // Header section with gradient accent
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        widget.colorPair[0].withValues(alpha:0.1),
                        widget.colorPair[1].withValues(alpha:0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white.withValues(alpha:0.1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Gradient icon
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: widget.colorPair,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: widget.colorPair[0].withValues(alpha:0.3),
                                  blurRadius: 12,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.code_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Role title
                                Text(
                                  widget.experience.title,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Company
                                Row(
                                  children: [
                                    Icon(
                                      Icons.business_rounded,
                                      color: Colors.white.withValues(alpha:0.7),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      widget.experience.company,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withValues(alpha:0.8),
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Period badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: widget.colorPair,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: widget.colorPair[0].withValues(alpha:0.3),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.calendar_today_rounded,
                              color: Colors.white,
                              size: 14,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              widget.experience.period,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Content section
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Description
                      Text(
                        widget.experience.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withValues(alpha:0.75),
                          height: 1.8,
                          letterSpacing: 0.3,
                        ),
                      ),

                      if (widget.experience.achievements.isNotEmpty) ...[
                        const SizedBox(height: 28),

                        // Achievements section
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.amber.withValues(alpha:0.2),
                                    Colors.amber.withValues(alpha:0.1),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.emoji_events_rounded,
                                color: Colors.amber.shade400,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Key Achievements',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white.withValues(alpha:0.9),
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Achievement items
                        ...widget.experience.achievements.map((achievement) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: widget.colorPair,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Icon(
                                    Icons.check_rounded,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    achievement,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white.withValues(alpha:0.7),
                                      height: 1.7,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
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
}