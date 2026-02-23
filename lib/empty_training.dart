import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_note/common/drop_down_exercises.dart';
import 'package:training_note/date_formating_extension.dart';

class EmptyTraining extends StatefulWidget {
  const EmptyTraining({super.key});

  @override
  State<EmptyTraining> createState() => _EmptyTrainingState();
}

class _EmptyTrainingState extends State<EmptyTraining> {
  int dropdownValue = 0;
  TextEditingController repeatsController1 = TextEditingController();
  TextEditingController repeatsController2 = TextEditingController();
  TextEditingController repeatsController3 = TextEditingController();
  final selected = List<int?>.filled(3, null);

  @override
  void dispose() {
    repeatsController1.dispose();
    repeatsController2.dispose();
    repeatsController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(),
          actions: [Icon(CupertinoIcons.calendar)],
          title: Text(DateTime.now().formatData()),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              DropDownExercises(
                repeatsController: repeatsController2,
                dropdownValue: selected[1],
                onChanged: (int? value) {
                  setState(() {
                    selected[1] = value;
                  });
                },
              ),
              DropDownExercises(
                repeatsController: repeatsController3,
                dropdownValue: selected[2],
                onChanged: (int? value) {
                  setState(() {
                    selected[2] = value;
                  });
                },
              ),
            ],
          ),
        ));
  }
}
