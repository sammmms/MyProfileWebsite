import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:website/homepage.dart';
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
  final ThemeNotifier _themeNotifier = ThemeNotifier();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _themeNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _themeNotifier,
      child: Builder(
        builder: (context) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              scrollBehavior: MyCustomScrollBehavior(),
              title: "Samuel Onasis | Portfolio",
              theme: context.watch<ThemeNotifier>().theme,
              home: const Homepage());
        },
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    // Replace this with your custom scrollbar
    return Scrollbar(
      controller: details.controller,
      radius: const Radius.circular(8),
      thickness: 4,
      interactive: false,
      thumbVisibility: true, // Force it to be visible
      child: child,
    );
  }
}
