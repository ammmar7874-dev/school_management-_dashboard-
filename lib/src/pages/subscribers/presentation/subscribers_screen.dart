import 'subscribers_mobile.dart' as mobile;
import 'package:adicto_school/src/pages/main/presentation/main_desktop.dart'
    as desktop_main;
import 'package:flutter/material.dart';

class SubscriptionHistoryScreen extends StatelessWidget {
  const SubscriptionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const mobile.SubscriptionHistoryScreen();
        } else {
          return desktop_main.MainScreen(
            initialLocalRoute: 'Subscriber',
            onIndexChanged: (index) {
              // If index changes (e.g. clicked sidebar), pop this wrapper if it was pushed?
              // Actually, if we are in MainScreen, we expect it to handle navigation.
              // But if this wrapper is used as a standalone page, we might need to handle popping or just rely on MainScreen's state.
              Navigator.pop(context);
            },
          );
        }
      },
    );
  }
}
