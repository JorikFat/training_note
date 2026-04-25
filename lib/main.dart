import 'package:flutter/material.dart';
import 'package:training_note/data/database.dart';
import 'package:training_note/training_note_app.dart';
import 'package:training_note/trainings/trainings_interactor.dart';
import 'package:training_note/ui/exercise/view_models/exercises_screen_view_model.dart';
import 'package:training_note/ui/training/view_model/trainings_screen_view_model.dart';

late final AppDatabase database;//FIXME

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = AppDatabase();
  exercisesScreenViewModel = ExercisesScreenViewModel([], database: database);
  await exercisesScreenViewModel.load();
  trainingsScreenViewModel = TrainingsScreenViewModel([], database: database);
  await trainingsScreenViewModel.load();
  trainings = TrainingsInteractor(database: database);
  await trainings.init();
  runApp(TrainingNoteApp(
    database: database,
  ));
}
