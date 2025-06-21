import 'package:flutter/material.dart';

class YellowButtonWidget extends StatelessWidget {
  VoidCallback onPressedAction;

  YellowButtonWidget({super.key, required this.onPressedAction});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: TextButton(
          onPressed: onPressedAction,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.add), Text('Добавить')],
            ),
          ),
        ),
      ),
    );
  }
}
