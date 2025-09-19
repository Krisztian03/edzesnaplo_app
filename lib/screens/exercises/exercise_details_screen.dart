import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../models/Exercise.dart';
import '../../models/exercise_set.dart';
import '../../utils/tr.dart';

class ExerciseDetailsScreen extends StatefulWidget {
  final Exercise exercise;

  const ExerciseDetailsScreen({super.key, required this.exercise});

  @override
  State<ExerciseDetailsScreen> createState() => _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState extends State<ExerciseDetailsScreen> {
  static const int maxSets = 10;

  late int sets;
  late List<ExerciseSet> exerciseSets;
  final TextEditingController notesController = TextEditingController();

  double get volume {
    double sum = 0;
    for (int i = 0; i < sets; i++) {
      sum += exerciseSets[i].reps * exerciseSets[i].weight;
    }
    return sum;
  }

  @override
  void initState() {
    super.initState();
    sets = widget.exercise.sets.length;
    exerciseSets = List.generate(maxSets, (i) {
      if (i < sets) return widget.exercise.sets[i];
      return ExerciseSet(reps: 10, weight: 0);
    });
    notesController.text = '';
  }

  void _updateWeight(int index, double value) {
    setState(() {
      exerciseSets[index].weight = value;
      if (index == 0) {
        for (int i = 1; i < sets; i++) {
          exerciseSets[i].weight = value;
        }
      }
    });
  }

  void _updateReps(int index, int value) {
    setState(() {
      exerciseSets[index].reps = value;
    });
  }

  void _save() {
    Navigator.pop(
      context,
      Exercise(
        name: widget.exercise.name,
        sets: exerciseSets.sublist(0, sets),
        isCompleted: widget.exercise.isCompleted,
      ),
    );
  }

  void _loadTemplate() {
    setState(() {
      sets = 3;
      for (int i = 0; i < maxSets; i++) {
        exerciseSets[i].reps = 10;
        exerciseSets[i].weight = 50.0;
      }
      notesController.text = '';
    });
  }

  Widget _buildStepper(String label, int value, void Function(int) onChanged,
      {int min = 0, int max = 100}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.white)),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove, color: Colors.white),
              onPressed: () {
                if (value > min) onChanged(value - 1);
              },
            ),
            Text('$value', style: const TextStyle(fontSize: 16, color: Colors.white)),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                if (value < max) onChanged(value + 1);
              },
            ),
          ],
        )
      ],
    );
  }

  Widget _buildWeightField(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Set ${index + 1}:', style: const TextStyle(color: Colors.white)),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.remove, color: Colors.white),
              onPressed: () {
                _updateWeight(index, (exerciseSets[index].weight - 2.5).clamp(0, 999));
              },
            ),
            SizedBox(
              width: 60,
              child: TextField(
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
                controller: TextEditingController(
                    text: exerciseSets[index].weight.toStringAsFixed(1)),
                onChanged: (val) {
                  final parsed = double.tryParse(val);
                  if (parsed != null) _updateWeight(index, parsed);
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                _updateWeight(index, exerciseSets[index].weight + 2.5);
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(tr(context, widget.exercise.name)),
        backgroundColor: const Color(0xFF071f35),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: const Color(0xFF071f35),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildStepper(loc.sets, sets, (val) {
              setState(() => sets = val);
            }, min: 1, max: maxSets),
            const SizedBox(height: 16),
            Column(
              children: List.generate(sets, (i) {
                return _buildStepper('Reps Set ${i + 1}', exerciseSets[i].reps,
                        (val) => _updateReps(i, val), min: 1, max: 50);
              }),
            ),
            const SizedBox(height: 16),
            Column(
              children: List.generate(sets, (i) => _buildWeightField(i)),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Volume:', style: TextStyle(color: Colors.white)),
                Text('${volume.toStringAsFixed(1)} kg',
                    style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: notesController,
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Notes',
                labelStyle: const TextStyle(color: Colors.white70),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white38)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyanAccent)),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _save,
                    child: Text(loc.save),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _loadTemplate,
                    child: Text(loc.loadTemplate),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
