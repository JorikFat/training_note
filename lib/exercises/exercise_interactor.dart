import 'dart:async';

import 'package:training_note/data/database.dart';
import 'package:training_note/exercises/exercise.dart';
import 'package:training_note/exercises/exercise_accessor.dart';

late final TrainingsInteractor trainings;

class TrainingsInteractor {
  final ExerciseAccessor database;
  List<Exercise>? exercises;

  final StreamController<List<Exercise>> streamController =
      StreamController.broadcast();

  TrainingsInteractor({required AppDatabase database})
      : database = ExerciseAccessor(database);

  Stream<List<Exercise>> get stream => streamController.stream;

  Future<void> init() async {
    exercises = await database.read();
    streamController.add(exercises!);
  }

  void close() {
    streamController.close();
  }

  @deprecated
  Future<ExerciseDataData> add() async {
    final result = await database
        .into(database.exerciseData)
        .insertReturning(ExerciseDataCompanion());
    return result;
  }

  Future<void> create(DateTime date) async {
    final Exercise exercise = ExerciseDraft();
    await database.create(exercise);
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
