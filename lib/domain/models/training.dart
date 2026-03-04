import 'package:training_note/domain/models/approach.dart';
import 'package:training_note/domain/models/exercise.dart';

class Training {
  final int id;
  final DateTime date;
  final List<Approach> approach;

  const Training(
      {required this.date, required this.approach, required this.id});

  Training copyWith(
      {final int? id, final DateTime? date, final List<Approach>? approach}) {
    return Training(
        date: date ?? this.date,
        approach: approach ?? this.approach,
        id: id ?? this.id);
  }
}

List<Training> trainings = [
  Training(
      date: DateTime(2025, 04, 11),
      approach: [
        Approach(excercise: excercisesStub[0], repeats: 10),
        Approach(excercise: excercisesStub[1], repeats: 10),
        Approach(excercise: excercisesStub[2], repeats: 10)
      ],
      id: 0),
  Training(
      date: DateTime(2025, 04, 11),
      approach: [
        Approach(excercise: excercisesStub[0], repeats: 10),
        Approach(excercise: excercisesStub[1], repeats: 10),
        Approach(excercise: excercisesStub[2], repeats: 10)
      ],
      id: 1),
  Training(
      date: DateTime(2025, 04, 11),
      approach: [
        Approach(excercise: excercisesStub[0], repeats: 10),
        Approach(excercise: excercisesStub[1], repeats: 10),
        Approach(excercise: excercisesStub[2], repeats: 10)
      ],
      id: 2),
];
