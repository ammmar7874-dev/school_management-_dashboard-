import 'package:adicto_school/src/pages/main/presentation/main_screen.dart';
import 'package:adicto_school/src/pages/billing/presentation/billing_screen.dart';
import 'package:adicto_school/src/pages/payment_methods/presentation/payment_methods_screen.dart';
import 'package:adicto_school/src/pages/settings/presentation/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenWithBottomNav extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool showBackButton;
  final int? currentIndex;

  const ScreenWithBottomNav({
    super.key,
    required this.child,
    this.title,
    this.showBackButton = true,
    this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF9F6),
        elevation: 0,
        leading: showBackButton
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        automaticallyImplyLeading: false,
        title: title != null
            ? Text(
                title!,
                style: GoogleFonts.outfit(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            : Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7F56D9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.school,
                      color: Colors.white,
                      size: 20,
                    ),
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
      body: child,
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex ?? 0,
      onTap: (index) {
        if (index == 4) {
          _showMoreMenu(context);
          return;
        }
        // Navigate to MainScreen with the selected index
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(initialIndex: index),
          ),
          (route) => false,
        );
      },
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
}
