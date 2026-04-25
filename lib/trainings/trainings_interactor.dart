import 'dart:async';

import 'package:drift/drift.dart';
import 'package:training_note/data/database.dart';
import 'package:training_note/trainings/training.dart';
import 'package:training_note/trainings/trainings_accessor.dart';

late final TrainingsInteractor trainings;

class TrainingsInteractor {
  final TrainingsAccessor database;
  List<Training>? trainings;
  late final StreamSubscription _sub;

  final StreamController<List<Training>> streamController =
      StreamController.broadcast();

  TrainingsInteractor({required AppDatabase database})
      : database = TrainingsAccessor(database) {
    _sub = this.database.watch().listen(_onUpdate);
  }

  Stream<List<Training>> get stream => streamController.stream;

  Future<void> init() async {
    trainings = await database.read();
    streamController.add(trainings!);
  }

  void close() {
    streamController.close();
    _sub.cancel();
  }

  //TODO: pass training date
  Future<TrainingDataData> add() async {
    final result = await database
        .into(database.trainingData)
        .insertReturning(TrainingDataCompanion(date: Value(DateTime.now())));
    return result;
  }

  Future<void> delete(int id) async {
    await (database.delete(database.trainingData)
          ..where((t) => t.id.equals(id)))
        .go();
  }

  void _onUpdate(List<Training> data) {
    trainings = data;
    streamController.add(trainings!);
  }
}
