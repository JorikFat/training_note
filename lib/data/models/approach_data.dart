import 'package:drift/drift.dart';
import 'package:training_note/data/models/exercise_data.dart';
import 'package:training_note/data/models/training_data.dart';

class ApproachData extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get trainingId => integer().references(TrainingData, #id)();
  IntColumn get exerciseId => integer().references(ExerciseData, #id)();
  IntColumn get repeats => integer()();
}
