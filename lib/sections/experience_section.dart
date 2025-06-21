import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:website/components/timeline/my_timeline.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<TimelineItem> items = [
      TimelineItem(
        HeroIcons.codeBracket,
        date: DateTime(2023, 1, 1),
        content: const Text("Started my journey in Flutter development."),
      ),
      TimelineItem(
        HeroIcons.briefcase,
        date: DateTime(2023, 6, 1),
        content: const Text("Joined a startup as a Flutter developer."),
      ),
      TimelineItem(
        HeroIcons.heart,
        date: DateTime(2024, 1, 1),
        content: const Text("Contributed to open-source projects."),
      ),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Experience",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: MyTimeline(items: items)),
      ],
    );
  }
}
