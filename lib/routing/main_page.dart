import 'package:flutter/material.dart';
import 'package:training_note/ui/training/widgets/trainings_screen.dart';
import 'package:training_note/ui/exercise/widgets/excercises_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        TrainingsScreen(),
        ExcercisesScreen(),
      ][_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue[800],
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Тренировки'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Упражнения'),
          ]),
    );
  }
}
