import 'package:flutter/material.dart';

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
          maxWidth: 600,
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
              Text.rich(
                const TextSpan(
                  text: "I'm Samuel, a ",
                  children: [
                    TextSpan(
                      text: "Mobile Developer",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    TextSpan(
                      text:
                          " focused on building scalable, user-centered applications. With hands-on experience in ",
                    ),
                    TextSpan(
                      text: "Flutter",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    TextSpan(
                      text: " and ",
                    ),
                    TextSpan(
                      text: "Kotlin",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    TextSpan(
                      text:
                          ", I've created apps that improve workflow efficiency, enhance team collaboration, and reduce manual bottlenecks. From ",
                    ),
                    TextSpan(
                      text: "HR platforms",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    TextSpan(
                      text: " to ",
                    ),
                    TextSpan(
                      text: "industrial tools",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    TextSpan(
                      text: ", I develop solutions that deliver real impact.",
                    ),
                  ],
                ),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 32,
              ),
              Wrap(
                direction: Axis.horizontal,
                runSpacing: 32,
                spacing: 32,
                children: [
                  _labelRow(
                    Icons.location_on_outlined,
                    "Medan, Indonesia",
                  ),
                  _labelRow(
                    Icons.email_outlined,
                    "samuelonasis.work@gmail.com",
                  ),
                ],
              ),
              const SizedBox(
                height: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _labelRow(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 32,
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
