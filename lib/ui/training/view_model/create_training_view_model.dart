import 'package:flutter/cupertino.dart';
import 'package:training_note/data/database.dart';
import 'package:training_note/domain/models/approach.dart';
import 'package:training_note/domain/models/exercise.dart';
import 'package:training_note/domain/models/training.dart';
import 'package:training_note/trainings/trainings_interactor.dart';
import 'package:training_note/ui/training/models/training_entry.dart';
import 'package:training_note/ui/training/view_model/trainings_screen_view_model.dart';

class CreateTrainingViewModel extends ChangeNotifier {
  CreateTrainingViewModel(this.database) {
    addTrainingEntry();
  }
  final AppDatabase database;
  final List<TrainingEntry> _entries = [];

//установить упражнение и повторения по индексу
  Future<void> setTrainingEntry(
      Exercise exercise, int repeats, int index) async {
    _entries[index] = TrainingEntry(excercise: exercise, repeats: repeats);
    notifyListeners();
  }

//добавить пустую тренировку(drop)
  Future<void> addTrainingEntry() async {
    _entries.add(TrainingEntry(excercise: null, repeats: 0));
    notifyListeners();
  }

//удалить пустую тренировку drop
  Future<void> removeTrainingEntry(int index) async {
    _entries.removeAt(index);
    notifyListeners();
  }

  List<TrainingEntry> get entries => _entries;

//создать тренировку
  Future<Training?> _create() async {
    final valid =
        _entries.where((x) => x.excercise != null && x.repeats! > 0).toList();

    if (valid.isEmpty) {
      return null;
    }
    //создать тренировку в бд
    final trainingCompanion = await trainings.add();
//создать подходы в бд
    for (var approach in valid) {
      await database.into(database.approachData).insert(
          ApproachDataCompanion.insert(
              trainingId: trainingCompanion.id,
              exerciseId: approach.excercise!.id,
              repeats: approach.repeats!));
    }

//создать подходы в ui
    final approaches = valid
        .map((entry) =>
            Approach(excercise: entry.excercise!, repeats: entry.repeats!))
        .toList();

    final training = Training(
        date: trainingCompanion.date,
        approach: approaches,
        id: trainingCompanion.id);
    await trainings.init();
    return training;
  }

//сохранить тренировку
  Future<void> save() async {
    final training = await _create();
    if (training != null) {
      trainingsScreenViewModel.value = [
        ...trainingsScreenViewModel.value,
        training
      ];
    }
  }
}
