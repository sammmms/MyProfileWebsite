import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:website/utils/theme_notifier.dart';

class MyAppBar extends StatefulWidget {
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
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  final Map<String, GlobalKey> sectionKeys = {
    "Home": GlobalKey(),
    "Profile": GlobalKey(),
    "Experience": GlobalKey(),
    "Education": GlobalKey(),
    "Projects": GlobalKey(),
    "Skills": GlobalKey(),
    "Achievements": GlobalKey(),
    "Contact": GlobalKey(),
  };

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

  final _appBarKey = GlobalKey();

  bool isMobile = false;
  bool isSmall = false;

  int length = 0;

  double newLeftAlign = 0.0;
  double pillWidth = 0.0;
  double pillHeight = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateMediaQuery();
      _calculatePillWidth();
    });
  }

  @override
  Widget build(BuildContext context) {
    _calculateMediaQuery();
    _calculatePillWidth();
    final headings = sectionKeys.keys.toList();

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
            key: _appBarKey,
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.surfaceBright.withOpacity(0.4),
              borderRadius: BorderRadius.circular(128),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: FittedBox(
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      left: newLeftAlign - (pillWidth / 2),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Container(
                        width: pillWidth,
                        height: pillHeight,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceBright,
                          borderRadius: BorderRadius.circular(128),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int i = 0; i < length; i++)
                          GestureDetector(
                            onTap: () => widget.onTap(headings[i]),
                            child: Container(
                              key: sectionKeys[headings[i]],
                              // decoration: BoxDecoration(
                              //   color: selectedHeading == headings[i]
                              //       ? Theme.of(context)
                              //           .colorScheme
                              //           .surfaceBright
                              //       : Colors.transparent,
                              //   borderRadius: BorderRadius.circular(128),
                              // ),
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: isMobile
                                  ? Icon(
                                      icons[i],
                                      color:
                                          widget.selectedHeading == headings[i]
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
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
                                            color: widget.selectedHeading ==
                                                    headings[i]
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
                          onTap: widget.onChangeTheme,
                          child: Icon(
                            context.watch<ThemeNotifier>().isDarkMode
                                ? Icons.dark_mode
                                : Icons.light_mode,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  void _calculateMediaQuery() {
    final dimensions = MediaQuery.of(context).size;

    isMobile = dimensions.width < 1400;
    isSmall = dimensions.width < 750;

    length = sectionKeys.length;

    if (isSmall) length = length - 3;
  }

  void _calculatePillWidth() {
    final key = sectionKeys[widget.selectedHeading];

    final renderBox = key?.currentContext?.findRenderObject() as RenderBox?;
    final appBarBox =
        _appBarKey.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox != null) {
      final offset = renderBox.localToGlobal(Offset.zero);
      final appBarOffset = appBarBox?.localToGlobal(Offset.zero) ?? Offset.zero;
      final size = renderBox.size;

      setState(() {
        pillWidth = size.width;
        pillHeight = size.height;
        newLeftAlign = offset.dx - appBarOffset.dx;
      });
    }
  }
}
