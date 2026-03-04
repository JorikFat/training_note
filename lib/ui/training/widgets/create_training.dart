import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_note/domain/models/approach.dart';
import 'package:training_note/domain/models/exercise.dart';
import 'package:training_note/ui/common/drop_down_exercises.dart';
import 'package:training_note/ui/common/date_formating_extension.dart';
import 'package:training_note/ui/training/view_model/trainings_screen_view_model.dart';

class CreateTraining extends StatefulWidget {
  const CreateTraining({
    super.key,
  });

  @override
  State<CreateTraining> createState() => _CreateTrainingState();
}

class _CreateTrainingState extends State<CreateTraining> {
  int dropdownValue = 0;
  final List<TextEditingController> controllers = [];
  final List<int?> selected = [];

  @override
  void dispose() {
    for (var control in controllers) {
      control.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    for (int i = 0; i < excercisesStub.length; i++) {
      _addApproach();
    }
    super.initState();
  }

  void _addApproach() {
    setState(() {
      controllers.add(TextEditingController());
      selected.add(null);
    });
  }

  void _save() {
    final List<Approach> approaches = [];
    for (int a = 0; a < controllers.length; a++) {
      final exerciseId = selected[a];
      if (exerciseId != null) {
        final exercise = excercisesStub.firstWhere((e) => e.id == exerciseId);
        approaches.add(Approach(
            excercise: exercise,
            repeats: int.tryParse(controllers[a].text) ?? 0));
      }
    }
    trainingsScreenViewModel.createTrainigs(DateTime.now(), approaches);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(),
          actions: [
            Icon(CupertinoIcons.calendar),
            IconButton(
              icon: Icon(CupertinoIcons.share),
              onPressed: _save,
            ),
          ],
          title: Text(DateTime.now().formatData()),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: ListView.builder(
              itemCount: controllers.length,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                return Expanded(
                  child: DropDownExercises(
                    repeatsController: controllers[index],
                    dropdownValue: selected[index],
                    onChanged: (int? value) {
                      setState(
                        () {
                          selected[index] = value;
                        },
                      );
                    },
                    listIDs: selected,
                    currentIndex: index,
                  ),
                );
              }),
        ));
  }
}
