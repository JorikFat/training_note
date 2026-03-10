import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:training_note/domain/models/exercise.dart';
import 'package:training_note/ui/exercise/view_models/exercises_screen_view_model.dart';

class DropDownExercises extends StatelessWidget {
  const DropDownExercises({
    super.key,
    required this.repeats,
    required this.onRepeatsChanged,
    this.selectedExerciseId,
    required this.onExerciseChanged,
    required this.onRemove,
  });

  final int repeats;
  final Function(int) onRepeatsChanged;
  final int? selectedExerciseId;
  final Function(int?) onExerciseChanged;
  final void Function() onRemove;

  @override
  Widget build(BuildContext context) {
    final ExercisesScreenViewModel exercisesScreenViewModel =
        ExercisesScreenViewModel(excercisesStub);
    return ValueListenableBuilder<List<Exercise>>(
        valueListenable: exercisesScreenViewModel,
        builder: (context, value, a) {
          if (value.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text('Нет упражнений')],
            );
          }
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 3,
                child: DropdownButtonFormField<int>(
                  menuMaxHeight: 250,
                  initialValue: selectedExerciseId,
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  ),
                  icon: Icon(Icons.keyboard_arrow_down_outlined),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  items: value
                      .map((e) => DropdownMenuItem<int>(
                            value: e.id,
                            child: Text(e.name.toString()),
                          ))
                      .toList(),
                  onChanged: onExerciseChanged,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: TextFormField(
                    initialValue: repeats > 0 ? repeats.toString() : '',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      hintText: 'Повторений',
                      hintStyle:
                          const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    onChanged: (value) {
                      onRepeatsChanged(int.tryParse(value) ?? 0);
                    }),
              ),
              IconButton(
                icon: Icon(
                  Icons.remove,
                ),
                onPressed: onRemove,
              ),
            ],
          );
        });
  }
}
