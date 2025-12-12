import 'package:adicto_school/src/pages/main/presentation/main_desktop.dart'
    as desktop_main;
import 'add_class_mobile.dart' as mobile;
import 'package:flutter/material.dart';

class AddClassScreen extends StatelessWidget {
  const AddClassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const mobile.AddClassScreen();
        } else {
          return desktop_main.MainScreen(
            selectedIndex: 1, // Classes tab active foundation
            initialLocalRoute: 'AddClass', // Force open Add Class
            onIndexChanged: (index) {
              Navigator.pop(context);
            },
          );
        }
      },
    );
  }
}
