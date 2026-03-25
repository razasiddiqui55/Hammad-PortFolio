import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'core/widgets/animated_background.dart';
import 'core/widgets/app_navigation.dart';
import 'features/home/hero_section.dart';
import 'features/about/about_section.dart';
import 'features/contact/contact_section.dart';
import 'features/education/education_section.dart';
import 'features/experience/experience_section.dart';
import 'features/projects/projects_section.dart';
import 'features/skills/skills_section.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyPortfolioApp(),
    ),
  );
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Hammad Siddiqui - Flutter Developer',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: themeProvider.isDarkMode
                  ? AppTheme.darkPrimary
                  : AppTheme.lightPrimary,
              brightness: themeProvider.isDarkMode
                  ? Brightness.dark
                  : Brightness.light,
            ),
            textTheme: GoogleFonts.interTextTheme(),
            scaffoldBackgroundColor:
            AppTheme.getBackground(themeProvider.isDarkMode),
          ),
          // ✅ isDarkMode ab MaterialApp ke andar pass ho raha hai
          // isliye PortfolioHome ko prop ki zaroorat nahi
          home: const PortfolioHome(),
        );
      },
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
    // ✅ Ek baar Consumer yahan, sab sections ko isDarkMode milega
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final isDark = themeProvider.isDarkMode;

        return Scaffold(
          body: Stack(
            children: [
              // Animated Background
              AnimatedBackground(isDarkMode: isDark),

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
                      isDarkMode: isDark,
                    ),

                    // About Section
                    Container(
                      key: _sectionKeys[1],
                      constraints: const BoxConstraints(minHeight: 800),
                      child: AboutSection(isDarkMode: isDark),
                    ),

                    // Education Section
                    Container(
                      key: _sectionKeys[2],
                      constraints: const BoxConstraints(minHeight: 800),
                      child: EducationSection(isDarkMode: isDark),
                    ),

                    // Experience Section
                    Container(
                      key: _sectionKeys[3],
                      constraints: const BoxConstraints(minHeight: 800),
                      child: ExperienceSection(isDarkMode: isDark),
                    ),

                    // Skills Section
                    Container(
                      key: _sectionKeys[4],
                      constraints: const BoxConstraints(minHeight: 800),
                      child: SkillsSection(isDarkMode: isDark),
                    ),

                    // Projects Section
                    Container(
                      key: _sectionKeys[5],
                      constraints: const BoxConstraints(minHeight: 800),
                      child: ProjectsSection(isDarkMode: isDark),
                    ),

                    // Contact Section
                    Container(
                      key: _sectionKeys[6],
                      constraints: const BoxConstraints(minHeight: 800),
                      child: ContactSection(isDarkMode: isDark),
                    ),
                  ],
                ),
              ),

              // Navigation Bar
              AppNavigation(
                activeSection: _activeSection,
                onNavigate: _scrollToSection,
                isDarkMode: isDark,
                onThemeToggle: themeProvider.toggleTheme,
              ),
            ],
          ),
        );
      },
    );
  }
}