import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 800,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Profile Detail",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const SizedBox(
                height: 32,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                child: Text(
                  "A detail-oriented and adaptable full-stack developer with a strong foundation in problem-solving. Currently pursuing a Bachelor of Informatics Engineering at Mikroskil University with a GPA of 3.98. I have a passion for creating efficient and user-friendly applications, with a focus on Flutter and web development. I am eager to contribute my skills to innovative projects and collaborate with teams to deliver high-quality software solutions.",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.onSurface,
                        height: 1.8,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Contact",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                runSpacing: 32,
                spacing: 32,
                children: [
                  _labelRow(
                    HeroIcons.mapPin,
                    "Medan, Indonesia",
                  ),
                  _labelRow(
                    HeroIcons.envelope,
                    "samuelonasis.work@gmail.com",
                  ),
                ],
              ),
              const SizedBox(
                height: 64,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _labelRow(HeroIcons icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        HeroIcon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 32,
          style: HeroIconStyle.solid,
        ),
        const SizedBox(
          width: 16,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ],
    );
  }
}
