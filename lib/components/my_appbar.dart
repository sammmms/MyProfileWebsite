import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:website/utils/theme_notifier.dart';

class MyAppBar extends StatelessWidget {
  final Function(String) onTap;
  final Function() onChangeTheme;
  final String selectedHeading;
  const MyAppBar({
    super.key,
    required this.onTap,
    required this.onChangeTheme,
    this.selectedHeading = "Home",
  });

  @override
  Widget build(BuildContext context) {
    final List<String> headings = [
      "Home",
      "Profile",
      "Experience",
      "Education",
      "Projects",
      "Skills",
      "Achievements",
      "Contact",
    ];

    final List<IconData> icons = [
      Icons.home,
      Icons.person,
      Icons.work,
      Icons.school,
      Icons.code,
      Icons.star,
      Icons.verified,
      Icons.contact_mail,
    ];

    final dimensions = MediaQuery.of(context).size;
    final isMobile = dimensions.width < 1400;

    final isSmall = dimensions.width < 750;

    int length = headings.length;

    if (isSmall) length = length - 3;

    return SliverAppBar(
      toolbarHeight: 200,
      centerTitle: true,
      floating: true,
      snap: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: ClipRRect(
        borderRadius: BorderRadius.circular(128),
        child: Container(
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.surfaceBright.withOpacity(0.4),
              borderRadius: BorderRadius.circular(128),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < length; i++)
                    GestureDetector(
                      onTap: () => onTap(headings[i]),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedHeading == headings[i]
                              ? Theme.of(context).colorScheme.surfaceBright
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(128),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: isMobile
                            ? Icon(
                                icons[i],
                                color: selectedHeading == headings[i]
                                    ? Theme.of(context).colorScheme.onSurface
                                    : Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.5),
                              )
                            : Text(
                                headings[i],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: selectedHeading == headings[i]
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                          : Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.5),
                                    ),
                              ),
                      ),
                    ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: onChangeTheme,
                    child: Icon(
                      context.watch<ThemeNotifier>().isDarkMode
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
