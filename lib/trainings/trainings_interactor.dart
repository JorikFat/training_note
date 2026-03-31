import 'dart:async';
import 'dart:developer';

import 'package:training_note/data/database.dart';
import 'package:training_note/domain/models/approach.dart';
import 'package:training_note/domain/models/training.dart' as old;
import 'package:training_note/domain/models/exercise.dart';
import 'package:training_note/trainings/training.dart';

late final TrainingsInteractor trainings;

class TrainingsInteractor {
  final AppDatabase database;
  List<Training>? trainings;

  final StreamController<List<Training>?> streamController =
      StreamController.broadcast();

  TrainingsInteractor({required this.database}){
    stream.listen((trainings) => log(trainings.toString()));
  }

  Stream<List<Training>?> get stream => streamController.stream;

  Future<void> init() async {
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

    final oldTrainings = trainings.map((e) {
      final approach = approachesByID[e.id] ?? [];
      return old.Training(id: e.id, date: e.date, approach: approach);
    }).toList();
    this.trainings = oldTrainings.map(Training.interrop).toList();
    streamController.add(this.trainings);
  }

  void close() {
    streamController.close();
  }
}
