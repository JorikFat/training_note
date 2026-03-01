import 'package:flutter/material.dart';
import 'package:training_note/ui/common/my_elevated.dart';
import 'package:training_note/domain/models/exercise.dart';

class ExerciseEdit extends StatefulWidget {
  const ExerciseEdit({
    super.key,
    required this.exercise,
    required this.onDelete,
    required this.onUpdate,
  });

  final Exercise exercise;
  final void Function() onDelete;
  final void Function(String newName) onUpdate;

  @override
  State<ExerciseEdit> createState() => _ExerciseEditState();
}

class _ExerciseEditState extends State<ExerciseEdit> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: (widget.exercise.name),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyElevated.close(
              onPressed: () => Navigator.pop(context),
            ),
            MyElevated.delete(
              onPressed: () {
                widget.onDelete();
                Navigator.pop(context);
              },
            ),
          ],
        ),
        Center(
          child: MyElevated.update(
            onPressed: () {
              final name = controller.text;
              widget.onUpdate(name);
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
