import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/animated_glass_card.dart';
import '../../core/widgets/fade_in_slide.dart';
import '../../core/widgets/gradient_button.dart';
import '../../data/models/project_model.dart';

class ProjectsSection extends StatelessWidget {
  final bool isDarkMode;

  const ProjectsSection({
    super.key,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final projects = ProjectModel.getSampleProjects();

    return Container(
      padding: responsive.sectionPadding,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: responsive.contentMaxWidth),
          child: Column(
            children: [
              SectionHeader(
                label: 'MY WORK',
                title: 'Featured Projects',
                subtitle: 'Explore my latest work and creative solutions',
                isDarkMode: isDarkMode,
              ),

              SizedBox(height: responsive.value(
                mobile: 48.0,
                tablet: 60.0,
                desktop: 80.0,
              )),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: responsive.gridColumns,
                  crossAxisSpacing: AppTheme.lg,
                  mainAxisSpacing: AppTheme.lg,
                  childAspectRatio: responsive.isMobile ? 0.85 : 0.75,
                ),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return FadeInSlide(
                    delay: Duration(milliseconds: 100 * index),
                    child: ProjectCard(
                      project: projects[index],
                      index: index,
                      isDarkMode: isDarkMode,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final int index;
  final bool isDarkMode;

  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final gradientColors = AppTheme.projectGradients(isDarkMode)[index % AppTheme.projectGradients(isDarkMode).length];

    return AnimatedGlassCard(
      onTap: () => _showProjectDialog(context),
      gradientColors: gradientColors,
      isDarkMode: isDarkMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Icon/Image header — with a "production app" badge
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    gradientColors[0].withOpacity(isDarkMode ? 0.3 : 0.2),
                    gradientColors[1].withOpacity(isDarkMode ? 0.3 : 0.2),
                  ],
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppTheme.radiusXxl),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(AppTheme.lg),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: gradientColors),
                        shape: BoxShape.circle,
                        boxShadow: AppTheme.shadowMd(gradientColors[0]),
                      ),
                      child: Icon(
                        _getProjectIcon(project.title),
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  if (project.liveUrl.isNotEmpty)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.getBackground(isDarkMode).withOpacity(0.55),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.25)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppTheme.success,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Live',
                              style: AppTheme.caption(isDarkMode).copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Project Details
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: AppTheme.h4(isDarkMode).copyWith(fontSize: 20),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: AppTheme.sm),

                  Expanded(
                    child: Text(
                      project.description,
                      style: AppTheme.bodySmall(isDarkMode),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(height: AppTheme.md),

                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: project.technologies.take(3).map((tech) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              gradientColors[0].withOpacity(isDarkMode ? 0.3 : 0.2),
                              gradientColors[1].withOpacity(isDarkMode ? 0.2 : 0.15),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                          border: Border.all(
                            color: gradientColors[0].withOpacity(0.4),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          tech,
                          style: AppTheme.caption(isDarkMode).copyWith(fontSize: 11),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: AppTheme.md),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.md,
                      vertical: AppTheme.sm,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: gradientColors),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                      boxShadow: [
                        BoxShadow(
                          color: gradientColors[0].withOpacity(0.35),
                          blurRadius: 16,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View Case Study',
                          style: AppTheme.caption(isDarkMode).copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: AppTheme.sm),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showProjectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ProjectDialog(
        project: project,
        isDarkMode: isDarkMode,
        // gradientColors: gradientColors,
      ),
    );
  }

  IconData _getProjectIcon(String title) {
    if (title.contains('Sports Passport') || title.contains('Sports')) {
      return Icons.sports_soccer_rounded;
    } else if (title.contains('Find A Job') || title.contains('Job')) {
      return Icons.work_rounded;
    } else if (title.contains('Secure Safe Trust') || title.contains('Safe Trust')) {
      return Icons.health_and_safety_rounded;
    } else if (title.contains('AutoHaus') || title.contains('Car')) {
      return Icons.directions_car_rounded;
    } else if (title.contains('Voice') || title.contains('Notes')) {
      return Icons.mic_rounded;
    } else if (title.contains('Bonsify') || title.contains('Event')) {
      return Icons.celebration_rounded;
    } else if (title.contains('Deliver')) {
      return Icons.local_shipping_rounded;
    } else if (title.contains('Things')) {
      return Icons.explore_rounded;
    } else if (title.contains('Earthnique')) {
      return Icons.store_rounded;
    } else if (title.contains('Koif')) {
      return Icons.content_cut_rounded;
    }
    return Icons.apps_rounded;
  }
}

class ProjectDialog extends StatelessWidget {
  final ProjectModel project;
  final bool isDarkMode;
  final List<Color> gradientColors;

  const ProjectDialog({
    super.key,
    required this.project,
    required this.isDarkMode,
    this.gradientColors = const [AppTheme.darkPrimary, AppTheme.darkAccent],
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.getBackgroundLight(isDarkMode).withOpacity(0.98),
              AppTheme.getBackground(isDarkMode).withOpacity(0.98),
            ],
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusXxl),
          border: Border.all(
            color: AppTheme.glassBorder(0.25, isDarkMode),
            width: 1,
          ),
          boxShadow: AppTheme.shadowLg(gradientColors[0]),
        ),
        child: Column(
          children: [
            // Signature gradient banner keyed to the project's accent colors
            Container(
              height: 6,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradientColors),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppTheme.radiusXxl),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.lg),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: gradientColors),
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      boxShadow: AppTheme.shadowSm(gradientColors[0]),
                    ),
                    child: const Icon(Icons.rocket_launch_rounded, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: AppTheme.md),
                  Expanded(
                    child: Text(
                      project.title,
                      style: AppTheme.h3(isDarkMode).copyWith(fontSize: 22),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                    color: AppTheme.getTextPrimary(isDarkMode),
                  ),
                ],
              ),
            ),

            Divider(
              color: AppTheme.getSurface(isDarkMode),
              height: 1,
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: AppTheme.h4(isDarkMode).copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: AppTheme.sm),
                    Text(
                      project.description,
                      style: AppTheme.bodyMedium(isDarkMode),
                    ),
                    const SizedBox(height: AppTheme.lg),
                    Text(
                      'Technologies',
                      style: AppTheme.h4(isDarkMode).copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: AppTheme.sm),
                    Wrap(
                      spacing: AppTheme.sm,
                      runSpacing: AppTheme.sm,
                      children: project.technologies.map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                gradientColors[0].withOpacity(0.22),
                                gradientColors[1].withOpacity(0.14),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                            border: Border.all(
                              color: gradientColors[0].withOpacity(0.4),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            tech,
                            style: AppTheme.bodySmall(isDarkMode).copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            if (project.githubUrl.isNotEmpty || project.liveUrl.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(AppTheme.lg),
                child: Row(
                  children: [
                    if (project.githubUrl.isNotEmpty)
                      Expanded(
                        child: GradientButton(
                          text: 'GitHub',
                          icon: Icons.code_rounded,
                          isPrimary: false,
                          isDarkMode: isDarkMode,
                          onPressed: () => _launchUrl(project.githubUrl),
                        ),
                      ),
                    if (project.githubUrl.isNotEmpty && project.liveUrl.isNotEmpty)
                      const SizedBox(width: AppTheme.md),
                    if (project.liveUrl.isNotEmpty)
                      Expanded(
                        child: GradientButton(
                          text: 'Live Demo',
                          icon: Icons.launch_rounded,
                          isDarkMode: isDarkMode,
                          onPressed: () => _launchUrl(project.liveUrl),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}