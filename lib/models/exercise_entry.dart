class ExerciseEntry {
  final String exerciseKey;
  int sets;
  int reps;
  List<double> weights;
  String notes;

  ExerciseEntry({
    required this.exerciseKey,
    required this.sets,
    required this.reps,
    required this.weights,
    this.notes = '',
  });

  double get volume => weights.asMap().entries.fold(
      0, (sum, e) => sum + e.value * reps);
}
