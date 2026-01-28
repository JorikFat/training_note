import 'package:flutter/material.dart';
import 'package:training_note/common/my_elevated.dart';
import 'package:training_note/excercises_screen.dart';

class ExercisesCreate extends StatefulWidget {
  const ExercisesCreate({super.key});

  @override
  State<ExercisesCreate> createState() => _ExercisesCreateState();
}

class _ExercisesCreateState extends State<ExercisesCreate> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextField(
        controller: _textController,
        decoration: InputDecoration(hintText: 'Создать тренировку'),
      ),
      actions: [
        MyElevated.cancel(
          onPressed: () => Navigator.pop(context),
        ),
        MyElevated.create(
          onPressed: () {
            setState(() {
              excercisesStub.add(_textController.text);
              _textController.clear();
              Navigator.pop(context);
            });
          },
        ),
      ],
    );
  }
}
