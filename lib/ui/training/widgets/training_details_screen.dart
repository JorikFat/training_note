import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_note/ui/common/date_formating_extension.dart';
import 'package:training_note/domain/models/training.dart';

class TrainingDetailsScreen extends StatelessWidget {
  const TrainingDetailsScreen(
      {super.key, required this.trainings, required this.delete});

  final Training trainings;
  final void Function() delete;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                delete();
                Navigator.pop(context);
              },
              icon: Icon(
                CupertinoIcons.delete,
              ))
        ],
        title: Text(trainings.date.formatData()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ...trainings.approach.map(
              (e) => Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      e.excercise.name,
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '${e.repeats} повторений',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
