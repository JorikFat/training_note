import 'package:training_note/domain/models/approach.dart';
import 'package:training_note/domain/models/exercise.dart';

class Training {
  final DateTime date;
  final List<Approach> approach;

  const Training({required this.date, required this.approach});
}

List<Training> trainings = [
  Training(date: DateTime(2025, 04, 11), approach: [
    Approach(excercise: excercisesStub[0], repeats: 10),
    Approach(excercise: excercisesStub[1], repeats: 10),
    Approach(excercise: excercisesStub[2], repeats: 10)
  ]),
  Training(date: DateTime(2025, 04, 11), approach: [
    Approach(excercise: excercisesStub[0], repeats: 10),
    Approach(excercise: excercisesStub[1], repeats: 10),
    Approach(excercise: excercisesStub[2], repeats: 10)
  ]),
  Training(date: DateTime(2025, 04, 11), approach: [
    Approach(excercise: excercisesStub[0], repeats: 10),
    Approach(excercise: excercisesStub[1], repeats: 10),
    Approach(excercise: excercisesStub[2], repeats: 10)
  ]),
];
