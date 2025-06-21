import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:provider/provider.dart';
import 'package:website/utils/theme_notifier.dart';

class MyThemeButton extends StatefulWidget {
  const MyThemeButton({super.key});

  @override
  State<MyThemeButton> createState() => _MyThemeButtonState();
}

class _MyThemeButtonState extends State<MyThemeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final themeNotifier = ThemeNotifier();

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ThemeNotifier>().isDarkMode;
    return Tooltip(
      message:
          "${isDarkMode ? "☀️" : "🌙"} - Change the website looks to ${isDarkMode ? "Light" : "Dark"} Mode",
      child: GestureDetector(
        onTap: () {
          context.read<ThemeNotifier>().changeTheme();

          _controller.forward().then((value) {
            _controller.reverse();
          });
        },
        child: _getThemeIcon(),
      ),
    );
  }

  Widget _getThemeIcon() {
    ThemeType themeType = context.watch<ThemeNotifier>().themeType;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: Tween<double>(begin: 1, end: 1.2)
              .animate(CurvedAnimation(
                parent: _controller,
                curve: Curves.easeInOut,
                reverseCurve: Curves.easeInOut.flipped,
              ))
              .value,
          child: child,
        );
      },
      child: HeroIcon(
        themeType.next.icon,
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
      ),
    );
  }
}
