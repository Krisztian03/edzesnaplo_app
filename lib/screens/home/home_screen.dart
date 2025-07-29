import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final user = FirebaseAuth.instance.currentUser;
    final name = user?.displayName ?? user?.email?.split('@').first ?? 'User';

    final List<Widget> screens = [
      _buildDashboard(name), // Főoldal
      const TrainingScreen(),
      Center(child: Text(loc.exercises, style: TextStyle(color: Colors.white))),
      Center(child: Text(loc.report, style: TextStyle(color: Colors.white))),
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
        // Menu bar
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: loc.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: loc.training,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: loc.exercises,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: loc.report,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: loc.profile,
          ),
        ],
      ),
    );
  }

// Main dashboard
  Widget _buildDashboard(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(name),
        _buildDateSelector(),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.count(
            padding: const EdgeInsets.all(16),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildInfoCard(Icons.directions_walk, "Steps", "3214", Colors.orange),
              _buildInfoCard(Icons.nightlight_round, "Sleep", "8h", Colors.indigo),
              _buildInfoCard(Icons.water_drop, "Water", "1.6L", Colors.cyanAccent),
              _buildInfoCard(Icons.favorite, "Heart rate", "90bpm", Colors.red),
              _buildInfoCard(Icons.directions_bike, "Cycling", "40min", Colors.green),
              _buildInfoCard(Icons.local_fire_department, "Calories", "750kcal", Colors.purple),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(String name) {
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

  Widget _buildDateSelector() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
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
