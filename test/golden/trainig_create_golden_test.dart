import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:training_note/data/database.dart';
import 'package:training_note/domain/models/exercise.dart';
import 'package:training_note/training_note_app.dart';
import 'package:training_note/ui/exercise/view_models/exercises_screen_view_model.dart';
import 'package:training_note/ui/training/view_model/trainings_screen_view_model.dart';
import 'package:training_note/ui/training/widgets/create_training.dart';

void main() {
  final database = AppDatabase();
  trainingsScreenViewModel = TrainingsScreenViewModel([]);
  exercisesScreenViewModel = ExercisesScreenViewModel([], database: database)
    ..value = [
      Exercise(name: 'Отжимания', id: 1),
      Exercise(name: 'Приседания', id: 2),
      Exercise(name: 'Подтягивания', id: 3),
    ];

  testWidgets('training details', (tester) async {
    await tester.pumpWidget(TrainingNoteApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(CreateTraining),
      matchesGoldenFile('trainig_create_empty.png'),
    );
    await tester.pumpAndSettle();
  });
}
