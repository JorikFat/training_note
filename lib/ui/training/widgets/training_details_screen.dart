import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_note/ui/common/date_formating_extension.dart';
import 'package:training_note/domain/models/training.dart';

class TrainingDetailsScreen extends StatefulWidget {
  const TrainingDetailsScreen(
      {super.key, required this.training, required this.index});

  final Training training;
  final int index;

  @override
  State<TrainingDetailsScreen> createState() => _TrainingDetailsScreenState();
}

class _TrainingDetailsScreenState extends State<TrainingDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                trainings.removeAt(widget.index);
                Navigator.pop(context);
              },
              icon: Icon(
                CupertinoIcons.delete,
              ))
        ],
        title: Text(widget.training.date.formatData()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ...widget.training.approach.map(
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
