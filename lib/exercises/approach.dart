import 'package:training_note/domain/models/approach.dart' as old;
import 'package:training_note/domain/models/exercise.dart';

class Approach {
  final Exercise excercise;
  final int repeats;

  Approach({required this.excercise, required this.repeats});

  @Deprecated('remove after interrop')
  Approach.interrop(old.Approach approach)
      : excercise = approach.excercise,
        repeats = approach.repeats;
}

class ApproachDraft extends Approach {
  ApproachDraft({required Exercise excercise})
      : super(repeats: 0, excercise: excercise);
}
