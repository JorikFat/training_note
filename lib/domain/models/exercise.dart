class Exercise {
  final String name;
  final int id;
  Exercise({
    required this.name,
    required this.id,
  });

  Exercise copyWith({
    final String? name,
    final int? id,
  }) {
    return Exercise(name: name ?? this.name, id: id ?? this.id);
  }
}

final List<Exercise> excercisesStub = [
  Exercise(name: "Отжимания", id: 1),
  Exercise(name: "Подтягивания", id: 2),
  Exercise(name: "Приседания", id: 3),
];
