import 'dart:async';

import 'package:flutter/material.dart';
import 'package:website/components/my_appbar.dart';
import 'package:website/sections/home_section.dart';
import 'package:website/sections/profile_section.dart';
import 'package:website/utils/section_headers.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final StreamController<String> _controller = StreamController<String>();
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
    _controller.close();
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
            StreamBuilder(
              stream: _controller.stream,
              builder: (context, snapshot) {
                return MyAppBar(
                  selectedHeading: snapshot.data ?? "Home",
                  onTap: (String heading) {
                    _controller.sink.add(heading);
                    _scrollToSection(heading);
                  },
                );
              },
            ),
            const SliverToBoxAdapter(
              child: HomeSection(
                key: Key("Home"),
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
              child: SizedBox(
                height: 256,
                child: VerticalDivider(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  thickness: 3,
                  width: 64,
                ),
              ),
            ),
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
    for (var entry in SectionHeaders.headings.reversed) {
      final key = _sectionKeys[entry];

      if (key?.currentContext != null) {
        final context = key!.currentContext!;

        final box = context.findRenderObject() as RenderBox?;

        if (box != null) {
          final offset = box.localToGlobal(Offset.zero).dy;

          if (offset < 500) {
            _controller.sink.add(entry);
            break;
          }
        }
      }
    }
  }
}
