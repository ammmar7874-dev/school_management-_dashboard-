import 'main_mobile.dart' as mobile;
import 'main_desktop.dart' as desktop;
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

  void _onIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String _getDesktopRoute(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Classes';
      case 2:
        return 'My Plan';
      case 3:
        return 'Subscriber';
      case 4:
        return 'Setting';
      default:
        return 'Home';
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobile.MainScreen(
            selectedIndex: _selectedIndex,
            onIndexChanged: _onIndexChanged,
          );
        } else {
          return desktop.MainScreen(
            initialRoute: _getDesktopRoute(_selectedIndex),
            selectedIndex: _selectedIndex,
            onIndexChanged: _onIndexChanged,
          );
        }
      },
    );
  }
}
