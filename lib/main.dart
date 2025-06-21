import 'package:flowers_app/test/view/home_page.dart';
import 'package:flowers_app/ui/theme/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/navigation/app_router_factory.dart';
import 'core/navigation/navigation_di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appNavigator = ref.watch(NavigationDi.appNavigator);

    return MaterialApp.router(
      theme: darkTheme,
      themeMode: ThemeMode.dark,
      routerConfig: appNavigator.routerConfig,
    );
  }
}
