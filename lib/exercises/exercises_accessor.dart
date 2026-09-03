import 'package:drift/drift.dart';
import 'package:training_note/data/database.dart';
import 'package:training_note/data/models/approach_data.dart';
import 'package:training_note/data/models/exercise_data.dart';
import 'package:training_note/exercises/exercise.dart';
import 'package:training_note/exercises/exercise_interactor.dart';

part 'exercises_accessor.g.dart'; // Или exercises_repository.g.dart

@DriftAccessor(tables: [ExerciseData, ApproachData])
class ExercisesAccessor extends DatabaseAccessor<AppDatabase>
    with _$ExercisesAccessorMixin
    implements ExercisesDao {
  ExercisesAccessor(super.attachedDatabase);

  List<Exercise> mapTable(
      List<(ExerciseDataData exercise, $$ExerciseDataTableReferences refs)>
          items) {
    return [
      for (final (exercise, _) in items)
        Exercise(id: exercise.id, name: exercise.name),
    ];
  }

  @override
  Future<void> add(Exercise exercise) async {
    await attachedDatabase.managers.exerciseData.create(
      (entry) => entry(
        name: exercise.name,
      ),
    );
  }

  @override
  Future<List<Exercise>> get() async {
    final data = await attachedDatabase.managers.exerciseData
        .withReferences((prefetch) => prefetch(approachDataRefs: true))
        .get();
    return mapTable(data);
  }

  @override
  Future<void> remove(Exercise exercise) async {
    await attachedDatabase.managers.exerciseData
        .filter((it) => it.id.equals(exercise.id))
        .delete();
  }

  @override
  Future<void> replace(Exercise exercise) async {
    await attachedDatabase.managers.exerciseData
        .filter((it) => it.id.equals(exercise.id))
        .update(
          (entry) => entry(
            name: Value(exercise.name),
          ),
        );
  }
}
