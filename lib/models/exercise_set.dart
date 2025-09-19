class ExerciseSet {
  int reps;
  double weight;

  ExerciseSet({required this.reps, required this.weight});

  Map<String, dynamic> toJson() => {
    'reps': reps,
    'weight': weight,
  };

  factory ExerciseSet.fromJson(Map<String, dynamic> json) {
    return ExerciseSet(
      reps: json['reps'] ?? 0,
      weight: (json['weight'] ?? 0).toDouble(),
    );
  }
}