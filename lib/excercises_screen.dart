import 'dart:developer';

import 'package:flutter/material.dart';

final excercisesStub = [
  "Отжимания",
  "Подтягивания",
  "Приседания",
];

class ExcercisesScreen extends StatelessWidget {
  const ExcercisesScreen({super.key});

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
        onPressed: add,
        child: Icon(Icons.add),
      ),
    );
  }

  void add() {
    log('excercise add');
  }
}
