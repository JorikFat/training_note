import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:training_note/data/database.dart';
import 'package:training_note/domain/models/approach.dart';
import 'package:training_note/domain/models/exercise.dart';
import 'package:training_note/domain/models/training.dart';
import 'package:training_note/trainings/trainings_interactor.dart';

class TrainingsScreenViewModel extends ValueNotifier<List<Training>> {
  TrainingsScreenViewModel(super._value, {required this.database});
  final AppDatabase database;

//загрузка
  Future<void> load() async {
    value = await read(database);
  }

  static Future<List<Training>> read(AppDatabase database) async {
    final exercises = await database.select(database.exerciseData).get();
    final trainings = await database.select(database.trainingData).get();
    final approaches = await database.select(database.approachData).get();
    final Map<int, Exercise> exercisesMap = {
      for (var e in exercises) e.id: Exercise(id: e.id, name: e.name),
    };
    final Map<int, List<Approach>> approachesByID = {};
    for (var approachData in approaches) {
      final exercise = exercisesMap[approachData.exerciseId];
      if (exercise != null) {
        final approach = Approach(
          excercise: exercise,
          repeats: approachData.repeats,
        );

        approachesByID
            .putIfAbsent(approachData.trainingId, () => [])
            .add(approach);
      }
    }

    return trainings.map((e) {
      final approach = approachesByID[e.id] ?? [];
      return Training(id: e.id, date: e.date, approach: approach);
    }).toList();
  }

//создать
  Future<void> create(List<Approach> approaches) async {
    final insectRowTraining = await database
        .into(database.trainingData)
        .insertReturning(TrainingDataCompanion(date: Value(DateTime.now())));

    for (var approach in approaches) {
      await database.into(database.approachData).insert(
          ApproachDataCompanion.insert(
              trainingId: insectRowTraining.id,
              exerciseId: approach.excercise.id,
              repeats: approach.repeats));
    }
    final newTraining = Training(
        date: insectRowTraining.date,
        approach: approaches,
        id: insectRowTraining.id);
    value = [...value, newTraining];
  }

  Future<void> updateTraining(
      DateTime date, List<Approach> approaches, int id) async {
    for (var approach in approaches) {
      database.into(database.approachData).insert(ApproachDataCompanion.insert(
          trainingId: id,
          exerciseId: approach.excercise.id,
          repeats: approach.repeats));
    }
// обновить UI
    final index = value.indexWhere((e) => e.id == id);
    final updated = value[index].copyWith(date: date, approach: approaches);
    final newList = [...value];
    newList[index] = updated;
    value = newList;
  }

//удаление
  Future<void> deleteTraining(int id) async {
    //удалить связанныые подходы
    final deleteApproach = database.delete(database.approachData)
      ..where((t) => t.trainingId.equals(id));
    await deleteApproach.go();
    //удалить тренировку по id
    await trainings.delete(id);
    //обновить ui
    value = value.where((e) => e.id != id).toList();
    await trainings.init();
  }
}

late final TrainingsScreenViewModel trainingsScreenViewModel;
