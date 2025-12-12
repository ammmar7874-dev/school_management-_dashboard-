import 'package:flutter/material.dart';
import 'package:adicto_school/src/pages/main/presentation/main_desktop.dart'
    as desktop_main;
import 'choose_plan_mobile.dart' as mobile;

class ChoosePlanScreen extends StatelessWidget {
  const ChoosePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const mobile.ChoosePlanScreen();
        } else {
          return desktop_main.MainScreen(
            initialLocalRoute: 'ChoosePlan',
            onIndexChanged: (index) {
              Navigator.pop(context);
            },
          );
        }
      },
    );
  }
}
