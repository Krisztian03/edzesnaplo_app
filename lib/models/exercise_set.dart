class ExerciseSet {
  final String weight;
  final int reps;

  ExerciseSet({required this.weight, required this.reps});

  Map<String, dynamic> toJson() => {
    'weight': weight,
    'reps': reps,
  };

  factory ExerciseSet.fromJson(Map<String, dynamic> json) {
    return ExerciseSet(
      weight: json['weight'],
      reps: json['reps'],
    );
  }
}
