import 'package:flutter_test/flutter_test.dart';
import 'package:training_note/routing/main.dart';
import 'package:training_note/routing/main_page.dart';

void main() {
  testWidgets('list', (tester) async {
    await tester.pumpWidget(const App());

    await expectLater(
      find.byType(MainPage),
      matchesGoldenFile('trainigs_list.png'),
    );
    await tester.pumpAndSettle();
  });
}
