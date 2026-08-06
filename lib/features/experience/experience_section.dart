import 'package:flutter/material.dart';
import 'dart:ui';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/section_header.dart';
import '../../data/models/experience_model.dart';

class ExperienceSection extends StatefulWidget {
  final bool isDarkMode;

  const ExperienceSection({
    super.key,
    required this.isDarkMode,
  });

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
          SectionHeader(
            label: "My Journey",
            title: "Professional Experience",
            subtitle:
                "Explore my career path and key milestones achieved along the way.",
            isDarkMode: widget.isDarkMode,
          ),
          const SizedBox(height: 60),
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
        return _buildTimelineRow(
          entry.value,
          entry.key,
          experiences.length,
          compact: true,
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
            return _buildTimelineRow(
              entry.value,
              entry.key,
              experiences.length,
            );
          }).toList(),
        ),
      ),
    );
  }

  // Wraps each card with a vertical timeline rail: a glowing dot for
  // "now/then" plus a connecting line down to the next entry.
  Widget _buildTimelineRow(
    ExperienceModel experience,
    int index,
    int total, {
    bool compact = false,
  }) {
    final colorPair = _colorPairFor(index);
    final isLast = index == total - 1;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: compact ? 28 : 40,
            child: Column(
              children: [
                const SizedBox(height: 36),
                _TimelineDot(
                    colorPair: colorPair, isDarkMode: widget.isDarkMode),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            colorPair[0].withOpacity(0.5),
                            AppTheme.glassBorder(0.15, widget.isDarkMode),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: compact ? 12 : 20),
          Expanded(
            child: _buildExperienceCard(experience, index, colorPair),
          ),
        ],
      ),
    );
  }

  List<Color> _colorPairFor(int index) {
    final colors = widget.isDarkMode
        ? [
            [AppTheme.darkPrimary, AppTheme.darkAccent],
            [AppTheme.darkAccent, AppTheme.darkTertiary],
            [AppTheme.darkSecondary, AppTheme.darkPrimary],
            [AppTheme.success, AppTheme.darkSecondary],
          ]
        : [
            [AppTheme.lightPrimary, AppTheme.lightAccent],
            [AppTheme.lightAccent, AppTheme.lightTertiary],
            [AppTheme.lightSecondary, AppTheme.lightPrimary],
            [AppTheme.success, AppTheme.lightSecondary],
          ];
    return colors[index % colors.length];
  }

  Widget _buildExperienceCard(
      ExperienceModel experience, int index, List<Color> colorPair) {
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
        isDarkMode: widget.isDarkMode,
      ),
    );
  }
}

/// A small pulsing glow dot used as the timeline indicator.
class _TimelineDot extends StatefulWidget {
  final List<Color> colorPair;
  final bool isDarkMode;

  const _TimelineDot({required this.colorPair, required this.isDarkMode});

  @override
  State<_TimelineDot> createState() => _TimelineDotState();
}

class _TimelineDotState extends State<_TimelineDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final glow = 0.25 + (_pulseController.value * 0.35);
        return Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: widget.colorPair),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.getBackground(widget.isDarkMode),
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.colorPair[0].withOpacity(glow),
                blurRadius: 14,
                spreadRadius: 3,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AnimatedExperienceCard extends StatefulWidget {
  final List<Color> colorPair;
  final ExperienceModel experience;
  final int index;
  final bool isDarkMode;

  const _AnimatedExperienceCard({
    required this.colorPair,
    required this.experience,
    required this.index,
    required this.isDarkMode,
  });

  @override
  State<_AnimatedExperienceCard> createState() =>
      _AnimatedExperienceCardState();
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
              color: widget.colorPair[0].withOpacity(0.15),
              blurRadius: 30,
              spreadRadius: 3,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(color: Colors.transparent),
                ),
              ),
              Column(
                children: [
                  // Header section
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          widget.colorPair[0]
                              .withOpacity(widget.isDarkMode ? 0.1 : 0.08),
                          widget.colorPair[1]
                              .withOpacity(widget.isDarkMode ? 0.05 : 0.04),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border(
                        bottom: BorderSide(
                          color: AppTheme.glassBorder(0.1, widget.isDarkMode),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: widget.colorPair,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: widget.colorPair[0].withOpacity(0.3),
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
                                  Text(
                                    widget.experience.title,
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w800,
                                      color: AppTheme.getTextPrimary(
                                          widget.isDarkMode),
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.business_rounded,
                                        color: AppTheme.getTextSecondary(
                                            widget.isDarkMode),
                                        size: 16,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        widget.experience.company,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.getTextSecondary(
                                              widget.isDarkMode),
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
                                color: widget.colorPair[0].withOpacity(0.3),
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
                        Text(
                          widget.experience.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppTheme.getTextSecondary(widget.isDarkMode),
                            height: 1.8,
                            letterSpacing: 0.3,
                          ),
                        ),
                        if (widget.experience.achievements.isNotEmpty) ...[
                          const SizedBox(height: 28),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.amber.withOpacity(0.2),
                                      Colors.amber.withOpacity(0.1),
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
                                  color: AppTheme.getTextPrimary(
                                      widget.isDarkMode),
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
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
                                        color: AppTheme.getTextSecondary(
                                            widget.isDarkMode),
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
            ],
          ),
        ),
      ),
    );
  }
}
