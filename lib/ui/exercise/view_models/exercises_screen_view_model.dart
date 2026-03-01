import 'package:flutter/material.dart';
import 'package:training_note/domain/models/exercise.dart';

class ExercisesViewModel extends ValueNotifier<List<Exercise>> {
  ExercisesViewModel(List<Exercise>? exercises) : super(exercises ?? []);

  void createExercise(String name) {
    //value - сеттер оповещает автоматически всех подписчиков об изменении value (стейта)
    final newExercise =
        Exercise(name: name, id: DateTime.now().millisecondsSinceEpoch);
    value = [...value, newExercise];
  }

  void updateExercise(int id, String newName) {
    final index = value.indexWhere((e) => e.id == id);
    // if (index == -1) return;
    final updated = value[index].copyWith(name: newName);
    final newList = [...value];
    newList[index] = updated;
    value = newList;
  }

  void deleteExercise(int id) {
    value = value.where((e) => e.id != id).toList();
  }
}

final ExercisesViewModel exercisesViewModel =
    ExercisesViewModel(excercisesStub);
