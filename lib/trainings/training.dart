import 'package:training_note/domain/models/training.dart' as old;

class Training {
  final int id;
  final DateTime date;
  final int approachCount;

  Training({
    required this.id,
    required this.date,
    required this.approachCount,
  });

  @Deprecated('remove after interrop')
  Training.interrop(old.Training training)
      : id = training.id,
        date = training.date,
        approachCount = training.approach.length;
}
