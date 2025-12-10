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
    if (index == 4) {
      // More tab - show popup menu
      _showMoreMenu(context);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showMoreMenu(BuildContext context) {
    final RenderBox? button = context.findRenderObject() as RenderBox?;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button!.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      items: [
        PopupMenuItem(
          child: _buildMenuOption(
            icon: Icons.receipt_long,
            title: 'Billing',
            hasBadge: true,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppTierScreen(),
                ),
              );
            },
          ),
        ),
        PopupMenuItem(
          child: _buildMenuOption(
            icon: Icons.account_wallet,
            title: 'Payment Method',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PaymentMethodsScreen(),
                ),
              );
            },
          ),
        ),
        PopupMenuItem(
          child: _buildMenuOption(
            icon: Icons.settings,
            title: 'Setting',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileSettingScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool hasBadge = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            Stack(
              children: [
                Icon(icon, color: const Color(0xFF333333), size: 24),
                if (hasBadge)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: GoogleFonts.outfit(
                color: const Color(0xFF333333),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Screen titles
  final List<String> _screenTitles = [
    'Dashboard',
    'Classes & Schedule',
    'Subscription Plans',
    'Subscription History',
    'More',
  ];

  // Screens list
  final List<Widget> _screens = [
    const DashboardScreen(),
    const ClassesScreen(),
    const SubscriptionScreen(), // My Plan points to Subscription List
    const SubscriptionHistoryScreen(),
    // More Menu - Empty screen since we show popup menu
    const Scaffold(
      backgroundColor: Color(0xFFFAF9F6),
      body: Center(
        child: Text('Tap More to see options'),
      ),
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
      body: Column(
        children: [
          // Screen Title below AppBar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _screenTitles[_selectedIndex],
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF333333),
                ),
              ),
            ),
          ),
          // Screen Content
          Expanded(
            child: IndexedStack(index: _selectedIndex, children: _screens),
          ),
        ],
      ),
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
