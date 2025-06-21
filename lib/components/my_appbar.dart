import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:website/components/my_sticky_appbar.dart';
import 'package:website/components/my_theme_button.dart';
import 'package:website/utils/section_headers.dart';

class MyAppBar extends StatefulWidget {
  final Function(String) onTap;
  final String selectedHeading;
  const MyAppBar({
    super.key,
    required this.onTap,
    this.selectedHeading = "Home",
  });

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  final Map<String, GlobalKey> sectionKeys = SectionHeaders.sectionKeys;

  final List<SectionHeader> sectionHeaders = SectionHeaders.sections;

  final _appBarKey = GlobalKey();

  bool isBig = false;
  bool isMobile = false;
  bool isSmall = false;
  bool useStickyAppbar = false;

  int length = 0;

  double newLeftAlign = 30;
  double pillWidth = 40;
  double pillHeight = 40;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateMediaQuery();
      _calculatePillWidth();
    });
  }

  List<String> get headings => sectionKeys.keys.toList();

  bool isSelected(int i) {
    return headings[i] == widget.selectedHeading;
  }

  @override
  Widget build(BuildContext context) {
    _calculateMediaQuery();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculatePillWidth();
    });

    return useStickyAppbar
        ? MyStickyAppbar(
            sectionHeaders: sectionHeaders,
          )
        : SliverAppBar(
            toolbarHeight: 200,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            snap: true,
            floating: true,
            scrolledUnderElevation: 0,
            title: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, value, child) => Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, -50 * (1 - value)),
                  child: child,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(128),
                child: Container(
                    key: _appBarKey,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceBright
                          .withOpacity(0.4),
                      borderRadius: BorderRadius.circular(128),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: Stack(
                        children: [
                          AnimatedPositioned.fromRect(
                            rect: Rect.fromLTWH(
                              newLeftAlign - 48,
                              pillHeight / 2 - 20,
                              pillWidth,
                              pillHeight,
                            ),
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                            child: Container(
                              width: pillWidth,
                              height: pillHeight,
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).colorScheme.surfaceBright,
                                borderRadius: BorderRadius.circular(128),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (int i = 0; i < length; i++)
                                Tooltip(
                                  message: sectionHeaders[i].tooltip,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () => widget.onTap(headings[i]),
                                    child: Container(
                                      key: sectionKeys[headings[i]],
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: _determineIcon(i),
                                    ),
                                  ),
                                ),
                              const SizedBox(width: 16),
                              const MyThemeButton()
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          );
  }

  Widget _determineIcon(int i) {
    return isMobile
        ? _buildIcon(i)
        : isBig
            ? Row(
                children: [
                  _buildIcon(i),
                  const SizedBox(width: 8),
                  _buildText(i),
                ],
              )
            : _buildText(i);
  }

  Widget _buildIcon(int i) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
      child: HeroIcon(
        sectionHeaders[i].icon,
        color: isSelected(i)
            ? Theme.of(context).colorScheme.onSurface
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        size: isSelected(i) ? 24 : 20,
        style: isSelected(i) ? HeroIconStyle.solid : HeroIconStyle.outline,
      ),
    );
  }

  Widget _buildText(int i) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
      child: Text(
        headings[i],
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: isSelected(i) ? FontWeight.w700 : FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: isSelected(i) ? 16 : 14,
            ),
      ),
    );
  }

  void _calculateMediaQuery() {
    final dimensions = MediaQuery.of(context).size;

    isBig = dimensions.width > 1600;
    isMobile = dimensions.width < 1400;
    isSmall = dimensions.width < 720;
    useStickyAppbar = dimensions.width < 600;

    length = sectionKeys.length;

    if (isSmall) length = length - 3;

    if (isSmall) {
      List<String> headings = sectionKeys.keys.toList();
      headings = headings.sublist(0, length);

      bool haveInHeadings = headings.sublist(0, length).any(
            (heading) => heading == widget.selectedHeading,
          );

      if (!haveInHeadings) {
        widget.onTap(headings.last);
      }
    }
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
