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
        company: 'Digital Preps',
        role: 'Mobile App Developer',
        achievements: [
          'Building real-time features: location-based discovery, FCM push notifications, and emergency alert systems',
          'Collaborating with backend developers and clients on scalable state management and REST API integrations across projects',
        ],
        period: 'July 2025 - Present',
        description:
        'Delivering 3+ concurrent Flutter apps across sports, job marketplace, and personal safety domains, managing the full development lifecycle from requirements through release. Working closely with backend developers and clients to ship production-ready features on tight timelines.',
      ),
      ExperienceModel(
        title: 'Flutter Developer',
        company: 'Akodes IT Solutions',
        role: 'Mobile App Developer',
        achievements: [
          'Developed and deployed 10+ cross-platform Flutter apps, handling the full project lifecycle from concept to production',
          'Integrated RESTful APIs, secure payment systems, real-time chat, and Firebase push notifications with robust error handling',
          'Collaborated with backend and design teams, maintained modular codebases, conducted code reviews, and implemented CI/CD pipelines',
        ],
        period: 'March 2023 - June 2025',
        description:
        'Developed 10+ high-quality cross-platform mobile applications using Flutter, following clean architecture principles. Specialized in state management with GetX/Provider, seamless Firebase integration, REST API connectivity, secure payment gateway implementation, and crafting responsive, pixel-perfect UI/UX designs. Led projects from initial concept through deployment on both Play Store and App Store.',
      ),
    ];
  }
}