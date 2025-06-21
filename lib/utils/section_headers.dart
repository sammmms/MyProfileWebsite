import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class SectionHeader {
  final String title;
  final HeroIcons icon;
  final String tooltip;
  final GlobalKey key;

  SectionHeader({
    required this.title,
    required this.icon,
    required this.tooltip,
    required this.key,
  });
}

class SectionHeaders {
  static final List<SectionHeader> sections = [
    SectionHeader(
      title: "Home",
      icon: HeroIcons.home,
      tooltip: "🏠 Home - Welcome to the homepage!",
      key: GlobalKey(),
    ),
    SectionHeader(
      title: "Profile",
      icon: HeroIcons.user,
      tooltip: "👤 Profile - Learn more about me!",
      key: GlobalKey(),
    ),
    SectionHeader(
      title: "Experience",
      icon: HeroIcons.briefcase,
      tooltip: "💼 Experience - Check out my work history!",
      key: GlobalKey(),
    ),
    SectionHeader(
      title: "Education",
      icon: HeroIcons.academicCap,
      tooltip: "🎓 Education - See my academic background!",
      key: GlobalKey(),
    ),
    SectionHeader(
      title: "Projects",
      icon: HeroIcons.codeBracket,
      tooltip: "💻 Projects - Explore my creations!",
      key: GlobalKey(),
    ),
    SectionHeader(
      title: "Skills",
      icon: HeroIcons.sparkles,
      tooltip: "⭐ Skills - Discover my expertise!",
      key: GlobalKey(),
    ),
    SectionHeader(
      title: "Achievements",
      icon: HeroIcons.trophy,
      tooltip: "🏆 Achievements - Celebrate my milestones!",
      key: GlobalKey(),
    ),
    SectionHeader(
      title: "Contact",
      icon: HeroIcons.envelope,
      tooltip: "📧 Contact - Get in touch with me!",
      key: GlobalKey(),
    ),
  ];

  static List<String> get title {
    return sections.map((section) => section.title).toList();
  }

  static Map<String, GlobalKey> get sectionKeys {
    return {
      for (int i = 0; i < sections.length; i++) sections[i].title: GlobalKey(),
    };
  }
}
