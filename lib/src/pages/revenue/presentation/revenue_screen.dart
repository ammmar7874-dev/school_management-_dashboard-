import 'package:adicto_school/src/pages/main/presentation/main_desktop.dart'
    as desktop_main;
import 'revenue_mobile.dart' as mobile;
import 'package:flutter/material.dart';

class RevenueScreen extends StatelessWidget {
  const RevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const mobile.RevenueScreen();
        } else {
          return desktop_main.MainScreen(
            initialLocalRoute: 'Revenue',
            onIndexChanged: (index) {
              // Return to dashboard on index change or back
              Navigator.pop(context);
            },
          );
        }
      },
    );
  }
}
