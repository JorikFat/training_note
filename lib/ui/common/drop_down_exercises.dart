import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:training_note/domain/models/exercise.dart';
import 'package:training_note/ui/exercise/view_models/exercises_screen_view_model.dart';

class DropDownExercises extends StatefulWidget {
  const DropDownExercises(
      {super.key,
      required this.dropdownValue,
      required this.onChanged,
      required this.repeatsController});
  final TextEditingController repeatsController;
  final int? dropdownValue;
  final ValueChanged<int?>? onChanged;
  @override
  State<DropDownExercises> createState() => _DropDownExercisesState();
}

class _DropDownExercisesState extends State<DropDownExercises> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Exercise>>(
        valueListenable: exercisesViewModel,
        builder: (context, value, a) {
          if (value.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text('Нет упражнений')],
            );
          }
          widget.dropdownValue != null &&
                  value.any((e) => e.id == widget.dropdownValue)
              ? widget.dropdownValue
              : value.first.id;
          return Row(
            children: [
              Expanded(
                flex: 3,
                child: DropdownButtonFormField<int>(
                  menuMaxHeight: 250,
                  initialValue: widget.dropdownValue,
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  ),
                  icon: Icon(CupertinoIcons.arrow_down),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                  items: value
                      .map((e) => DropdownMenuItem<int>(
                            value: e.id,
                            child: Text(e.name.toString()),
                          ))
                      .toList(),
                  onChanged: widget.onChanged,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  controller: widget.repeatsController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: 'Повторений',
                    hintStyle:
                        const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              )
            ],
          );
        });
  }
}
