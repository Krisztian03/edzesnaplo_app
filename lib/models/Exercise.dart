import 'exercise_set.dart';

class Exercise {
  final String name;
  final List<ExerciseSet> sets;
  bool isCompleted;

  Exercise({
    required this.name,
    required this.sets,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'sets': sets.map((s) => s.toJson()).toList(),
    'isCompleted': isCompleted,
  };

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      sets: (json['sets'] as List)
          .map((s) => ExerciseSet.fromJson(s))
          .toList(),
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}
