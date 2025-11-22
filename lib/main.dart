import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/animated_background.dart';
import 'core/widgets/app_navigation.dart';
import 'features/home/hero_section.dart';
import 'package:hammad_portfolio/features/about/about_section.dart';
import 'package:hammad_portfolio/features/contact/contact_section.dart';
import 'package:hammad_portfolio/features/education/education_section.dart';
import 'package:hammad_portfolio/features/experience/experience_section.dart';
import 'package:hammad_portfolio/features/projects/projects_section.dart';
import 'package:hammad_portfolio/features/skills/skills_section.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hammad Siddiqui - Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppTheme.primary,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: AppTheme.background,
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ScrollController _scrollController = ScrollController();
  String _activeSection = 'home';

  final List<GlobalKey> _sectionKeys = List.generate(
    7,
        (index) => GlobalKey(),
  );

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    for (int i = 0; i < _sectionKeys.length; i++) {
      final context = _sectionKeys[i].currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero);
          if (position.dy <= 100 && position.dy >= -box.size.height + 100) {
            final sections = [
              'home',
              'about',
              'education',
              'experience',
              'skills',
              'projects',
              'contact'
            ];
            if (_activeSection != sections[i]) {
              setState(() => _activeSection = sections[i]);
            }
            break;
          }
        }
      }
    }
  }

  void _scrollToSection(int index) {
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          const AnimatedBackground(),

          // Content
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Hero Section
                HeroSection(
                  key: _sectionKeys[0],
                  onContactPressed: () => _scrollToSection(6),
                ),

                // About Section (Use your refactored version)
                Container(
                  key: _sectionKeys[1],
                  constraints: const BoxConstraints(minHeight: 800),
                  child: AboutSection(),
                ),

                // Education Section
                Container(
                  key: _sectionKeys[2],
                  constraints: const BoxConstraints(minHeight: 800),
                  child: EducationSection(),
                ),

                // Experience Section
                Container(
                  key: _sectionKeys[3],
                  constraints: const BoxConstraints(minHeight: 800),
                  child: ExperienceSection(),
                ),

                // Skills Section
                Container(
                  key: _sectionKeys[4],
                  constraints: const BoxConstraints(minHeight: 800),
                  child: SkillsSection(),
                ),

                // Projects Section
                Container(
                  key: _sectionKeys[5],
                  constraints: const BoxConstraints(minHeight: 800),
                  child: ProjectsSection(),
                ),

                // Contact Section
                Container(
                  key: _sectionKeys[6],
                  constraints: const BoxConstraints(minHeight: 800),
                  child: ContactSection(),
                ),
              ],
            ),
          ),

          // Navigation Bar
          AppNavigation(
            activeSection: _activeSection,
            onNavigate: _scrollToSection,
          ),
        ],
      ),
    );
  }
}