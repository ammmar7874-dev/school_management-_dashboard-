import 'home_mobile.dart' as mobile;
import 'home_desktop.dart' as desktop;
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const mobile.DashboardScreen();
        } else {
          return const desktop.DashboardScreen();
        }
      },
    );
  }
}
