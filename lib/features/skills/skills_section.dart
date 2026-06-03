import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui';
import '../../core/utils/responsive.dart';
import '../../core/widgets/section_header.dart';
import '../../data/models/skill_model.dart';
import '../../core/theme/app_theme.dart';

class SkillsSection extends StatefulWidget {
  final bool isDarkMode;

  const SkillsSection({
    super.key,
    required this.isDarkMode,
  });

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> with TickerProviderStateMixin {
  bool _isVisible = false;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() => _isVisible = true);
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final skills = SkillModel.getSkills();
    final techStack = TechStack.getTechStack();
    final responsive = Responsive(context);

    return Container(
      padding: context.responsive.sectionPadding,
      child: Column(
        children: [
          SectionHeader(
            label: 'What I Do Best',
            title: 'Technical Skills',
            isDarkMode: widget.isDarkMode,
          ),

          const SizedBox(height: 60),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: responsive.isMobile ? 1 : 2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: responsive.isMobile ? 2.5 : 3,
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              return _AnimatedSkillCard(
                skill: skills[index],
                index: index,
                isVisible: _isVisible,
                isDarkMode: widget.isDarkMode,
              );
            },
          ),

          const SizedBox(height: 100),

          AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 800),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              AppTheme.glassBorder(0.3, widget.isDarkMode),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(
                        Icons.code_rounded,
                        color: AppTheme.getTextSecondary(widget.isDarkMode),
                        size: 24,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.glassBorder(0.3, widget.isDarkMode),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                ShaderMask(
                  shaderCallback: (bounds) => AppTheme.primaryGradient(widget.isDarkMode)
                      .createShader(bounds),
                  child: Text(
                    'Tech Stack I Love',
                    style: TextStyle(
                      fontSize: responsive.isMobile ? 28 : 40,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.getTextPrimary(widget.isDarkMode),
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'Technologies I work with daily',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.getTextSecondary(widget.isDarkMode),
                    letterSpacing: 0.3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: responsive.isMobile ? 3 : (responsive.isTablet ? 4 : 6),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1,
            ),
            itemCount: techStack.length,
            itemBuilder: (context, index) {
              return _AnimatedTechCard(
                tech: techStack[index],
                index: index,
                isVisible: _isVisible,
                isDarkMode: widget.isDarkMode,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AnimatedSkillCard extends StatefulWidget {
  final SkillModel skill;
  final int index;
  final bool isVisible;
  final bool isDarkMode;

  const _AnimatedSkillCard({
    required this.skill,
    required this.index,
    required this.isVisible,
    required this.isDarkMode,
  });

  @override
  State<_AnimatedSkillCard> createState() => _AnimatedSkillCardState();
}

class _AnimatedSkillCardState extends State<_AnimatedSkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 600 + (widget.index * 150)),
      tween: Tween<double>(begin: 0, end: widget.isVisible ? 1 : 0),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.glass(_isHovered ? 0.15 : 0.1, widget.isDarkMode),
                AppTheme.glass(_isHovered ? 0.08 : 0.05, widget.isDarkMode),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? AppTheme.glassBorder(0.3, widget.isDarkMode)
                  : AppTheme.glassBorder(0.2, widget.isDarkMode),
              width: 1,
            ),
            boxShadow: _isHovered
                ? [
              BoxShadow(
                color: AppTheme.getPrimary(widget.isDarkMode).withOpacity(0.2),
                blurRadius: 30,
                spreadRadius: 3,
              ),
            ]
                : null,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
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
                            _getSkillIcon(widget.skill.name),
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
                                widget.skill.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.getTextPrimary(widget.isDarkMode),
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${widget.skill.proficiency}% Proficiency',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.getTextSecondary(widget.isDarkMode),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppTheme.glass(0.1, widget.isDarkMode),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Stack(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 1000),
                                width: constraints.maxWidth * (widget.skill.proficiency / 100),
                                decoration: BoxDecoration(
                                  gradient: AppTheme.primaryGradient(widget.isDarkMode),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.getPrimary(widget.isDarkMode).withOpacity(0.5),
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getSkillIcon(String skillName) {
    final iconMap = {
      'Flutter & Dart': Icons.flutter_dash,
      'State Management': Icons.settings_suggest_rounded,
      'Firebase Integration': Icons.local_fire_department_rounded,
      'REST APIs': Icons.api_rounded,
      'Clean Architecture': Icons.architecture_rounded,
      'UI/UX Design': Icons.design_services_rounded,
      'Stripe Payment': Icons.payment_rounded,
      'CI/CD': Icons.cloud_sync_rounded,
      'Git & GitHub': Icons.source_rounded,
      'Shared Preferences': Icons.storage_rounded,
    };
    return iconMap[skillName] ?? Icons.star_rounded;
  }
}

class _AnimatedTechCard extends StatefulWidget {
  final TechStack tech;
  final int index;
  final bool isVisible;
  final bool isDarkMode;

  const _AnimatedTechCard({
    required this.tech,
    required this.index,
    required this.isVisible,
    required this.isDarkMode,
  });

  @override
  State<_AnimatedTechCard> createState() => _AnimatedTechCardState();
}

class _AnimatedTechCardState extends State<_AnimatedTechCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      duration: Duration(milliseconds: 2000 + (widget.index * 100)),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(
      begin: -5,
      end: 5,
    ).animate(CurvedAnimation(
      parent: _floatController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 700 + (widget.index * 100)),
      tween: Tween<double>(begin: 0, end: widget.isVisible ? 1 : 0),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: value,
            child: child,
          ),
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedBuilder(
          animation: _floatAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _floatAnimation.value),
              child: child,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            transform: Matrix4.identity()..scale(_isHovered ? 1.1 : 1.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _isHovered
                    ? [
                  AppTheme.glass(0.2, widget.isDarkMode),
                  AppTheme.glass(0.1, widget.isDarkMode),
                ]
                    : [
                  AppTheme.glass(0.1, widget.isDarkMode),
                  AppTheme.glass(0.05, widget.isDarkMode),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isHovered
                    ? AppTheme.glassBorder(0.4, widget.isDarkMode)
                    : AppTheme.glassBorder(0.2, widget.isDarkMode),
                width: _isHovered ? 2 : 1,
              ),
              boxShadow: _isHovered
                  ? [
                BoxShadow(
                  color: AppTheme.getAccent(widget.isDarkMode).withOpacity(0.3),
                  blurRadius: 25,
                  spreadRadius: 3,
                ),
              ]
                  : null,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.tech.icon.endsWith('.svg')
                        ? SvgPicture.asset(
                      widget.tech.icon,
                      width: _isHovered ? 52 : 44,
                      height: _isHovered ? 52 : 44,
                    )
                        : Text(
                      widget.tech.icon,
                      style: TextStyle(
                        fontSize: _isHovered ? 52 : 44,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        widget.tech.name,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.getTextPrimary(widget.isDarkMode),
                          letterSpacing: 0.3,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}