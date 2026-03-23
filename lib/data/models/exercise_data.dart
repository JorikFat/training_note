import 'package:drift/drift.dart';

class ExerciseData extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}
