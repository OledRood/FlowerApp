import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/message/message_di.dart';
import '../../core/navigation/navigation_di.dart';
import 'domain/add_flower_state.dart';
import 'models/add_flower_view_model.dart';

class AddFlowerDi {
  AddFlowerDi._();

  static final addFlowerViewModelProvider = StateNotifierProvider.autoDispose<AddFlowerViewModel, AddFlowerState>((ref) {
    final navigator = ref.watch(NavigationDi.appNavigator);
    final scaffoldMessage = ref.watch(MessageDi.scaffoldMessengerManager);
    return AddFlowerViewModel(navigator, scaffoldMessage);
  });
} 
