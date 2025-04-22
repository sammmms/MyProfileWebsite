import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:website/components/my_appbar.dart';
import 'package:website/section_home/home_section.dart';
import 'package:website/utils/store.dart';
import 'package:website/utils/theme_notifier.dart';

// This is a Flutter Web Application that are built to show a portfolio of a developer.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Store.initialize();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final StreamController<String> _controller = StreamController<String>();
  final ThemeNotifier _themeNotifier = ThemeNotifier();

  final Map<String, GlobalKey> _sectionKeys = {
    "Home": GlobalKey(),
    "Profile": GlobalKey(),
    "Experience": GlobalKey(),
    "Education": GlobalKey(),
    "Projects": GlobalKey(),
    "Skills": GlobalKey(),
    "Achievements": GlobalKey(),
    "Contact": GlobalKey(),
  };

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _themeNotifier,
      child: Builder(builder: (context) {
        return MaterialApp(
          theme: context.watch<ThemeNotifier>().theme,
          home: Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/home_background.jpg"),
                  fit: BoxFit.cover,
                  opacity: 0.2,
                  repeat: ImageRepeat.noRepeat,
                ),
              ),
              child: NestedScrollView(
                key: _sectionKeys["Home"],
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    StreamBuilder(
                      stream: _controller.stream,
                      builder: (context, snapshot) {
                        return MyAppBar(
                          selectedHeading: snapshot.data ?? "Home",
                          onChangeTheme: changeTheme,
                          onTap: (String heading) {
                            _controller.sink.add(heading);
                            _scrollToSection(heading);
                          },
                        );
                      },
                    )
                  ];
                },
                body: const Column(
                  children: [
                    HomeSection(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  void changeTheme() {
    _themeNotifier.changeTheme();
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
}
