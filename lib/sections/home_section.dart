import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64),
      child: Column(
        children: [
          _tweenAnimationBuilder(
            child: DottedBorder(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              strokeWidth: 3,
              dashPattern: const [
                8,
                6,
              ],
              borderType: BorderType.Circle,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 200,
                  backgroundImage:
                      const AssetImage("assets/images/profile_image.png"),
                  backgroundColor: Theme.of(context).colorScheme.surfaceBright,
                ),
              ),
            ),
          ),
          const SizedBox(height: 48),
          _tweenAnimationBuilder(
            child: Text(
              "Samuel Onasis",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          _tweenAnimationBuilder(
            child: FittedBox(
              child: Text(
                "Flutter Developer • Full Stack Developer",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _tweenAnimationBuilder(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                "I am a passionate programmer with a strong focus on mobile app development. I enjoy building innovative and user-friendly applications that make a difference.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tweenAnimationBuilder({
    required Widget child,
  }) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
