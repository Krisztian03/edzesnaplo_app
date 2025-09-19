import 'Exercise.dart';

class WorkoutEntry {
  String? id;
  final String key;
  final DateTime date;
  final List<Exercise> exercises;

  WorkoutEntry({
    this.id,
    required this.key,
    required this.date,
    required this.exercises,
  });

  Map<String, dynamic> toJson() => {
    'key': key,
    'date': date.toIso8601String(),
    'exercises': exercises.map((e) => e.toJson()).toList(),
  };

  factory WorkoutEntry.fromJson(Map<String, dynamic> json, {String? id}) {
    return WorkoutEntry(
      id: id,
      key: json['key'],
      date: DateTime.parse(json['date']),
      exercises: (json['exercises'] as List)
          .map((e) => Exercise.fromJson(e))
          .toList(),
    );
  }
}
