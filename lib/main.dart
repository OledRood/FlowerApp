import 'package:flowers_app/test/view/home_page.dart';
import 'package:flowers_app/theme/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home/view/home_page.dart';
import 'notification/notification.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      themeMode: ThemeMode.dark,
      navigatorObservers: [routeObserver], // Добавляем RouteObserver
    // home: TestPage(),
      home: HomePage(),
    );
  }
}
