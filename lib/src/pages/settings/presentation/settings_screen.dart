import 'package:adicto_school/src/pages/main/presentation/main_desktop.dart'
    as desktop_main;
import 'settings_mobile.dart' as mobile;
import 'package:flutter/material.dart';

class ProfileSettingScreen extends StatelessWidget {
  const ProfileSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const mobile.ProfileSettingScreen();
        } else {
          return desktop_main.MainScreen(
            selectedIndex: 4, // Setting tab
            onIndexChanged: (index) {
              // MainScreen acts as the shell, so navigation is handled internally
              // or bubbling up if needed.
            },
          );
        }
      },
    );
  }
}
