import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_navigator.dart';
import 'app_router_factory.dart';

class NavigationDi {
  NavigationDi._();

  static final _appRouterFactory = Provider((ref) => AppRouterFactory());

  // static final appLinksLauncher = Provider(
  //       (ref) => AppLinksLauncher(ref.watch(ConfigDi.appLinks.notifier)),
  // );

  static final appNavigator = Provider(
        (ref) => AppNavigator(ref.watch(_appRouterFactory)),
  );}
