import 'package:adicto_school/src/pages/main/presentation/main_desktop.dart'
    as desktop_main;
import 'add_subscriber_mobile.dart' as mobile;
import 'package:flutter/material.dart';

class AddSubscriberScreen extends StatelessWidget {
  const AddSubscriberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 700) {
          return const mobile.AddSubscriberScreen();
        } else {
          return desktop_main.MainScreen(
            selectedIndex: 3, // Subscriber tab
            initialLocalRoute: 'AddSubscriber',
            onIndexChanged: (index) {
              Navigator.pop(context);
            },
          );
        }
      },
    );
  }
}
