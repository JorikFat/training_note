import 'package:flutter_test/flutter_test.dart';
import 'package:training_note/domain/models/approach.dart';
import 'package:training_note/domain/models/exercise.dart';
import 'package:training_note/domain/models/training.dart';
import 'package:training_note/main.dart';
import 'package:training_note/ui/exercise/view_models/exercises_screen_view_model.dart';
import 'package:training_note/ui/training/view_model/trainings_screen_view_model.dart';
import 'package:training_note/ui/training/widgets/training_details_screen.dart';

void main() {
  final excercises = [
      Exercise(name: 'Отжимания', id: 1),
      Exercise(name: 'Подтягивания', id: 2),
      Exercise(name: 'Приседания', id: 3),
  ];

  exercisesScreenViewModel = ExercisesScreenViewModel([])..value = excercises;
  trainingsScreenViewModel = TrainingsScreenViewModel([])..value = [
    Training(id: 1, date: DateTime(2025, 04, 11), approach: [
      Approach(excercise: excercises[0], repeats: 1),
      Approach(excercise: excercises[1], repeats: 1),
      Approach(excercise: excercises[2], repeats: 1),
    ])
  ];

  testWidgets('training details', (tester) async {
    await tester.pumpWidget(App());

    await tester.tap(find.text("Количество подходов: 3").first);
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(TrainingDetailsScreen),
      matchesGoldenFile('training_details.png'),
    );
    await tester.pumpAndSettle();
  });
}
