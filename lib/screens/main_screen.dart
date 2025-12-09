import 'package:adicto_school/screens/app_tier_screen.dart';
import 'package:adicto_school/screens/choose_plan_screen.dart';
import 'package:adicto_school/screens/classes_screen.dart';
import 'package:adicto_school/screens/dashboard_screen.dart';
import 'package:adicto_school/screens/notification_history_screen.dart';
import 'package:adicto_school/screens/payment_methods_screen.dart';
import 'package:adicto_school/screens/profile_setting_screen.dart';
import 'package:adicto_school/screens/revenue_screen.dart';
import 'package:adicto_school/screens/send_notification_screen.dart';
import 'package:adicto_school/screens/subscription_history_screen.dart';
import 'package:adicto_school/screens/subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Screens list
  final List<Widget> _screens = [
    const DashboardScreen(),
    const ClassesScreen(),
    const SubscriptionScreen(), // My Plan points to Subscription List
    const SubscriptionHistoryScreen(),
    // More Menu
    Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: const Color(0xFFFAF9F6),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildMenuItem(
                context,
                'Revenue Overview',
                Icons.bar_chart,
                const RevenueScreen(),
              ),
              _buildMenuItem(
                context,
                'Manage Subscription Plans',
                Icons.edit_note,
                const SubscriptionScreen(),
              ),
              const Divider(),
              _buildMenuItem(
                context,
                'Choose Plan (SaaS Tier)',
                Icons.workspace_premium,
                const ChoosePlanScreen(),
              ),
              _buildMenuItem(
                context,
                'Payment Methods',
                Icons.payment,
                const PaymentMethodsScreen(),
              ),
              const Divider(),
              _buildMenuItem(
                context,
                'Send Notification',
                Icons.send,
                const SendNotificationScreen(),
              ),
              _buildMenuItem(
                context,
                'Notification History',
                Icons.history,
                const NotificationHistoryScreen(),
              ),
              const Divider(),
              _buildMenuItem(
                context,
                'App Tier & Billing',
                Icons.star,
                const AppTierScreen(),
              ),
              _buildMenuItem(
                context,
                'Profile Settings',
                Icons.person,
                const ProfileSettingScreen(),
              ),
            ],
          ),
        );
      },
    ),
  ];

  static Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    Widget screen,
  ) {
    return ListTile(
      title: Text(title, style: GoogleFonts.outfit()),
      leading: Icon(icon, color: const Color(0xFF0085FF)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF9F6),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFF7F56D9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.school, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            Text(
              'Adicto School',
              style: GoogleFonts.outfit(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/150?u=a042581f4e29026024d',
              ),
            ),
          ),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0085FF),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: GoogleFonts.outfit(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: GoogleFonts.outfit(fontSize: 12),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Classes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            label: 'My Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Subscriber',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'More'),
        ],
      ),
    );
  }
}
