import 'dart:async';

import 'package:training_note/data/database.dart';
import 'package:training_note/trainings/training.dart';
import 'package:training_note/trainings/trainings_drift_dao.dart';

late final CompatTrainingsInteractor trainings;

//специальный класс совместимости, чтобы в него вынести все сомнительные решения
//а после их исправления вернуть родительский TrainingsInteractor
class CompatTrainingsInteractor extends TrainingsInteractor {

  CompatTrainingsInteractor({required super.database}) :super._();


  @deprecated
  Future<TrainingDataData> add() async {
    return trainingsDao.createEmpty(DateTime.now());
  }
}

//TODO: remake to Notifier
class TrainingsInteractor {
  final CompatTrainingsDriftDao trainingsDao; //TODO: pass TrainingsDao
  List<Training>? trainings;

  final StreamController<List<Training>> streamController =
      StreamController.broadcast();

  //конструктор намеренно сделал приватным, чтобы подсветились все места 
  //где использовался до этого публичный и заменить его на Compat
  TrainingsInteractor._({required AppDatabase database})
      : trainingsDao = CompatTrainingsDriftDao(database);

  Stream<List<Training>> get stream => streamController.stream;

  Future<void> init() async {
    trainings = await trainingsDao.get();
    streamController.add(trainings!);
  }

  void close() {
    streamController.close();
  }

  Future<void> create(DateTime date) async {
    final Training training = TrainigDraft(date: date);
    await trainingsDao.add(training);
  }

  Future<void> delete(int id) async {
    final Training training = trainings!.firstWhere((it) => it.id == id);
    await trainingsDao.remove(training);
    _update(trainings!.toList()..remove(training));
  }

  void _update(List<Training> data) {
    trainings = data;
    streamController.add(trainings!);
  }
}

abstract interface class TrainingsDao {
  // Stream<List<Training>> watch();
  Future<List<Training>> get();
  Future<void> add(Training training);
  Future<void> set(Training training);
  Future<void> remove(Training training);
}
