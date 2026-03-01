import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:training_note/routing/main.dart';
import 'package:training_note/routing/main_page.dart';

void main() {
  testWidgets('list', (tester) async {
    await tester.pumpWidget(const App());

    await tester.tap(find.text("Упражнения"));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MainPage),
      matchesGoldenFile('excersices_list.png'),
    );
    await tester.pumpAndSettle();
  });

  testWidgets('add', (tester) async {
    await tester.pumpWidget(const App());

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
    await tester.pumpWidget(const App());

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
