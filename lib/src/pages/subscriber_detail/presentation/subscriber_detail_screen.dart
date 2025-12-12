import 'package:adicto_school/src/pages/main/presentation/main_desktop.dart'
    as desktop_main;
import 'subscriber_detail_mobile.dart' as mobile;
import 'package:flutter/material.dart';

class SubscriberDetailScreen extends StatelessWidget {
  const SubscriberDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const mobile.SubscriberDetailScreen();
        } else {
          return desktop_main.MainScreen(
            selectedIndex: 3, // Subscriber tab
            initialLocalRoute: 'SubscriberDetail',
            onIndexChanged: (index) {
              Navigator.pop(context);
            },
          );
        }
      },
    );
  }
}
