import 'package:training_note/domain/models/approach.dart';

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

final List<Training> trainings = [];
