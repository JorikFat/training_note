import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:training_note/common/empty_screen.dart';
import 'package:training_note/exercise_create.dart';
import 'package:training_note/exercise_edit.dart';
import 'package:training_note/models/exercise.dart';
import 'package:training_note/view_models/exercises_view_model.dart';

class ExcercisesScreen extends StatelessWidget {
  const ExcercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<List<Exercise>>(
          valueListenable: exercisesViewModel,
          builder: (context, value, child) {
            return value.isEmpty
                ? EmptyScreen.exercise()
                : ListView.separated(
                    itemCount: value.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) => ExerciseEdit(
                                  exercise: value[index],
                                  onDelete: () {
                                    exercisesViewModel
                                        .deleteExercise(value[index].id);
                                  },
                                  onUpdate: (newName) {
                                    exercisesViewModel.updateExercise(
                                        value[index].id, newName);
                                  },
                                ));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(value[index].name),
                        ),
                      ),
                    ),
                  );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          log('excercise add');
          final result = await showDialog(
              context: context, builder: (context) => ExerciseCreate());
          if (result == null) return;
          exercisesViewModel.createExercise(result);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
