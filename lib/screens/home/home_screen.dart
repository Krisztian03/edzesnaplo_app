import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../cores/services/daily_data_service.dart';
import '../../cores/services/step_tracker_service.dart';
import '../../l10n/app_localizations.dart';
import '../profile/profile_screen.dart';
import '../training/training_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _stepCount = 0;
  int _waterAmount = 0;
  DateTime? _lastFetchDate;
  int _lastSavedStepCount = 0;
  late StreamSubscription<int> _stepSubscription;
  final StepTrackerService _stepTrackerService = StepTrackerService();
  final DailyDataService _dailyDataService = DailyDataService();



  @override
  void initState() {
    super.initState();
    _requestPermission();
    _loadDailyData();
    _scheduleMidnightReset();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initPedometer();
  }

  void _scheduleMidnightReset() {
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    final durationUntilMidnight = nextMidnight.difference(now);

    Timer(durationUntilMidnight, () async {
      setState(() {
        _stepCount = 0;
        _waterAmount = 0;
      });

      await _dailyDataService.saveStepCount(0);
      await _dailyDataService.saveWaterIntake(0);

      _scheduleMidnightReset(); // újraütemezés másnapra
    });
  }


  Future<void> _requestPermission() async {
    var status = await Permission.activityRecognition.status;
    if (!status.isGranted) {
      status = await Permission.activityRecognition.request();
      if (!status.isGranted) {
        print('Activity Recognition permission denied.');
      }
    }
  }

  Future<void> _loadDailyData() async {
    final today = DateTime.now();
    final data = await _dailyDataService.getTodayData();

    // Szinkronizálás Firestore-ba, ha volt mentett lépésszám offline
    final cachedSteps = await _dailyDataService.getCachedStepCount();
    if (cachedSteps != null && cachedSteps > _stepCount) {
      await _dailyDataService.saveStepCount(cachedSteps);
      await _dailyDataService.saveStepCountHistory(cachedSteps);
      _stepCount = cachedSteps;
    }



    if (_lastFetchDate != null &&
        _lastFetchDate!.day != today.day) {
      setState(() {
        _stepCount = 0;
        _waterAmount = 0;
      });
      await _dailyDataService.saveStepCount(0);
      await _dailyDataService.saveWaterIntake(0);
    } else {
      setState(() {
        _stepCount = data['steps'] ?? 0;
        _waterAmount = data['water'] ?? 0;
      });
    }

    _lastFetchDate = today;
  }


  void _initPedometer() {
    final loc = AppLocalizations.of(context)!;

    _stepTrackerService.init(
      localize: (key) {
        switch (key) {
          case 'stepCounterError':
            return loc.stepCounterError;
          case 'pedestrianStatusError':
            return loc.pedestrianStatusError;
          default:
            return key;
        }
      },
    );

    _stepSubscription = _stepTrackerService.stepCountStream.listen((count) async {
      setState(() {
        _stepCount = count;
      });

      if ((count - _lastSavedStepCount).abs() >= 100) {
        _lastSavedStepCount = count;

        try {
          await _dailyDataService.saveStepCount(count);
          await _dailyDataService.saveStepCount(count);
          await _dailyDataService.saveStepCountHistory(count);
        } catch (e) {
          // Offline fallback
          await _dailyDataService.saveStepCountLocally(count);
        }
      }
    });

  }

  void _showWaterModal(AppLocalizations loc) {
    final TextEditingController _controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0D2B45),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.water_drop, size: 48, color: Colors.cyanAccent),
              const SizedBox(height: 12),
              Text(
                loc.waterIntake,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "${(_waterAmount / 1000).toStringAsFixed(1)} L",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: loc.enterWaterAmount,
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white30),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyanAccent),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: Text(loc.add),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  foregroundColor: Colors.black,
                ),
                onPressed: () async {
                  final amount = int.tryParse(_controller.text.trim());
                  if (amount == null || amount <= 0 || amount > 5000 || amount <= 150) {
                    Navigator.pop(context);
                    Future.delayed(Duration(milliseconds: 200), () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(loc.invalidAmount)),
                      );
                    });
                    return;
                  }

                  final newAmount = _waterAmount + amount;
                  if (newAmount > 10000) {
                    Navigator.pop(context);
                    Future.delayed(Duration(milliseconds: 200), () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(loc.dailyLimitExceeded)),
                      );
                    });
                    return;
                  }

                  // Először bezárjuk a modalt, hogy ne legyen vizuális késés
                  Navigator.pop(context);
                  // Ezután frissítjük az állapotot és mentjük
                  setState(() => _waterAmount = newAmount);
                  await _dailyDataService.saveWaterIntake(newAmount);

                  // Kis delay után mutatjuk a snackbar-t
                  Future.delayed(Duration(milliseconds: 200), () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${(amount / 1000).toStringAsFixed(1)} L ${loc.waterAddedSuccess}')),
                    );
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }



  @override
  void dispose() {
    _stepSubscription.cancel();
    _stepTrackerService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;
    final name = user?.displayName ?? user?.email?.split('@').first ?? 'User';


    final List<Widget> screens = [
      _buildDashboard(name, loc),
      const TrainingScreen(),
      Center(child: Text(loc.exercises, style: const TextStyle(color: Colors.white))),
      Center(child: Text(loc.report, style: const TextStyle(color: Colors.white))),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF071f35),
      body: SafeArea(child: screens[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF071f35),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.white54,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: loc.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.fitness_center),
            label: loc.training,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list),
            label: loc.exercises,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bar_chart),
            label: loc.report,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: loc.profile,
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard(String name, AppLocalizations loc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(name, loc),
        _buildDateSelector(loc),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.count(
            padding: const EdgeInsets.all(16),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildInfoCard(Icons.directions_walk, loc.steps, '$_stepCount', Colors.orange),
              _buildInfoCard(Icons.nightlight_round, loc.sleep, "8h", Colors.indigo),
              GestureDetector(
                onTap: () => _showWaterModal(loc),
                child: _buildInfoCard(
                  Icons.water_drop,
                  loc.water,
                  "${(_waterAmount / 1000).toStringAsFixed(1)}L",
                  Colors.cyanAccent,
                ),
              ),

              _buildInfoCard(Icons.favorite, loc.heartRate, "90bpm", Colors.red),
              _buildInfoCard(Icons.directions_bike, loc.cycling, "40min", Colors.green),
              _buildInfoCard(Icons.local_fire_department, loc.calories, "750kcal", Colors.purple),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(String name, AppLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Hello, $name 👋',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const CircleAvatar(
            backgroundColor: Colors.white12,
            child: Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector(AppLocalizations loc) {
    final days = [
      loc.mondayShort,
      loc.tuesdayShort,
      loc.wednesdayShort,
      loc.thursdayShort,
      loc.fridayShort,
      loc.saturdayShort,
      loc.sundayShort,
    ];

    final today = DateTime.now().weekday - 1;

    return SizedBox(
      height: 50,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isToday = index == today;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isToday ? Colors.cyanAccent : Colors.white10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                days[index],
                style: TextStyle(
                  color: isToday ? Colors.black : Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
