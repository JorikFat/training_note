import 'dart:async';

import 'package:flutter/material.dart';
import 'package:training_note/trainings/training.dart';
import 'package:training_note/trainings/trainings_interactor.dart';
import 'package:training_note/ui/common/date_formating_extension.dart';

@immutable
sealed class TrainingsState {
  const TrainingsState();
  const factory TrainingsState.empty() = TrainingsEmptyState;
  const factory TrainingsState.list(List<TrainingViewModel> list) = TrainingsListState;
}

class TrainingsEmptyState extends TrainingsState {
  const TrainingsEmptyState();
}

class TrainingsListState extends TrainingsState {
  final List<TrainingViewModel> list;
  const TrainingsListState(this.list);
}

class TrainingViewModel {
  final int id;
  final String date;
  final String approaches;

  TrainingViewModel({
    required this.id,
    required this.date,
    required this.approaches,
  });

  TrainingViewModel.model(Training training)
      : id = training.id,
        date = "Дата тренировки: ${training.date.formatData()}",
        approaches = 'Количество подходов: ${training.approachCount}';
}

class TrainingsListNotifier extends ValueNotifier<TrainingsState> {
  late final StreamSubscription subscription;
  final TrainingsInteractor interactor;

  TrainingsListNotifier({required this.interactor})
      : super(_mapState(interactor.trainings!)) {
    subscription = interactor.stream.listen(updateState);
  }

  void updateState(List<Training> trainings){
      value = _mapState(trainings);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}

TrainingsState _mapState(List<Training> trainings) => trainings.isEmpty
          ? const TrainingsState.empty()
          : TrainingsState.list(trainings.map(TrainingViewModel.model).toList());
