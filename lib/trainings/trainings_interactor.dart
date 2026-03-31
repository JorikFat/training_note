import 'dart:async';

import 'package:drift/drift.dart';
import 'package:training_note/data/database.dart';
import 'package:training_note/trainings/training.dart';
import 'package:training_note/ui/training/view_model/trainings_screen_view_model.dart';

late final TrainingsInteractor trainings;

class TrainingsInteractor {
  final AppDatabase database;
  List<Training>? trainings;

  final StreamController<List<Training>> streamController =
      StreamController.broadcast();

  TrainingsInteractor({required this.database});

  Stream<List<Training>> get stream => streamController.stream;

  Future<void> init() async {
    final oldTrainings = await TrainingsScreenViewModel.read(database);
    trainings = oldTrainings.map(Training.interrop).toList();
    streamController.add(trainings!);
  }

  void close() {
    streamController.close();
  }

  //FIXME: pass training date
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
}
