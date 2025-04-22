import 'package:flutter/material.dart';
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
    return Tooltip(
      message: "🌟 Tap to toggle theme!",
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

    IconData iconData;
    switch (themeType) {
      case ThemeType.dark:
        iconData = Icons.dark_mode;
        break;
      case ThemeType.light:
        iconData = Icons.light_mode;
        break;
      case ThemeType.system:
        iconData = Icons.auto_awesome_mosaic;
        break;
    }

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
      child: Icon(
        iconData,
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
      ),
    );
  }
}
