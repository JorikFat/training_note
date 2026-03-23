import 'package:drift/drift.dart';

class TrainingData extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
}
