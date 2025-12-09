import 'package:adicto_school/screens/app_tier_screen.dart';
import 'package:adicto_school/screens/classes_screen.dart';
import 'package:adicto_school/screens/dashboard_screen.dart';
import 'package:adicto_school/screens/revenue_screen.dart';
import 'package:adicto_school/screens/subscription_history_screen.dart';
import 'package:adicto_school/screens/subscription_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  final List<Widget> _screens = [
    const DashboardScreen(),
    const ClassesScreen(),
    const AppTierScreen(),
    const SubscriptionHistoryScreen(),
    // Simple Menu for More
    Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text('More')),
          body: ListView(
            children: [
              ListTile(
                title: const Text('Revenue Overview'),
                leading: const Icon(Icons.bar_chart),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RevenueScreen()),
                ),
              ),
              ListTile(
                title: const Text('Manage Subscription Plans'),
                leading: const Icon(Icons.edit_note),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SubscriptionScreen()),
                ),
              ),
            ],
          ),
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Classes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'My Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.touch_app_outlined),
            activeIcon: Icon(Icons.touch_app),
            label: 'Subscriber',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'More'),
        ],
      ),
    );
  }
}
