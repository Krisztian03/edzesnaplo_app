import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DailyDataService {
  final _uid = FirebaseAuth.instance.currentUser?.uid;

  Future<Map<String, dynamic>> getTodayData() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final savedDate = prefs.getString('lastUpdatedDate');
    final todayString = "${now.year}-${now.month}-${now.day}";

    if (savedDate != todayString) {
      await prefs.setInt('stepCount', 0);
      await prefs.setInt('waterAmount', 0);
      await prefs.setString('lastUpdatedDate', todayString);

      if (_uid != null) {
        await FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'steps': 0,
          'water': 0,
          'lastUpdatedDate': todayString,
        }, SetOptions(merge: true));
      }

      return {'steps': 0, 'water': 0};
    }

    final steps = prefs.getInt('stepCount') ?? 0;
    final water = prefs.getInt('waterAmount') ?? 0;

    return {'steps': steps, 'water': water};
  }

  Future<void> saveStepCount(int steps) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('stepCount', steps);



    if (_uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(_uid).set({
        'steps': steps,
      }, SetOptions(merge: true));
    }
  }

  Future<void> saveStepCountHistory(int count) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final today = DateTime.now();
    final dateKey = "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    final docRef = FirebaseFirestore.instance.collection('dailyData').doc(userId);
    await docRef.set({
      'stepsHistory.$dateKey': count,
    }, SetOptions(merge: true));
  }

  Future<void> saveStepCountLocally(int count) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('cached_step_count', count);
  }

  Future<int?> getCachedStepCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('cached_step_count');
  }



  Future<void> saveWaterIntake(int water) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('waterAmount', water);

    if (_uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(_uid).set({
        'water': water,
      }, SetOptions(merge: true));
    }
  }
}
