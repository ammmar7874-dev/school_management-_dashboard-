import 'package:adicto_school/src/pages/main/presentation/main_desktop.dart'
    as desktop_main;
import 'add_subscription_plan_mobile.dart' as mobile;
import 'package:adicto_school/src/shared/data/data_manager.dart';
import 'package:flutter/material.dart';

class AddSubscriptionPlanScreen extends StatelessWidget {
  final SubscriptionPlan? planToEdit;
  final int? planIndex;

  const AddSubscriptionPlanScreen({super.key, this.planToEdit, this.planIndex});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobile.AddSubscriptionPlanScreen(
            planToEdit: planToEdit,
            planIndex: planIndex,
          );
        } else {
          return desktop_main.MainScreen(
            selectedIndex: 2, // My Plan tab
            initialLocalRoute: 'AddPlan',
            onIndexChanged: (index) {
              Navigator.pop(context);
            },
          );
        }
      },
    );
  }
}
