import 'package:drift/drift.dart';
import 'package:training_note/data/database.dart';
import 'package:training_note/data/models/approach_data.dart';
import 'package:training_note/data/models/training_data.dart';
import 'package:training_note/trainings/training.dart';
import 'package:training_note/trainings/trainings_interactor.dart';

part 'trainings_repository.g.dart';

@DriftAccessor(tables: [TrainingData, ApproachData])
class TrainingsAccessor extends DatabaseAccessor<AppDatabase>
    with _$TrainingsRepositoryMixin
    implements TrainingsDao {
  TrainingsAccessor(super.database);

  List<Training> mapTable(
      List<(TrainingDataData training, $$TrainingDataTableReferences refs)>
          items) {
    return items.map((pair) {
      final training = pair.$1;
      final approachesRef = pair.$2;
      return Training(
          id: training.id,
          date: training.date,
          approachCount: approachesRef.approachDataRefs.prefetchedData!.length);
    }).toList();
  }

  @override
  Future<List<Training>> read() async {
    final data = await managers.trainingData
        .withReferences((prefetch) => prefetch(approachDataRefs: true))
        .get();
    return mapTable(data);
  }

  Stream<List<Training>> watch() {
    return managers.trainingData
        .withReferences((prefetch) => prefetch(approachDataRefs: true))
        .watch()
        .map(mapTable);
  }

  Future<void> add(Training training) async {
    await managers.trainingData
        .filter((it) => it.id.equals(training.id))
        .update((update) => update(
              date: Value(training.date),
            ));
  }

  @override
  Future<void> remove(Training training) async {
    await managers.trainingData
        .filter((it) => it.id.equals(training.id))
        .delete();
  }

  @override
  Future<void> create(Training training) => add(training);

  @override
  Future<void> edit(Training training) async {
    await managers.trainingData
        .filter((it) => it.id.equals(training.id))
        .update((o) => o(date: Value(training.date)));
  }
}
