import 'package:flutter/material.dart';
import 'Workout.dart';

/// Főbb edzéskategóriák (science-based)
final List<WorkoutCategory> workoutCategories = [

  /// CHEST
  WorkoutCategory(
    key: 'chest',
    icon: Icons.fitness_center,
    subCategories: [
      WorkoutSubCategory(
        key: 'upperChest',
        exercises: [
          WorkoutExercise(key: 'inclineBenchPress'),
          WorkoutExercise(key: 'inclineDumbbellPress'),
          WorkoutExercise(key: 'lowToHighCableFly'),
        ],
      ),
      WorkoutSubCategory(
        key: 'midChest',
        exercises: [
          WorkoutExercise(key: 'flatBarbellBench'),
          WorkoutExercise(key: 'flatDumbbellBench'),
          WorkoutExercise(key: 'chestFly'),
          WorkoutExercise(key: 'pushUps'),
        ],
      ),
      WorkoutSubCategory(
        key: 'lowerChest',
        exercises: [
          WorkoutExercise(key: 'declineBenchPress'),
          WorkoutExercise(key: 'dips'),
          WorkoutExercise(key: 'highToLowCableFly'),
        ],
      ),
    ],
  ),

  /// BACK
  WorkoutCategory(
    key: 'back',
    icon: Icons.fitness_center,
    subCategories: [
      WorkoutSubCategory(
        key: 'lats',
        exercises: [
          WorkoutExercise(key: 'pullUps'),
          WorkoutExercise(key: 'chinUps'),
          WorkoutExercise(key: 'latPulldown'),
        ],
      ),
      WorkoutSubCategory(
        key: 'upperBack',
        exercises: [
          WorkoutExercise(key: 'barbellRow'),
          WorkoutExercise(key: 'tBarRow'),
          WorkoutExercise(key: 'dumbbellRow'),
        ],
      ),
      WorkoutSubCategory(
        key: 'trapsRearDelts',
        exercises: [
          WorkoutExercise(key: 'facePull'),
          WorkoutExercise(key: 'shrugs'),
          WorkoutExercise(key: 'rearDeltFly'),
        ],
      ),
      WorkoutSubCategory(
        key: 'erectorSpinae',
        exercises: [
          WorkoutExercise(key: 'deadlift'),
          WorkoutExercise(key: 'romanianDeadlift'),
          WorkoutExercise(key: 'backExtension'),
        ],
      ),
    ],
  ),

  /// LEGS
  WorkoutCategory(
    key: 'legs',
    icon: Icons.directions_walk,
    subCategories: [
      WorkoutSubCategory(
        key: 'quads',
        exercises: [
          WorkoutExercise(key: 'squats'),
          WorkoutExercise(key: 'frontSquats'),
          WorkoutExercise(key: 'legPress'),
          WorkoutExercise(key: 'stepUps'),
        ],
      ),
      WorkoutSubCategory(
        key: 'hamstrings',
        exercises: [
          WorkoutExercise(key: 'romanianDeadlift'),
          WorkoutExercise(key: 'hamstringCurl'),
          WorkoutExercise(key: 'goodMorning'),
        ],
      ),
      WorkoutSubCategory(
        key: 'glutes',
        exercises: [
          WorkoutExercise(key: 'hipThrust'),
          WorkoutExercise(key: 'gluteBridge'),
          WorkoutExercise(key: 'bulgarianSplitSquat'),
        ],
      ),
      WorkoutSubCategory(
        key: 'calves',
        exercises: [
          WorkoutExercise(key: 'calfRaise'),
          WorkoutExercise(key: 'seatedCalfRaise'),
        ],
      ),
    ],
  ),

  /// ARMS
  WorkoutCategory(
    key: 'arms',
    icon: Icons.accessibility_new,
    subCategories: [
      WorkoutSubCategory(
        key: 'biceps',
        exercises: [
          WorkoutExercise(key: 'bicepCurls'),
          WorkoutExercise(key: 'hammerCurls'),
          WorkoutExercise(key: 'concentrationCurl'),
        ],
      ),
      WorkoutSubCategory(
        key: 'triceps',
        exercises: [
          WorkoutExercise(key: 'tricepPushdown'),
          WorkoutExercise(key: 'overheadTricepExtension'),
          WorkoutExercise(key: 'skullCrushers'),
          WorkoutExercise(key: 'closeGripBenchPress'),
        ],
      ),
      WorkoutSubCategory(
        key: 'forearms',
        exercises: [
          WorkoutExercise(key: 'wristCurl'),
          WorkoutExercise(key: 'reverseWristCurl'),
          WorkoutExercise(key: 'farmerCarry'),
        ],
      ),
    ],
  ),

  /// SHOULDERS
  WorkoutCategory(
    key: 'shoulders',
    icon: Icons.accessibility,
    subCategories: [
      WorkoutSubCategory(
        key: 'frontDelts',
        exercises: [
          WorkoutExercise(key: 'shoulderPress'),
          WorkoutExercise(key: 'frontRaise'),
          WorkoutExercise(key: 'arnoldPress'),
        ],
      ),
      WorkoutSubCategory(
        key: 'lateralDelts',
        exercises: [
          WorkoutExercise(key: 'lateralRaise'),
          WorkoutExercise(key: 'uprightRow'),
        ],
      ),
      WorkoutSubCategory(
        key: 'rearDelts',
        exercises: [
          WorkoutExercise(key: 'rearDeltFly'),
          WorkoutExercise(key: 'facePull'),
        ],
      ),
    ],
  ),

  /// CORE
  WorkoutCategory(
    key: 'core',
    icon: Icons.sports_gymnastics,
    subCategories: [
      WorkoutSubCategory(
        key: 'abs',
        exercises: [
          WorkoutExercise(key: 'plank'),
          WorkoutExercise(key: 'crunches'),
          WorkoutExercise(key: 'legRaises'),
          WorkoutExercise(key: 'abRollout'),
        ],
      ),
      WorkoutSubCategory(
        key: 'obliques',
        exercises: [
          WorkoutExercise(key: 'russianTwist'),
          WorkoutExercise(key: 'sidePlank'),
          WorkoutExercise(key: 'woodchopper'),
        ],
      ),
      WorkoutSubCategory(
        key: 'advanced',
        exercises: [
          WorkoutExercise(key: 'hangingLegRaise'),
          WorkoutExercise(key: 'dragonFlag'),
        ],
      ),
    ],
  ),

  /// CARDIO
  WorkoutCategory(
    key: 'cardio',
    icon: Icons.directions_run,
    subCategories: [
      WorkoutSubCategory(
        key: 'outdoor',
        exercises: [
          WorkoutExercise(key: 'running'),
          WorkoutExercise(key: 'cycling'),
          WorkoutExercise(key: 'swimming'),
        ],
      ),
      WorkoutSubCategory(
        key: 'indoor',
        exercises: [
          WorkoutExercise(key: 'rowing'),
          WorkoutExercise(key: 'elliptical'),
          WorkoutExercise(key: 'stairClimber'),
          WorkoutExercise(key: 'hiit'),
        ],
      ),
      WorkoutSubCategory(
        key: 'bodyweightCardio',
        exercises: [
          WorkoutExercise(key: 'jumpRope'),
          WorkoutExercise(key: 'burpees'),
          WorkoutExercise(key: 'mountainClimbers'),
        ],
      ),
    ],
  ),
];
