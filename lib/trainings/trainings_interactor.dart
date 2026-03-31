import 'dart:async';
import 'dart:developer';

import 'package:training_note/data/database.dart';
import 'package:training_note/trainings/training.dart';
import 'package:training_note/ui/training/view_model/trainings_screen_view_model.dart';

late final TrainingsInteractor trainings;

class TrainingsInteractor {
  final AppDatabase database;
  List<Training>? trainings;

  final StreamController<List<Training>> streamController =
      StreamController.broadcast();

  TrainingsInteractor({required this.database}){
    stream.listen((trainings) => log(trainings.toString()));
  }

  Stream<List<Training>> get stream => streamController.stream;

  Future<void> init() async {
    final oldTrainings = await TrainingsScreenViewModel.read(database);
    trainings = oldTrainings.map(Training.interrop).toList();
    streamController.add(trainings!);
  }

  void close() {
    streamController.close();
  }
}
