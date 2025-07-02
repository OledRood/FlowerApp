import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/message/message_di.dart';
import '../../core/navigation/navigation_di.dart';
import 'domain/flower_info_state.dart';
import 'models/flower_info_view_model.dart';

class FlowerInfoDi {
  static final flowerInfoViewModelProvider = StateNotifierProvider.autoDispose
      .family<FlowerInfoViewModel, FlowerInfoState, String>((ref, flowerId) {
        // final dbHelper = DatabaseHelper.instance;
        final navigator = ref.watch(NavigationDi.appNavigator);
        final scaffoldMessage = ref.watch(MessageDi.scaffoldMessengerManager);
        return FlowerInfoViewModel(navigator, flowerId, scaffoldMessage);
      });
}
