import 'package:flutter/material.dart';
import 'package:training_note/trainings/list/trainings_list_notifier.dart';
import 'package:training_note/trainings/list/trainings_list_widget.dart';
import 'package:training_note/trainings/trainings_interactor.dart';
import 'package:training_note/ui/training/widgets/create_training.dart'; //FIXME
import 'package:training_note/ui/training/widgets/training_details_screen.dart'; //FIXME

class TrainingsScreen extends StatefulWidget {
  const TrainingsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TrainingsScreen> {
  final notifier = TrainingsListNotifier(interactor: trainings);

  @override
  void dispose() {
    super.dispose();
    notifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
          valueListenable: notifier,
          builder: (context, value, _) =>
              TrainingsListWidget(state: value, onSelect: clickOnTraining),
        ),
        floatingActionButton: _AddButton());
  }

  Future<void> clickOnTraining(TrainingViewModel model) async {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => TrainingDetailsScreen(id: model.id),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CreateTraining(),
          ),
        );
      },
      child: Icon(Icons.add),
    );
  }
}
