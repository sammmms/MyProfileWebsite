import 'dart:async';

import 'package:flutter/material.dart';
import 'package:website/components/my_appbar.dart';
import 'package:website/sections/experience_section.dart';
import 'package:website/sections/home_section.dart';
import 'package:website/sections/profile_section.dart';
import 'package:website/utils/section_headers.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final StreamController<String> _headerController = StreamController<String>();
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = SectionHeaders.sectionKeys;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrolledHeaderListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_scrolledHeaderListener);
    _scrollController.dispose();
    _headerController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/home_background.jpg"),
            fit: BoxFit.cover,
            opacity: 0.2,
            repeat: ImageRepeat.noRepeat,
          ),
        ),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            StreamBuilder<String>(
              stream: _headerController.stream,
              builder: (context, snapshot) {
                return MyAppBar(
                  selectedHeading: snapshot.data ?? "Home",
                  onTap: (String heading) {
                    _headerController.sink.add(heading);
                    _scrollToSection(heading);
                  },
                );
              },
            ),
            SliverToBoxAdapter(
              child: HomeSection(
                key: _sectionKeys["Home"],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 64),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  height: 256,
                  child: VerticalDivider(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    thickness: 3,
                    width: 64,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ProfileSection(
                key: _sectionKeys["Profile"],
              ),
            ),
            SliverToBoxAdapter(
              child: ExperienceSection(
                key: _sectionKeys["Experience"],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _scrollToSection(String section) {
    final key = _sectionKeys[section];

    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrolledHeaderListener() {
    for (var entry in SectionHeaders.title.reversed) {
      final key = _sectionKeys[entry];

      if (key?.currentContext != null) {
        final context = key!.currentContext!;

        final box = context.findRenderObject() as RenderBox?;

        if (box != null) {
          final offset = box.localToGlobal(Offset.zero).dy;

          if (offset < 500) {
            _headerController.sink.add(entry);
            break;
          }
        }
      }
    }
  }
}
