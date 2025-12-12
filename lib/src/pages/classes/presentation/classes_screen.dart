import 'classes_mobile.dart' as mobile;
import 'classes_desktop.dart' as desktop;
import 'package:flutter/material.dart';

class ClassesScreen extends StatelessWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const mobile.ClassesScreen();
        } else {
          return const desktop.ClassesScreen();
        }
      },
    );
  }
}
