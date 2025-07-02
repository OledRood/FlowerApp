import 'package:flowers_app/core/message/scaffold_messenger_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageDi {
  MessageDi._();

  static final scaffoldMessengerManager = Provider(
        (ref) => ScaffoldMessengerManager(),
  );
}
