class SkillModel {
  final String name;
  final double proficiency;
  final String icon;

  SkillModel({
    required this.name,
    required this.proficiency,
    required this.icon,
  });

  static List<SkillModel> getSkills() {
    return [
      SkillModel(name: 'Flutter & Dart', proficiency: 95, icon: '📱'),
      SkillModel(name: 'State Management', proficiency: 90, icon: '⚡'),
      SkillModel(name: 'Firebase Integration', proficiency: 88, icon: '🔥'),
      SkillModel(name: 'REST APIs', proficiency: 92, icon: '🔌'),
      SkillModel(name: 'Clean Architecture', proficiency: 85, icon: '🏗️'),
      SkillModel(name: 'UI/UX Design', proficiency: 90, icon: '🎨'),
      SkillModel(name: 'Stripe Payment', proficiency: 80, icon: '💳'),
      SkillModel(name: 'CI/CD', proficiency: 75, icon: '🔄'),
      SkillModel(name: 'Git & GitHub', proficiency: 88, icon: '🔀'),
      SkillModel(name: 'Shared Preferences', proficiency: 82, icon: '💾'),
    ];
  }
}

class TechStack {
  final String name;
  final String icon;

  TechStack({required this.name, required this.icon});

  static List<TechStack> getTechStack() {
    return [
      TechStack(name: 'Flutter', icon: 'assets/svg/flutter.svg'),
      TechStack(name: 'Dart', icon: 'assets/svg/dart.svg'),
      TechStack(name: 'Firebase', icon: '🔥'),
      TechStack(name: 'GetX', icon: '⚡'),
      TechStack(name: 'Git', icon: '🔀'),
      TechStack(name: 'VS Code', icon: '💻'),
      TechStack(name: 'Figma', icon: 'assets/svg/figma.svg'),
      TechStack(name: 'Postman', icon: '📮'),
      TechStack(name: 'Android Studio', icon: '🤖'),
      TechStack(name: 'REST API', icon: '🔌'),
      TechStack(name: 'Stripe', icon: '💳'),
      TechStack(name: 'Shared Preferences', icon: '💾'),
    ];
  }
}