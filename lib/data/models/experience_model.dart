class ExperienceModel {
  final String title;
  final String period;
  final String role;
  final String description;
  final List<String> achievements;
  final String company;

  ExperienceModel({
    required this.title,
    required this.period,
    required this.role,
    this.achievements = const [],
    required this.description,
    required this.company,
  });

  static List<ExperienceModel> getExperiences() {
    return [
      ExperienceModel(
        title: 'Flutter Developer',
        company: 'Akodes IT Solutions',
        role: 'Mobile App Developer',
        achievements: [
          'Published 5+ apps on Google Play Store & Apple App Store',
          'Implemented Stripe payments, Firebase backend solutions, and real-time app functionalities',
        ],
        period: '2023 - Present (2+ Years)',
        description:
        'Developed 10+ high-quality cross-platform mobile applications using Flutter, following clean architecture principles. Specialized in state management with GetX, seamless Firebase integration, REST API connectivity, Stripe payment gateway implementation, and crafting responsive, pixel-perfect UI/UX designs. Successfully led projects from initial concept to deployment on both Play Store and App Store, ensuring optimal performance and user experience.',
      ),
      ExperienceModel(
        title: 'Freelance Flutter Developer',
        company: 'Self-Employed',
        role: 'Independent Mobile Developer',
        achievements: [
          'Successfully delivered 3+ complete app solutions to clients',
          'Managed full project lifecycle from requirements to deployment',
          'Built strong client relationships with 100% satisfaction rate',
        ],
        period: '2023 - Present',
        description:
        'Worked independently with clients to deliver custom mobile applications. Handled direct client communication, requirement gathering, project planning, and end-to-end development. Gained valuable experience in client management, time management, and delivering production-ready applications within agreed timelines and budgets.',
      ),
      ExperienceModel(
        title: 'Learning & Skill Development',
        company: 'Self-Study',
        role: 'Flutter Enthusiast',
        achievements: [
          'Mastered Flutter framework and Dart programming language',
          'Completed multiple online courses and certifications',
          'Built diverse portfolio projects showcasing various capabilities',
        ],
        period: '2022 - 2023',
        description:
        'Intensive self-learning journey in mobile application development. Focused on mastering Flutter, understanding mobile design patterns, and building a strong foundation in cross-platform development. Created multiple practice projects to solidify understanding of core concepts and modern development practices.',
      ),
    ];
  }
}