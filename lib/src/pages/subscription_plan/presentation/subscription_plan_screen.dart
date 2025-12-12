import 'subscription_plan_mobile.dart' as mobile;
import 'package:adicto_school/src/pages/main/presentation/main_desktop.dart'
    as desktop_main;

import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const mobile.SubscriptionScreen();
        } else {
          return desktop_main.MainScreen(
            initialLocalRoute: 'My Plan',
            onIndexChanged: (index) {
              Navigator.pop(context);
            },
          );
        }
      },
    );
  }
}
