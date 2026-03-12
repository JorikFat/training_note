import 'package:flutter/material.dart';
import 'package:training_note/domain/models/approach.dart';
import 'package:training_note/domain/models/training.dart';

class TrainingsScreenViewModel extends ValueNotifier<List<Training>> {
  TrainingsScreenViewModel(List<Training>? trainings) : super(trainings ?? []);

  void createTrainigs(DateTime date, List<Approach> approach) {
    final newTraining = Training(
        date: date,
        approach: approach,
        id: DateTime.now().microsecondsSinceEpoch);
    value = [...value, newTraining];
  }

  void addTraining(Training training) {
    value = [...value, training];
  }
  // void updateTraining(DateTime date, List<Approach> approach, int id) {
  //   final index = value.indexWhere((e) => e.id == id);
  //.  approach еще обновить
  //   final updated = value[index].copyWith(date: date, approach: approach);
  //   final newList = [...value];
  //   newList[index] = updated;
  //   value = newList;
  // }

  void deleteTraining(int id) {
    value = value.where((e) => e.id != id).toList();
  }
}

late final TrainingsScreenViewModel trainingsScreenViewModel;
