import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key, required this.text});
  final String text;

  const EmptyScreen.training({super.key})
      : text = 'Вы не записали ни одной тренировки';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(text),
        )
      ],
    );
  }
}
