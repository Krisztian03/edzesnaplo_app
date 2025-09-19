import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../cores/services/workout_service.dart';
import '../../models/Exercise.dart';
import '../../models/Workout_entry.dart';
import '../../models/exercise_set.dart';
import '../../models/workout_repository.dart';
import '../../utils/tr.dart';
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
  String? _selectedSubCategoryKey;

  late final workoutService = WorkoutService();
  List<WorkoutEntry> _workouts = [];

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

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
      await _loadWorkouts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final weekStart = _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));

    return Scaffold(
      backgroundColor: const Color(0xFF071f35),
      appBar: AppBar(
        title: Text(tr(context, 'training'), style: const TextStyle(color: Colors.white)),
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
              // heti napválasztó
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    final date = weekStart.add(Duration(days: index));
                    final isSelected = date.day == _selectedDate.day && date.month == _selectedDate.month;

                    return GestureDetector(
                      onTap: () async {
                        setState(() => _selectedDate = date);
                        await _loadWorkouts();
                      },
                      child: Container(
                        width: 48,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.cyanAccent : Colors.white10,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat.E(Localizations.localeOf(context).languageCode).format(date),
                              style: TextStyle(
                                color: isSelected ? Colors.black : Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              date.day.toString(),
                              style: TextStyle(
                                color: isSelected ? Colors.black : Colors.white,
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
              // gomb új edzéshez
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  foregroundColor: Colors.black,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.add),
                label: Text(tr(context, 'addWorkout')),
                onPressed: () {
                  setState(() {
                    _showCategorySheet = true;
                    _selectedCategoryKey = null;
                    _selectedSubCategoryKey = null;
                  });
                },
              ),
              const SizedBox(height: 16),
              // edzéslista
              Expanded(
                child: _workouts.isEmpty
                    ? Center(
                  child: Text(
                    tr(context, 'noWorkouts'),
                    style: const TextStyle(color: Colors.white70),
                  ),
                )
                    : ListView.builder(
                  itemCount: _workouts.length,
                  itemBuilder: (_, i) {
                    final entry = _workouts[i];
                    return Card(
                      color: Colors.white10,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ExpansionTile(
                        title: Text(tr(context, entry.key), style: const TextStyle(color: Colors.white)),
                        children: entry.exercises.map((exercise) {
                          return Card(
                            color: Colors.white12,
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Gyakorlat neve + összesített volume
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        exercise.name,
                                        style: const TextStyle(
                                            color: Colors.cyanAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        'Volume: ${exercise.sets.fold(0.0, (sum, s) => sum + s.reps * s.weight)} kg',
                                        style: const TextStyle(
                                            color: Colors.yellowAccent,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  // Szettek Wrap-ben, vizuálisan rendezve
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 4,
                                    children: exercise.sets.map((set) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.white10,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          '${set.reps} x ${set.weight} kg',
                                          style: const TextStyle(color: Colors.white70),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),

                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // Bottom Sheet – hierarchia
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
                                    ? tr(context, 'chooseCategory')
                                    : _selectedSubCategoryKey == null
                                    ? tr(context, _selectedCategoryKey!)
                                    : tr(context, _selectedSubCategoryKey!),
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),

                              // 1) Kategória választás
                              if (_selectedCategoryKey == null)
                                Expanded(
                                  child: ListView(
                                    children: workoutCategories.map((cat) {
                                      return ListTile(
                                        leading: Icon(cat.icon),
                                        title: Text(tr(context, cat.key)),
                                        trailing: const Icon(Icons.arrow_forward),
                                        onTap: () {
                                          setState(() => _selectedCategoryKey = cat.key);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                )

                              // 2) SubCategory választás
                              else if (_selectedSubCategoryKey == null)
                                Expanded(
                                  child: ListView(
                                    children: workoutCategories
                                        .firstWhere((c) => c.key == _selectedCategoryKey)
                                        .subCategories
                                        .map((sub) {
                                      return ListTile(
                                        title: Text(tr(context, sub.key)),
                                        trailing: const Icon(Icons.arrow_forward),
                                        onTap: () {
                                          setState(() => _selectedSubCategoryKey = sub.key);
                                        },
                                      );
                                    }).toList(),
                                  ),
                                )

                              // 3) Exercise választás
                              else
                                Expanded(
                                  child: ListView(
                                    children: workoutCategories
                                        .firstWhere((c) => c.key == _selectedCategoryKey)
                                        .subCategories
                                        .firstWhere((s) => s.key == _selectedSubCategoryKey)
                                        .exercises
                                        .map((ex) => ListTile(
                                      title: Text(tr(context, ex.key)),
                                      trailing: const Icon(Icons.add),
                                      onTap: () async {
                                        final result = await Navigator.push<Exercise>(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => ExerciseDetailsScreen(
                                              exercise: Exercise(
                                                name: ex.key,
                                                sets: List.generate(3, (_) => ExerciseSet(reps: 10, weight: 0)),
                                              ),
                                            ),
                                          ),
                                        );

                                        if (result != null) {
                                          // Ellenőrizzük, van-e már entry a kategóriára és napra
                                          WorkoutEntry? existingEntry;
                                          for (var e in _workouts) {
                                            if (e.key == _selectedCategoryKey && e.date == _selectedDate) {
                                              existingEntry = e;
                                              break;
                                            }
                                          }

                                          if (existingEntry != null) {
                                            existingEntry.exercises.add(result);
                                            await workoutService.updateWorkout(existingEntry);
                                          } else {
                                            final entry = WorkoutEntry(
                                              key: _selectedCategoryKey!,
                                              date: _selectedDate,
                                              exercises: [result],
                                            );
                                            await workoutService.saveWorkout(entry);
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
                                    if (_selectedSubCategoryKey != null) {
                                      setState(() => _selectedSubCategoryKey = null);
                                    } else if (_selectedCategoryKey != null) {
                                      setState(() => _selectedCategoryKey = null);
                                    } else {
                                      setState(() => _showCategorySheet = false);
                                    }
                                  },
                                  child: Text(
                                    _selectedCategoryKey == null
                                        ? tr(context, 'close')
                                        : tr(context, 'back'),
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
