import 'package:flutter/material.dart';
import 'package:training_note/domain/models/exercise.dart';
import 'package:training_note/domain/models/training.dart';
import 'package:training_note/routing/main_page.dart';
import 'package:training_note/ui/exercise/view_models/exercises_screen_view_model.dart';
import 'package:training_note/ui/training/view_model/create_training_view_model.dart';
import 'package:training_note/ui/training/view_model/trainings_screen_view_model.dart';

void main() {
  trainingsScreenViewModel = TrainingsScreenViewModel(trainings);
  exercisesScreenViewModel = ExercisesScreenViewModel(excercisesStub);
  createTrainingVM = CreateTrainingViewModel();
  runApp(App());
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MainPage());
  }
}
