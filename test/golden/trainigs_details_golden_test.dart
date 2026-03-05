import 'package:flutter_test/flutter_test.dart';
import 'package:training_note/main.dart';
import 'package:training_note/ui/training/widgets/training_details_screen.dart';

void main() {
  testWidgets('training details', (tester) async {
    await tester.pumpWidget(const App());

    await tester.tap(find.text("Количество подходов: 3").first);
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(TrainingDetailsScreen),
      matchesGoldenFile('trainig_details.png'),
    );
    await tester.pumpAndSettle();
  });
}
