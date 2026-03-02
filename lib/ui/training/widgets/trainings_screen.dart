import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:training_note/ui/common/empty_screen.dart';
import 'package:training_note/ui/common/date_formating_extension.dart';
import 'package:training_note/ui/training/widgets/empty_training.dart';
import 'package:training_note/ui/training/widgets/training_details_screen.dart';
import 'package:training_note/domain/models/training.dart';

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
      body: trainings.isEmpty
          ? EmptyScreen.training()
          : ListView.separated(
              itemCount: trainings.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) => InkWell(
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                          builder: (context) => TrainingDetailsScreen(
                              training: trainings[index], index: index)));
                  setState(() {});
                },
                child: Card(
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Дата тренировки: ${trainings[index].date.formatData()}'),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                              'Количество подходов: ${trainings[index].approach.length}'),
                        ],
                      )),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          add();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => EmptyTraining()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void add() {
    log('trainings add');
  }
}
