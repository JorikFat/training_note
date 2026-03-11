import 'package:flutter/material.dart';
import 'package:training_note/domain/models/exercise.dart';
import 'package:training_note/domain/models/training.dart';
import 'package:training_note/ui/common/dismiss_widget.dart';
import 'package:training_note/ui/common/drop_down_exercises.dart';
import 'package:training_note/ui/common/date_formating_extension.dart';
import 'package:training_note/ui/exercise/view_models/exercises_screen_view_model.dart';
import 'package:training_note/ui/training/view_model/create_training_view_model.dart';
import 'package:training_note/ui/training/view_model/trainings_screen_view_model.dart';
// list training

class CreateTraining extends StatefulWidget {
  const CreateTraining({super.key, required this.trainingSreeenViewModel});

  final TrainingsScreenViewModel trainingSreeenViewModel;

  @override
  State<CreateTraining> createState() => _CreateTrainingState();
}

class _CreateTrainingState extends State<CreateTraining> {
  final createTrainingVM = CreateTrainingViewModel();

  final exercisesScreenViewModel = ExercisesScreenViewModel(excercisesStub);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: createTrainingVM.addTrainingEntry,
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(),
          actions: [
            IconButton(
              onPressed: () {
                //будет открывать DatePickerDialog
              },
              icon: Icon(Icons.calendar_today),
            ),
            IconButton(
              onPressed: () {
                createTrainingVM.save();
                widget.trainingSreeenViewModel.value = trainings.toList();
                Navigator.pop(context);
              },
              icon: Icon(Icons.file_download),
            ),
          ],
          title: Text(DateTime.now().formatData()),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: ListenableBuilder(
              listenable: createTrainingVM,
              builder: (context, child) {
                return ListView.builder(
                    itemCount: createTrainingVM.entries.length,
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) {
                      final entry = createTrainingVM.entries[index];
                      return DismissWidget(
                        delete: (f) =>
                            createTrainingVM.removeTrainingEntry(index),
                        childKey: UniqueKey(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: DropDownExercises(
                            repeats: entry.repeats ?? 0,
                            selectedExerciseId: entry.excercise?.id,
                            onRepeatsChanged: (int repeats) {
                              if (entry.excercise != null) {
                                createTrainingVM.setTrainingEntry(
                                    entry.excercise!, repeats, index);
                              } else {
                                return entry.repeats = repeats;
                              }
                            },
                            onExerciseChanged: (int? exerciseID) {
                              if (exerciseID == null) return;
                              final exercise = exercisesScreenViewModel.value
                                  .firstWhere((e) => e.id == exerciseID);
                              createTrainingVM.setTrainingEntry(
                                  exercise, entry.repeats ?? 0, index);
                            },
                          ),
                        ),
                      );
                    });
              }),
        ));
  }
}
