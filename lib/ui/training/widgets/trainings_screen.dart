import 'package:flutter/material.dart';
import 'package:training_note/data/database.dart';
import 'package:training_note/trainings/list/trainings_list_notifier.dart';
import 'package:training_note/trainings/list/trainings_list_widget.dart';
import 'package:training_note/trainings/training.dart';
import 'package:training_note/trainings/trainings_interactor.dart';
import 'package:training_note/ui/training/widgets/create_training.dart';
import 'package:training_note/ui/training/widgets/training_details_screen.dart';

class TrainingsScreen extends StatefulWidget {
  const TrainingsScreen({
    super.key,
    required this.database,
  });
  final AppDatabase database;
  @override
  State<TrainingsScreen> createState() => _TrainingsScreenState();
}

class _TrainingsScreenState extends State<TrainingsScreen> {
  final trainingsNotifier = TrainingsListNotifier(interactor: trainings);

  @override
  void dispose() {
    trainingsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: trainingsNotifier,
          builder: (context, value, _) {
            return TrainingsListWidget(
              state: value,
              onSelect: clickOnTraining,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CreateTraining(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> clickOnTraining(TrainingViewModel model) async {
    final Training training =
        trainings.trainings!.firstWhere((it) => it.id == model.id);
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => TrainingDetailsScreen(id: training.id),
      ),
    );
  }
}
