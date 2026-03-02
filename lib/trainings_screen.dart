import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:training_note/common/empty_screen.dart';
import 'package:training_note/date_formating_extension.dart';
import 'package:training_note/empty_training.dart';
import 'package:training_note/training_details_screen.dart';
import 'package:training_note/models/training.dart';

class TrainingsScreen extends StatelessWidget {
  const TrainingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: trainings.isEmpty
          ? EmptyScreen.training()
          : ListView.separated(
              itemCount: trainings.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                          builder: (context) => TrainingDetailsScreen(
                                trainings: trainings[index],
                              )));
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
