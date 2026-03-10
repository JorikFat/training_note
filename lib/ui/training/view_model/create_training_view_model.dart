import 'package:flutter/cupertino.dart';
import 'package:training_note/domain/models/approach.dart';
import 'package:training_note/domain/models/exercise.dart';
import 'package:training_note/domain/models/training.dart';
import 'package:training_note/ui/training/models/training_entry.dart';

class CreateTrainingViewModel extends ChangeNotifier {
  CreateTrainingViewModel() {
    addTrainingEntry();
  }
  final List<TrainingEntry> _entries = [];

//установить упражнение и повторения по индексу
  void setTrainingEntry(Exercise exercise, int repeats, int index) {
    _entries[index] = TrainingEntry(excercise: exercise, repeats: repeats);
    notifyListeners();
  }

//добавть drop
  void addTrainingEntry() {
    _entries.add(TrainingEntry(excercise: null, repeats: 0));
    notifyListeners();
  }

//удалить drop
  void removeTrainingEntry(int index) {
    _entries.removeAt(index);
    notifyListeners();
  }

  List<TrainingEntry> get entries => _entries;

//сохраненить тренировку
  Training? _create() {
    final valid =
        _entries.where((x) => x.excercise != null && x.repeats! > 0).toList();

    if (valid.isEmpty) {
      return null;
    }

    final approaches = valid
        .map((entry) =>
            Approach(excercise: entry.excercise!, repeats: entry.repeats!))
        .toList();

    final training = Training(
        date: DateTime.now(),
        approach: approaches,
        id: DateTime.now().millisecondsSinceEpoch);
    return training;
  }

  void save() {
    final training = _create();
    if (training != null) {
      trainings.add(training);
    }
  }
}
