import 'package:training_note/domain/models/exercise.dart' as old;

class Exercise {
  final String name;
  final int id;
  Exercise({
    required this.name,
    required this.id,
  });

  @Deprecated('remove after interrop')
  Exercise.interrop(old.Exercise exercise)
      : id = exercise.id,
        name = exercise.name;
}

class ExerciseDraft extends Exercise {
  ExerciseDraft() : super(id: 0, name: '');
}
