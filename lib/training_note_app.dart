import 'package:flutter/material.dart';
import 'package:training_note/routing/main_page.dart';

class TrainingNoteApp extends StatelessWidget {
  const TrainingNoteApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MainPage());
  }
}
