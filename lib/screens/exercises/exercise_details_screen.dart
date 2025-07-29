import 'package:edzesnaplo/screens/training/training_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class ExerciseDetailsScreen extends StatefulWidget {
  final String exerciseKey;

  const ExerciseDetailsScreen({super.key, required this.exerciseKey});

  @override
  State<ExerciseDetailsScreen> createState() => _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState extends State<ExerciseDetailsScreen> {
  final _setsController = TextEditingController();
  final _repsController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void dispose() {
    _setsController.dispose();
    _repsController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _save() {
    final sets = int.tryParse(_setsController.text) ?? 0;
    final reps = int.tryParse(_repsController.text) ?? 0;
    final weight = double.tryParse(_weightController.text) ?? 0.0;

    if (sets > 0 && reps > 0) {
      Navigator.pop(context, {
        'exercise': widget.exerciseKey,
        'sets': sets,
        'reps': reps,
        'weight': weight,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.getString(widget.exerciseKey)),
        backgroundColor: const Color(0xFF071f35),
      ),
      backgroundColor: const Color(0xFF071f35),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextField(loc.sets, _setsController),
            _buildTextField(loc.reps, _repsController),
            _buildTextField(loc.weightOptional, _weightController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _save,
              child: Text(loc.save),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white38)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.cyanAccent)),
        ),
      ),
    );
  }
}
