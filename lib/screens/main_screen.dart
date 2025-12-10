import 'package:adicto_school/screens/app_tier_screen.dart';
import 'package:adicto_school/screens/classes_screen.dart';
import 'package:adicto_school/screens/dashboard_screen.dart';
import 'package:adicto_school/screens/payment_methods_screen.dart';
import 'package:adicto_school/screens/profile_setting_screen.dart';
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
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              _buildMenuOption(
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
              const Divider(height: 1),
              _buildMenuOption(
                icon: Icons.wallet,
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
              const Divider(height: 1),
              _buildMenuOption(
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
              const SizedBox(height: 20),
            ],
          ),
        );
      },
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
      body: Center(child: Text('Tap More to see options')),
    ),
  ];

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
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: const AssetImage('images/icons/profile.jpg'),
              onBackgroundImageError: (exception, stackTrace) {
                // Fallback if image doesn't load
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Screen Title below AppBar (hidden for Classes screen)
          if (_selectedIndex != 1)
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
            )
          else
            const SizedBox(height: 8),
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
        items: [
          BottomNavigationBarItem(
            icon: _buildCustomIcon('images/icons/home.png', 0),
            activeIcon: _buildCustomIcon(
              'images/icons/home.png',
              0,
              isActive: true,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildCustomIcon('images/icons/class.png', 1),
            activeIcon: _buildCustomIcon(
              'images/icons/class.png',
              1,
              isActive: true,
            ),
            label: 'Classes',
          ),
          BottomNavigationBarItem(
            icon: _buildCustomIcon('images/icons/plan.png', 2),
            activeIcon: _buildCustomIcon(
              'images/icons/plan.png',
              2,
              isActive: true,
            ),
            label: 'My Plan',
          ),
          BottomNavigationBarItem(
            icon: _buildCustomIcon('images/icons/subscribe.png', 3),
            activeIcon: _buildCustomIcon(
              'images/icons/subscribe.png',
              3,
              isActive: true,
            ),
            label: 'Subscriber',
          ),
          BottomNavigationBarItem(
            icon: _buildCustomIcon('images/icons/more.png', 4),
            activeIcon: _buildCustomIcon(
              'images/icons/more.png',
              4,
              isActive: true,
            ),
            label: 'More',
          ),
        ],
      ),
    );
  }

  Widget _buildCustomIcon(
    String assetPath,
    int index, {
    bool isActive = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Image.asset(
        assetPath,
        width: 24,
        height: 24,
        color: isActive ? const Color(0xFF0085FF) : Colors.grey,
        errorBuilder: (context, error, stackTrace) {
          // Fallback to default icon if image doesn't load
          final fallbackIcons = [
            Icons.grid_view,
            Icons.calendar_today,
            Icons.format_list_bulleted,
            Icons.people,
            Icons.menu,
          ];
          return Icon(
            fallbackIcons[index],
            color: isActive ? const Color(0xFF0085FF) : Colors.grey,
            size: 24,
          );
        },
      ),
    );
  }
}
