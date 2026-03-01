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

  const MyElevated.create({
    super.key,
    this.onPressed,
  })  : foregroundColor = Colors.white,
        backgroundColor = Colors.green,
        text = 'Создать';
  const MyElevated.cancel({super.key, this.onPressed})
      : foregroundColor = Colors.white,
        backgroundColor = Colors.grey,
        text = 'Отмена';

  const MyElevated.delete({
    super.key,
    this.onPressed,
  })  : foregroundColor = Colors.white,
        backgroundColor = Colors.red,
        text = 'Удалить';
  const MyElevated.close({
    super.key,
    this.onPressed,
  })  : foregroundColor = Colors.white,
        backgroundColor = Colors.blueGrey,
        text = 'Закрыть';
  const MyElevated.update({
    super.key,
    this.onPressed,
  })  : foregroundColor = Colors.white,
        backgroundColor = Colors.blueAccent,
        text = 'Обновить';
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
