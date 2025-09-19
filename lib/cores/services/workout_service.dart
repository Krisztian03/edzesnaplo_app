import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/Workout_entry.dart';


class WorkoutService {
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  final _firestore = FirebaseFirestore.instance;

  Future<void> saveWorkout(WorkoutEntry entry) async {
    if (uid == null) return;
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('workouts')
        .add(entry.toJson());
  }

  Future<List<WorkoutEntry>> getWorkoutsForDay(DateTime day) async {
    if (uid == null) return [];
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(Duration(days: 1));

    final snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('workouts')
        .where('date', isGreaterThanOrEqualTo: start.toIso8601String())
        .where('date', isLessThan: end.toIso8601String())
        .get();

    return snapshot.docs.map((d) => WorkoutEntry.fromJson(d.data())).toList();
  }
}
