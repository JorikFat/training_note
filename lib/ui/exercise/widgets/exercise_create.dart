import 'package:flutter/material.dart';
import 'package:training_note/ui/common/my_elevated.dart';

class ExerciseCreate extends StatefulWidget {
  const ExerciseCreate({super.key});

  @override
  State<ExerciseCreate> createState() => _ExerciseCreateState();
}

class _ExerciseCreateState extends State<ExerciseCreate> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextField(
        controller: _textController,
        decoration: InputDecoration(hintText: 'Создать упражнение'),
      ),
      actions: [
        MyElevated.cancel(
          onPressed: () => Navigator.pop(context),
        ),
        MyElevated.create(
          onPressed: () {
            setState(() {
              final name = _textController.text;
              if (name.isEmpty) return;
              Navigator.pop(context, name);
            });
          },
        ),
      ],
    );
  }
}
