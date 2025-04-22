import 'package:flutter/material.dart';

class SectionHeaders {
  static const List<String> headings = [
    "Home",
    "Profile",
    "Experience",
    "Education",
    "Projects",
    "Skills",
    "Achievements",
    "Contact",
  ];

  static const List<IconData> icons = [
    Icons.home,
    Icons.person,
    Icons.work,
    Icons.school,
    Icons.code,
    Icons.star,
    Icons.verified,
    Icons.contact_mail,
  ];

  static const List<String> tooltips = [
    "🏠 Home - Welcome to the homepage!",
    "👤 Profile - Learn more about me!",
    "💼 Experience - Check out my work history!",
    "🎓 Education - See my academic background!",
    "💻 Projects - Explore my creations!",
    "⭐ Skills - Discover my expertise!",
    "🏆 Achievements - Celebrate my milestones!",
    "📧 Contact - Get in touch with me!"
  ];

  static Map<String, GlobalKey> get sectionKeys {
    return {
      for (int i = 0; i < headings.length; i++) headings[i]: GlobalKey(),
    };
  }
}
