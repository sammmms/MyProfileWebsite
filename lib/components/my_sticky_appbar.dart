// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:website/utils/section_headers.dart';

class MyStickyAppbar extends StatelessWidget {
  final List<SectionHeader> sectionHeaders;
  const MyStickyAppbar({super.key, required this.sectionHeaders});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      floating: true,
      snap: true,
      toolbarHeight: 80,
      expandedHeight: 80,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
        title: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),
      title: Row(
        children: [
          HeroIcon(
            HeroIcons.userCircle,
            size: 24,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          const SizedBox(width: 8),
          Text(
            "Sam's Portfolio",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: HeroIcon(
            HeroIcons.bars3,
            size: 24,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        )
      ],
    );
  }
}
