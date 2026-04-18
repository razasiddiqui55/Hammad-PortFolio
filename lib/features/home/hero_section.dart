import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/gradient_button.dart';
import '../../core/widgets/fade_in_slide.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onContactPressed;
  final bool isDarkMode;

  const HeroSection({
    super.key,
    required this.onContactPressed,
    required this.isDarkMode,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatingController;
  late Animation<double> _floatingAnimation;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(
        parent: _floatingController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      padding: responsive.value(
        mobile: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
        tablet: const EdgeInsets.symmetric(horizontal: 32, vertical: 100),
        desktop: const EdgeInsets.symmetric(horizontal: 48, vertical: 120),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: responsive.contentMaxWidth),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Status Badge
              FadeInSlide(
                delay: const Duration(milliseconds: 100),
                child: _buildStatusBadge(),
              ),

              SizedBox(height: responsive.value(
                mobile: 24.0,
                tablet: 32.0,
                desktop: 40.0,
              )),

              // Name
              FadeInSlide(
                delay: const Duration(milliseconds: 300),
                child: _buildName(context, responsive),
              ),

              SizedBox(height: responsive.value(
                mobile: 20.0,
                tablet: 24.0,
                desktop: 32.0,
              )),

              // Role Switcher
              FadeInSlide(
                delay: const Duration(milliseconds: 500),
                child: _buildRoleSwitcher(context, responsive),
              ),

              SizedBox(height: responsive.value(
                mobile: 20.0,
                tablet: 24.0,
                desktop: 32.0,
              )),

              // Description
              FadeInSlide(
                delay: const Duration(milliseconds: 700),
                child: _buildDescription(context, responsive),
              ),

              SizedBox(height: responsive.value(
                mobile: 32.0,
                tablet: 40.0,
                desktop: 48.0,
              )),

              // CTA Buttons
              FadeInSlide(
                delay: const Duration(milliseconds: 900),
                child: _buildCTAButtons(responsive),
              ),

              SizedBox(height: responsive.value(
                mobile: 40.0,
                tablet: 60.0,
                desktop: 80.0,
              )),

              // Scroll Indicator
              if (!responsive.isMobile)
                FadeInSlide(
                  delay: const Duration(milliseconds: 1200),
                  child: _buildScrollIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    return AnimatedBuilder(
      animation: _floatingAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatingAnimation.value),
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.glass(0.15, widget.isDarkMode),
              AppTheme.glass(0.08, widget.isDarkMode),
            ],
          ),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: AppTheme.glassBorder(0.3, widget.isDarkMode),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppTheme.success,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.success,
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Available for work',
              style: AppTheme.bodySmall(widget.isDarkMode).copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildName(BuildContext context, Responsive responsive) {
    return ShaderMask(
      shaderCallback: (bounds) => AppTheme.primaryGradient(widget.isDarkMode)
          .createShader(bounds),
      child: Text(
        'Hammad Siddiqui',
        style: context.scaleText(
            responsive.isMobile
                ? AppTheme.displaySmall(widget.isDarkMode)
                : AppTheme.displayLarge(widget.isDarkMode)
        ).copyWith(color: AppTheme.getTextPrimary(widget.isDarkMode)),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildRoleSwitcher(BuildContext context, Responsive responsive) {
    return GlassContainer(
      isDarkMode: widget.isDarkMode,
      padding: EdgeInsets.symmetric(
        horizontal: responsive.value(mobile: 20.0, tablet: 32.0, desktop: 40.0),
        vertical: responsive.value(mobile: 16.0, tablet: 20.0, desktop: 24.0),
      ),
      borderRadius: AppTheme.radiusLg,
      child: SizedBox(
        height: responsive.value(mobile: 32.0, tablet: 40.0, desktop: 48.0),
        child: DefaultTextStyle(
          style: context.scaleText(
              responsive.isMobile
                  ? AppTheme.h4(widget.isDarkMode)
                  : AppTheme.h2(widget.isDarkMode)
          ).copyWith(fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
          child: AnimatedTextKit(
            repeatForever: true,
            pause: const Duration(milliseconds: 1000),
            animatedTexts: [
              TypewriterAnimatedText(
                'Flutter Developer',
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'Cross-Platform Expert',
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'Firebase Specialist',
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'Clean Architecture',
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'UI/UX Enthusiast',
                speed: const Duration(milliseconds: 100),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescription(BuildContext context, Responsive responsive) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.value(mobile: 16.0, tablet: 48.0, desktop: 80.0),
      ),
      child: Text(
        'Creating beautiful, responsive, and high-performance Flutter apps with clean code, thoughtful design, and cross-platform reliability',
        style: context.scaleText(
            responsive.isMobile
                ? AppTheme.bodyMedium(widget.isDarkMode)
                : AppTheme.bodyLarge(widget.isDarkMode)
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCTAButtons(Responsive responsive) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        GradientButton(
          text: 'Download CV',
          icon: Icons.download_rounded,
          onPressed: _downloadCV,
          width: responsive.isMobile ? double.infinity : null,
          isDarkMode: widget.isDarkMode,
        ),
        GradientButton(
          text: 'Contact Me',
          icon: Icons.mail_rounded,
          isPrimary: false,
          onPressed: widget.onContactPressed,
          width: responsive.isMobile ? double.infinity : null,
          isDarkMode: widget.isDarkMode,
        ),
      ],
    );
  }

  Widget _buildScrollIndicator() {
    return Column(
      children: [
        Text(
          'Scroll Down',
          style: AppTheme.caption(widget.isDarkMode).copyWith(
            color: AppTheme.getTextTertiary(widget.isDarkMode),
          ),
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: _floatingAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _floatingAnimation.value / 2),
              child: child,
            );
          },
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppTheme.getTextTertiary(widget.isDarkMode),
            size: 32,
          ),
        ),
      ],
    );
  }

  void _downloadCV() async {
    const url = 'https://drive.google.com/file/d/1T9WCbIbGLkXelFuyK8Tyjqzc0VMoVfxj/view?usp=sharing';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}