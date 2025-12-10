import 'package:adicto_school/screens/main_screen.dart';
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
}
