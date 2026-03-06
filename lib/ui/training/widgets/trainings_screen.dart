import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:training_note/ui/common/empty_screen.dart';
import 'package:training_note/ui/common/date_formating_extension.dart';
import 'package:training_note/ui/training/view_model/trainings_screen_view_model.dart';
import 'package:training_note/ui/training/widgets/create_training.dart';
import 'package:training_note/ui/training/widgets/delete_training_dialog.dart';
import 'package:training_note/ui/training/widgets/training_details_screen.dart';

class TrainingsScreen extends StatefulWidget {
  const TrainingsScreen({
    super.key,
  });

  @override
  State<TrainingsScreen> createState() => _TrainingsScreenState();
}

class _TrainingsScreenState extends State<TrainingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: trainingsScreenViewModel,
          builder: (context, value, child) {
            return value.isEmpty
                ? EmptyScreen.training()
                : ListView.separated(
                    itemCount: value.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                                builder: (context) => TrainingDetailsScreen(
                                      training: value[index],
                                    )));
                        setState(() {});
                      },
                      onLongPress: () async {
                        await showDialog(
                            context: context,
                            builder: (context) => DeleteTrainingDialog(
                                  training: value[index],
                                  onDelete: () {
                                    trainingsScreenViewModel
                                        .deleteTraining(value[index].id);
                                  },
                                ));
                        setState(() {});
                      },
                      child: Card(
                        child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Дата тренировки: ${value[index].date.formatData()}'),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    'Количество подходов: ${value[index].approach.length}'),
                              ],
                            )),
                      ),
                    ),
                  );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => CreateTraining()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void add() {
    log('trainings add');
  }
}
