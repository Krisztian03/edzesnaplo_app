import 'package:flutter/material.dart';

class WorkoutCategory {
  final String key;
  final IconData icon;
  final List<WorkoutSubCategory> subCategories;

  WorkoutCategory({
    required this.key,
    required this.icon,
    required this.subCategories,
  });
}

class WorkoutSubCategory {
  final String key;
  final List<WorkoutExercise> exercises;

  WorkoutSubCategory({
    required this.key,
    required this.exercises,
  });
}

class WorkoutExercise {
  final String key;

  WorkoutExercise({required this.key});
}
