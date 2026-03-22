import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:training_note/data/database.dart';
import 'package:training_note/domain/models/exercise.dart';

class ExercisesScreenViewModel extends ValueNotifier<List<Exercise>> {
  ExercisesScreenViewModel(super._value, {required this.database});
  final AppDatabase database;

  Future<void> load() async {
    final rows = await database.select(database.exerciseData).get();
    value = rows.map((e) => Exercise(name: e.name, id: e.id)).toList();
  }

  Future<void> create(String name) async {
    final insertedRow = await database
        .into(database.exerciseData)
        .insertReturning(ExerciseDataCompanion(name: Value(name)));
    final createdExercise =
        Exercise(name: insertedRow.name, id: insertedRow.id);
    value = [...value, createdExercise];
  }

  // Stream<List<ExerciseDataData>> read() async* {
  //   database.select(database.exerciseData).watch();
  //   value = value.((e) => e.name).toList();
  // }

  //   //value - сеттер оповещает автоматически всех подписчиков об изменении value (стейта)

  Future<void> update(int id, String newName) async {
    final current = database.update(database.exerciseData);
    current.where((e) => e.id.equals(id));
    final updated = await current.write(
      ExerciseDataCompanion(
        name: Value(newName),
      ),
    );
    if (updated == 0) return;
    final index = value.indexWhere((e) => e.id == id);
    if (index == -1) return;
    final updatedValue = value[index].copyWith(name: newName);
    final newList = [...value];
    newList[index] = updatedValue;
    value = newList;
  }

  Future<void> delete(int id) async {
    final trackedId = database.delete(database.exerciseData);
    trackedId.where((e) => e.id.equals(id));
    //удаление
    await trackedId.go();
    value = value.where((e) => e.id != id).toList();
  }
}

late final ExercisesScreenViewModel exercisesScreenViewModel;
