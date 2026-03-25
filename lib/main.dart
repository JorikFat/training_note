import 'package:flutter/material.dart';
import 'package:training_note/data/database.dart';
import 'package:training_note/training_note_app.dart';
import 'package:training_note/ui/exercise/view_models/exercises_screen_view_model.dart';
import 'package:training_note/ui/training/view_model/trainings_screen_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = AppDatabase();
  exercisesScreenViewModel = ExercisesScreenViewModel([], database: database);
  await exercisesScreenViewModel.load();
  trainingsScreenViewModel = TrainingsScreenViewModel([], database: database);
  await trainingsScreenViewModel.load();
  runApp(TrainingNoteApp(
    database: database,
  ));
}
