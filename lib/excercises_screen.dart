import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:training_note/exercises_create.dart';

final excercisesStub = [
  "Отжимания",
  "Подтягивания",
  "Приседания",
];

class ExcercisesScreen extends StatefulWidget {
  const ExcercisesScreen({super.key});

  @override
  State<ExcercisesScreen> createState() => _ExcercisesScreenState();
}

class _ExcercisesScreenState extends State<ExcercisesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: excercisesStub.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) => Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(excercisesStub[index]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          log('excercise add');
          await showDialog(
              context: context, builder: (context) => ExercisesCreate());
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
