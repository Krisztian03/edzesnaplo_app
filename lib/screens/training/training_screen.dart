import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../cores/services/workout_service.dart';
import '../../l10n/app_localizations.dart';
import '../../models/Exercise.dart';
import '../../models/Workout_entry.dart';
import '../exercises/exercise_details_screen.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  DateTime _selectedDate = DateTime.now();
  bool _showCategorySheet = false;
  String? _selectedCategoryKey;
  late final workoutService = WorkoutService();
  List<WorkoutEntry> _workouts = [];


  Future<void> _loadWorkouts() async {
    final workouts = await workoutService.getWorkoutsForDay(_selectedDate);
    setState(() => _workouts = workouts.cast<WorkoutEntry>());
  }


  void _pickDateFromCalendar() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: Localizations.localeOf(context),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }


  List<WorkoutCategory> _categories(AppLocalizations loc) => [
    WorkoutCategory(
      key: 'chest',
      icon: Icons.fitness_center,
      exercises: ['benchPress', 'pushUps'],
    ),
    WorkoutCategory(
      key: 'back',
      icon: Icons.swap_vert,
      exercises: ['pullUps'],
    ),
    WorkoutCategory(
      key: 'legs',
      icon: Icons.directions_run,
      exercises: ['squats'],
    ),
    WorkoutCategory(
      key: 'arms',
      icon: Icons.accessibility_new,
      exercises: ['bicepCurls'],
    ),
  ];


  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }


  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final weekStart =
    _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));

    return Scaffold(
      backgroundColor: const Color(0xFF071f35),
      appBar: AppBar(
        title: Text(loc.training, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF071f35),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            onPressed: _pickDateFromCalendar,
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 16),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    final date = weekStart.add(Duration(days: index));
                    final isSelected =
                        date.day == _selectedDate.day &&
                            date.month == _selectedDate.month;

                    return GestureDetector(
                      onTap: () => setState(() => _selectedDate = date),
                      child: Container(
                        width: 48,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.cyanAccent
                              : Colors.white10,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat.E(Localizations.localeOf(context)
                                  .languageCode)
                                  .format(date),
                              style: TextStyle(
                                color:
                                isSelected ? Colors.black : Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              date.day.toString(),
                              style: TextStyle(
                                color:
                                isSelected ? Colors.black : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  foregroundColor: Colors.black,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.add),
                label: Text(loc.addWorkout),
                onPressed: () {
                  setState(() {
                    _showCategorySheet = true;
                    _selectedCategoryKey = null;
                  });
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _workouts.isEmpty
                    ? Center(
                  child: Text(
                    loc.noWorkouts,
                    style: const TextStyle(color: Colors.white70),
                  ),
                )
                    : ListView.builder(
                  itemCount: _workouts.length,
                  itemBuilder: (_, i) {
                    final e = _workouts[i];
                    return ListTile(
                      title: Text(loc.getString(e.key), style: const TextStyle(color: Colors.white)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: e.exercises.map((exercise) {
                          final sets = exercise.sets.map((s) => '${s.reps}x${s.weight}kg').join(', ');
                          return Text(
                            '${exercise.name}: $sets',
                            style: const TextStyle(color: Colors.white70),
                          );
                        }).toList(),
                      ),
                    );
                  },

                ),
              ),
            ],
          ),

          // Bottom Sheet for category & exercise selection
          if (_showCategorySheet)
            Positioned.fill(
              child: GestureDetector(
                onTap: () => setState(() => _showCategorySheet = false),
                child: Container(
                  color: Colors.black54,
                  child: GestureDetector(
                    onTap: () {},
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        heightFactor: 0.9,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selectedCategoryKey == null
                                    ? loc.chooseCategory
                                    : loc.getString(_selectedCategoryKey!),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              if (_selectedCategoryKey == null)
                                Expanded(
                                  child: GridView.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 12,
                                    crossAxisSpacing: 12,
                                    childAspectRatio: 1,
                                    children: _categories(loc).map((cat) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedCategoryKey = cat.key;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.cyan.shade100,
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(cat.icon,
                                                  size: 48, color: Colors.black),
                                              const SizedBox(height: 12),
                                              Text(
                                                loc.getString(cat.key),
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
                              else
                                Expanded(
                                  child: ListView(
                                    children: _categories(loc)
                                        .firstWhere((c) => c.key == _selectedCategoryKey)
                                        .exercises
                                        .map((exKey) => ListTile(
                                      title: Text(loc.getString(exKey)),
                                      trailing: const Icon(Icons.add),
                                      onTap: () async {

                                      final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                      builder: (_) => ExerciseDetailsScreen(exerciseKey: exKey),
                                      ),
                                      );

                                      if (result != null) {
                                        if (result is Exercise) {
                                          final existingEntry = _workouts.firstWhere(
                                                (e) => e.date.day == _selectedDate.day &&
                                                e.date.month == _selectedDate.month &&
                                                e.date.year == _selectedDate.year,
                                            orElse: () => WorkoutEntry(key: exKey, date: _selectedDate, exercises: []),
                                          );

                                          existingEntry.exercises.add(result);

                                          await workoutService.saveWorkout(existingEntry);
                                          await _loadWorkouts();
                                          setState(() => _showCategorySheet = false);
                                        }
                                      await _loadWorkouts();
                                      setState(() => _showCategorySheet = false);
                                      }
                                      },
                                    ))
                                        .toList(),
                                  ),
                                ),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    if (_selectedCategoryKey != null) {
                                      setState(() => _selectedCategoryKey = null);
                                    } else {
                                      setState(() => _showCategorySheet = false);
                                    }
                                  },
                                  child: Text(
                                    _selectedCategoryKey != null
                                        ? loc.back
                                        : loc.close,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class WorkoutCategory {
  final String key;
  final IconData icon;
  final List<String> exercises;

  WorkoutCategory({
    required this.key,
    required this.icon,
    required this.exercises,
  });
}

extension LocExtension on AppLocalizations {
  String getString(String key) {
    switch (key) {
      case 'chest':
        return chest;
      case 'back':
        return back;
      case 'legs':
        return legs;
      case 'arms':
        return arms;
      case 'benchPress':
        return benchPress;
      case 'pushUps':
        return pushUps;
      case 'pullUps':
        return pullUps;
      case 'squats':
        return squats;
      case 'bicepCurls':
        return bicepCurls;
      default:
        return key;
    }
  }
}
