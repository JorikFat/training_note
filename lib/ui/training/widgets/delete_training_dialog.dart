import 'package:flutter/material.dart';
import 'package:training_note/domain/models/training.dart';
import 'package:training_note/ui/common/date_formating_extension.dart';
import 'package:training_note/ui/common/my_elevated.dart';

class DeleteTrainingDialog extends StatelessWidget {
  const DeleteTrainingDialog(
      {super.key, required this.training, required this.onDelete});
  final Training training;
  final void Function() onDelete;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
                text: 'Удалить тренировку',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: training.date.formatData()),
            TextSpan(text: '?'),
          ],
        ),
      ),
      actions: [
        MyElevated.cancel(
          onPressed: () => Navigator.pop(context),
        ),
        MyElevated.delete(
          onPressed: () {
            onDelete();
            Navigator.pop(
              context,
            );
          },
        ),
      ],
    );
  }
}
