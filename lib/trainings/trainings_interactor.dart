import 'dart:async';

import 'package:drift/drift.dart';
import 'package:training_note/data/database.dart';
import 'package:training_note/trainings/training.dart';
import 'package:training_note/trainings/trainings_accessor.dart';

late final TrainingsInteractor trainings;

class TrainingsInteractor {
  final TrainingsAccessor database; //TODO: pass TrainingsDao
  List<Training>? trainings;

  final StreamController<List<Training>> streamController =
      StreamController.broadcast();

  TrainingsInteractor({required AppDatabase database})
      : database = TrainingsAccessor(database);

  Stream<List<Training>> get stream => streamController.stream;

  Future<void> init() async {
    trainings = await database.read();
    streamController.add(trainings!);
  }

  void close() {
    streamController.close();
  }

  @deprecated
  Future<TrainingDataData> add() async {
    final result = await database
        .into(database.trainingData)
        .insertReturning(TrainingDataCompanion(date: Value(DateTime.now())));
    return result;
  }

  Future<void> create(DateTime date) async {
    final Training training = TrainigDraft(date: date);
    await database.create(training);
  }

  Future<void> delete(int id) async {
    final Training training = trainings!.firstWhere((it) => it.id == id);
    await database.remove(training);
    _update(trainings!.toList()..remove(training));
  }

  void _update(List<Training> data) {
    trainings = data;
    streamController.add(trainings!);
  }
}

abstract interface class TrainingsDao {
  // Stream<List<Training>> watch();
  Future<List<Training>> read();
  Future<void> remove(Training training);
  Future<void> edit(Training training);
  Future<void> create(Training training);
}
