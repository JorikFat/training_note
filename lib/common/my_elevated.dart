import 'package:flutter/material.dart';

class MyElevated extends StatelessWidget {
  const MyElevated(
      {super.key,
      this.backgroundColor,
      this.foregroundColor,
      required this.text,
      this.onPressed});
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String text;
  final void Function()? onPressed;

  const MyElevated.create({super.key, this.onPressed})
      : foregroundColor = Colors.white,
        backgroundColor = Colors.deepPurple,
        text = 'Создать';
  const MyElevated.cancel({super.key, this.onPressed})
      : foregroundColor = Colors.white,
        backgroundColor = Colors.red,
        text = 'Отмена';

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor, foregroundColor: foregroundColor),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 18),
        ));
  }
}
