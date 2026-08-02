import 'package:drift/drift.dart';
import 'package:training_note/data/database.dart';
import 'package:training_note/data/models/approach_data.dart';
import 'package:training_note/data/models/exercise_data.dart';
import 'package:training_note/exercises/exercise.dart';
import 'package:training_note/exercises/exercise_interactor.dart';

part 'exercises_accessor.g.dart'; // Или exercises_repository.g.dart

@DriftAccessor(tables: [ExerciseData, ApproachData])
class ExerciseAccessor extends DatabaseAccessor<AppDatabase>
    with _$ExercisesAccessorMixin
    implements ExercisesDao {
  ExerciseAccessor(super.attachedDatabase);

  List<Exercise> mapTable(
      List<(ExerciseDataData exercise, $$ExerciseDataTableReferences refs)>
          items) {
    return items.map((pair) {
      final exercise = pair.$1;

      return Exercise(
        id: exercise.id,
        name: exercise.name,
      );
    }).toList();
  }

  @override
  Future<void> add(Exercise exercise) async {
    await managers.exerciseData.create(
      (entry) => entry(
        name: exercise.name,
      ),
    );
  }

  @override
  Future<List<Exercise>> get() async {
    final data = await managers.exerciseData
        .withReferences((prefetch) => prefetch(approachDataRefs: true))
        .get();
    return mapTable(data);
  }

  @override
  Future<void> remove(Exercise exercise) async {
    await managers.exerciseData
        .filter((it) => it.id.equals(exercise.id))
        .delete();
  }

  @override
  Future<void> replace(Exercise exercise) async {
    await managers.exerciseData
        .filter((it) => it.id.equals(exercise.id))
        .update(
          (entry) => entry(
            name: Value(exercise.name),
          ),
        );
  }
}
