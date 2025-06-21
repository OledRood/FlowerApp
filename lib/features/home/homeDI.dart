import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/navigation/navigation_di.dart';
import 'domain/home_view_model.dart';
import 'models/home_state.dart';

final class HomeDi {
  HomeDi._();

  // View Models
  static final homeViewModel =
      StateNotifierProvider.autoDispose<HomeViewModel, HomeState>(
        (ref) => HomeViewModel(ref.watch(NavigationDi.appNavigator)),
      );
}
