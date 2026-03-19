import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:training_note/domain/models/exercise.dart';
import 'package:training_note/main.dart';
import 'package:training_note/routing/main_page.dart';
import 'package:training_note/ui/exercise/view_models/exercises_screen_view_model.dart';
import 'package:training_note/ui/training/view_model/trainings_screen_view_model.dart';

void main() {
  trainingsScreenViewModel = TrainingsScreenViewModel([]);
  exercisesScreenViewModel = ExercisesScreenViewModel([])..value = [
      Exercise(name: 'Отжимания', id: 1),
      Exercise(name: 'Подтягивания', id: 3),
      Exercise(name: 'Приседания', id: 2),
  ];

  testWidgets('list', (tester) async {
    await tester.pumpWidget(App());

    await tester.tap(find.text("Упражнения"));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MainPage),
      matchesGoldenFile('excersices_list.png'),
    );
    await tester.pumpAndSettle();
  });

  testWidgets('add', (tester) async {
    await tester.pumpWidget(App());

    await tester.tap(find.text('Упражнения'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('excersices_add.png'),
    );
    await tester.pumpAndSettle();
  });

  testWidgets('edit', (tester) async {
    await tester.pumpWidget(App());

    await tester.tap(find.text('Упражнения'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Отжимания'));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('excersices_edit.png'),
    );
    await tester.pumpAndSettle();
  });
}
