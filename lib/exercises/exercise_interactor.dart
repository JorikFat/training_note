import 'dart:async';

import 'package:training_note/data/database.dart';
import 'package:training_note/exercises/exercise.dart';
import 'package:training_note/exercises/exercises_accessor.dart';

late final ExerciseInteractor trainings;

class ExerciseInteractor {
  final ExercisesAccessor database;
  List<Exercise>? exercises;

  final StreamController<List<Exercise>> streamController =
      StreamController.broadcast();

  ExerciseInteractor({required AppDatabase database})
      : database = ExercisesAccessor(database);

  Stream<List<Exercise>> get stream => streamController.stream;

  Future<void> init() async {
    exercises = await database.get();
    streamController.add(exercises!);
  }

  void close() {
    streamController.close();
  }

  @deprecated
  Future<ExerciseDataData> add() async {
    final result = await database
        .into(database.attachedDatabase.exerciseData)
        .insertReturning(ExerciseDataCompanion());
    return result;
  }

  Future<void> create(DateTime date) async {
    final Exercise exercise = ExerciseDraft();
    await database.add(exercise);
  }

  Future<void> delete(int id) async {
    final Exercise exercise = exercises!.firstWhere((it) => it.id == id);
    await database.remove(exercise);
    _update(exercises!.toList()..remove(exercise));
  }

  void _update(List<Exercise> data) {
    exercises = data;
    streamController.add(exercises!);
  }
}

abstract interface class ExercisesDao {
  Future<List<Exercise>> get();
  Future<void> remove(Exercise exercise);
  Future<void> replace(Exercise exercise);
  Future<void> add(Exercise exercise);
}
