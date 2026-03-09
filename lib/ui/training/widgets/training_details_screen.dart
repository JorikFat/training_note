import 'package:flutter/material.dart';
import 'package:training_note/ui/common/date_formating_extension.dart';
import 'package:training_note/domain/models/training.dart';
import 'package:training_note/ui/training/view_model/trainings_screen_view_model.dart';

class TrainingDetailsScreen extends StatelessWidget {
  const TrainingDetailsScreen({
    super.key,
    required this.training,
  });

  final Training training;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                trainingsScreenViewModel.deleteTraining(training.id);
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.delete_outline_outlined,
              ))
        ],
        title: Text(training.date.formatData()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ...training.approach.map(
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
