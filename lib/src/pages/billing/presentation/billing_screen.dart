import 'package:adicto_school/src/pages/main/presentation/main_desktop.dart'
    as desktop_main;
import 'billing_mobile.dart' as mobile;
import 'package:flutter/material.dart';

class AppTierScreen extends StatelessWidget {
  const AppTierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const mobile.AppTierScreen();
        } else {
          return desktop_main.MainScreen(
            initialLocalRoute: 'AppTier',
            onIndexChanged: (index) {
              Navigator.pop(context);
            },
          );
        }
      },
    );
  }
}
