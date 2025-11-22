import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/animated_glass_card.dart';
import '../../core/widgets/fade_in_slide.dart';
import '../../data/models/project_model.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
              // Section Header
              const SectionHeader(
                label: 'MY WORK',
                title: 'Featured Projects',
                subtitle: 'Explore my latest work and creative solutions',
              ),

              SizedBox(height: responsive.value(
                mobile: 48.0,
                tablet: 60.0,
                desktop: 80.0,
              )),

              // Projects Grid
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

  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final gradientColors = AppTheme.projectGradients[index % AppTheme.projectGradients.length];

    return AnimatedGlassCard(
      onTap: () => _showProjectDialog(context),
      gradientColors: gradientColors,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Icon/Image
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    gradientColors[0].withOpacity(0.3),
                    gradientColors[1].withOpacity(0.3),
                  ],
                ),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppTheme.radiusXxl),
                ),
              ),
              child: Center(
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
                    color: AppTheme.textPrimary,
                  ),
                ),
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
                  // Title
                  Text(
                    project.title,
                    style: AppTheme.h4.copyWith(fontSize: 20),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: AppTheme.sm),

                  // Description
                  Expanded(
                    child: Text(
                      project.description,
                      style: AppTheme.bodySmall,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(height: AppTheme.md),

                  // Technologies
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
                              gradientColors[0].withOpacity(0.3),
                              gradientColors[1].withOpacity(0.2),
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
                          style: AppTheme.caption.copyWith(fontSize: 11),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: AppTheme.md),

                  // View Details Button
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.md,
                      vertical: AppTheme.sm,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: gradientColors),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View Details',
                          style: AppTheme.caption.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: AppTheme.sm),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          color: AppTheme.textPrimary,
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
      builder: (context) => ProjectDialog(project: project),
    );
  }

  IconData _getProjectIcon(String title) {
    if (title.contains('AutoHaus') || title.contains('Car')) {
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

  const ProjectDialog({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.backgroundLight.withOpacity(0.98),
              AppTheme.background.withOpacity(0.98),
            ],
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusXxl),
          border: Border.all(
            color: AppTheme.glassBorder(0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(AppTheme.lg),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      project.title,
                      style: AppTheme.h3,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                    color: AppTheme.textPrimary,
                  ),
                ],
              ),
            ),

            const Divider(
              color: AppTheme.surface,
              height: 1,
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: AppTheme.h4.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: AppTheme.sm),
                    Text(
                      project.description,
                      style: AppTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppTheme.lg),
                    Text(
                      'Technologies',
                      style: AppTheme.h4.copyWith(fontSize: 18),
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
                            color: AppTheme.primary.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                          ),
                          child: Text(
                            tech,
                            style: AppTheme.bodySmall.copyWith(
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

            // Actions
            if (project.githubUrl.isNotEmpty || project.liveUrl != null)
              Padding(
                padding: const EdgeInsets.all(AppTheme.lg),
                child: Row(
                  children: [
                    if (project.githubUrl.isNotEmpty)
                      Expanded(
                        child: _buildActionButton(
                          context,
                          'GitHub',
                          Icons.code_rounded,
                              () => _launchUrl(project.githubUrl),
                        ),
                      ),
                    if (project.githubUrl.isNotEmpty && project.liveUrl != null)
                      const SizedBox(width: AppTheme.md),
                    if (project.liveUrl != null)
                      Expanded(
                        child: _buildActionButton(
                          context,
                          'Live Demo',
                          Icons.launch_rounded,
                              () => _launchUrl(project.liveUrl!),
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

  Widget _buildActionButton(
      BuildContext context,
      String label,
      IconData icon,
      VoidCallback onPressed,
      ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primary,
        foregroundColor: AppTheme.textPrimary,
        padding: const EdgeInsets.symmetric(vertical: AppTheme.md),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: AppTheme.sm),
          Text(label, style: AppTheme.button.copyWith(fontSize: 14)),
        ],
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