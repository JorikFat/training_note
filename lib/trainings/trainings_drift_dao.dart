import 'package:drift/drift.dart';
import 'package:training_note/data/database.dart';
import 'package:training_note/trainings/training.dart';
import 'package:training_note/trainings/trainings_interactor.dart';

class TrainingsDriftDao implements TrainingsDao {
  final $TrainingDataTable trainings;
  final $ApproachDataTable approaches;

  TrainingsDriftDao({required AppDatabase database})
      : trainings = database.trainingData,
        approaches = database.approachData;

  @override
  Future<List<Training>> get() async {
    final query = trainings.select().join(
        [innerJoin(approaches, approaches.trainingId.equalsExp(trainings.id))])
      ..groupBy([trainings.id]);

    final result = await query.get();
    final items = result.map((row) {
      final training = row.readTable(trainings);
      return Training(
        id: training.id,
        date: training.date,
        approachCount: row.read(approaches.id.count())!,
      );
    });
    return items.toList();
  }

  @override
  Future<void> add(Training training) {
    return trainings
        .insert()
        .insert(TrainingDataCompanion.insert(date: training.date));
  }

  @override
  Future<void> replace(Training training) {
    return trainings.update().replace(
          TrainingDataCompanion(
            id: Value(training.id),
            date: Value(training.date),
          ),
        );
  }

  @override
  Future<void> remove(Training training) async {
    //TODO: use transaction
    // return database.transaction(() async {
    await approaches
        .deleteWhere((row) => row.trainingId.equals(training.id));
    await trainings
        .deleteWhere((row) => row.id.equals(training.id));
    // });
  }
}
