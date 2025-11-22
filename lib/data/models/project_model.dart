class ProjectModel {
  final String title;
  final String description;
  final List<String> technologies;
  final String githubUrl;
  final String? liveUrl;
  final String imagePath;

  ProjectModel({
    required this.title,
    required this.description,
    required this.technologies,
    required this.githubUrl,
    this.liveUrl,
    required this.imagePath,
  });

  static List<ProjectModel> getSampleProjects() {
    return [
      ProjectModel(
        title: 'AutoHaus Car Rental',
        description:
            'I built a 3D car booking app that makes it easy for users to book rides for events or business travel. The app includes an interactive 3D car model, Stripe payment integration, and real-time chat for quick support, making the booking process faster and more engaging.',
        technologies: ['Flutter', '3D Model', 'Stripe', 'GetX', 'REST API'],
        githubUrl: '',
        imagePath: '🛍️',
      ),
      ProjectModel(
        title: 'Folder Tree Voice Notes Recorder',
        description:
            'Developed a feature-rich notes application where users can organize voice recordings, images, and text notes in a hierarchical tree structure. Implemented a drag-and-click system allowing users to set the order of notes easily. Designed an intuitive interface for efficient creation, management, and retrieval of notes, while ensuring secure and consistent data storage.',
        technologies: ['Flutter', 'GetX', 'REST API', 'Audio Recording', 'Note Ordering'],
        githubUrl: '',
        imagePath: '📱',
      ),
      ProjectModel(
        title: 'Bonsify',
        description:
            'Developed Bonsify, an event management application that empowers organizers to efficiently create, plan, and manage events. Implemented features to add event details such as date, time, location, descriptions, images, and ticket options. Designed an intuitive user interface for smooth event creation and management, ensuring a seamless experience for both organizers and attendees.',
        technologies: ['Flutter', 'GetX', 'REST API', 'Stripe', 'Ticket Management'],
        githubUrl: '',
        imagePath: '💰',
      ),
      ProjectModel(
        title: 'Deliver Client',
        description:
            'Developed Deliver by GFL, a logistics app that enables individuals and businesses to send packages with ease. Users can create delivery orders, track their shipments in real time, and access various delivery options. The app emphasizes speed, reliability, and eco-conscious transportation.',
        technologies: ['Flutter', 'Provider', 'REST API', 'Pay Stack', 'Push Notifications', 'Location Services'],
        githubUrl: '',
        imagePath: '🏥',
      ),
      ProjectModel(
        title: 'Deliver Fleet',
        description:
            'Deliver Partner is a mobile application developed for GFL (Golden Fleet Logistics) partners, including riders and fleet owners. The app allows delivery partners to efficiently accept and manage delivery requests, track orders in real time, view earnings and delivery history, and access support from the GFL team. Designed to optimize operations and ensure timely deliveries, it provides a seamless interface with features like real-time tracking, notifications, and secure management of delivery data.',
        technologies: ['Flutter', 'Provider', 'REST API', 'Pay Stack', 'Push Notifications', 'Location Services'],
        githubUrl: '',
        imagePath: '🍔',
      ),
      ProjectModel(
        title: 'Things To',
        description:
            'ThingsTo is a community-based discovery app where users add and share interesting places with details like location, category, and images. Other users validate these submissions, earning points and improving ranking. The app supports multilingual UI, favorites, notifications, search, referrals, and privacy features for a smooth and engaging experience.',
        technologies: ['Flutter', 'GetX', 'REST API', 'Google Maps', 'Referral System'],
        githubUrl: '',
        imagePath: '✅',
      ),
      ProjectModel(
        title: 'Earthnique',
        description:
            'Earthnique is a two-sided e-commerce app built for clients and vendors, offering services, products, shops, carts, and real-time chat. Vendors can create and manage their shops, set availability, add services/products, run promotions, and manage subscriptions, while clients can set multiple locations, filter by category/date/time, and book or purchase easily. The app also includes admin chat support, FAQs, and video guides for a smooth onboarding and user experience.',
        technologies: ['Flutter', 'GetX', 'REST API', 'Real-Time Chat', 'Payment Gateway', 'Push Notifications'],
        githubUrl: '',
        imagePath: '✅',
      ),
      ProjectModel(
        title: 'Koif Master',
        description:
            'Koif Master is a three-sided service app for clients who need services, shop owners who manage salons, and professionals who sell their expertise. It enables service booking, shop management, schedules, packages, and role-based access in a smooth and intuitive interface. The app also includes location-based discovery, chat, reviews, notifications, and secure payments—all powered with Firebase.',
        technologies: ['Flutter', 'Firebase', 'Cloud Messaging', 'Payment Integration'],
        githubUrl: 'hello',
        liveUrl: 'hello',
        imagePath: '✅',
      ),
    ];
  }
}
