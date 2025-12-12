import 'package:adicto_school/src/pages/main/presentation/main_desktop.dart'
    as desktop_main;
import 'payment_methods_mobile.dart' as mobile;
import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const mobile.PaymentMethodsScreen();
        } else {
          return desktop_main.MainScreen(
            initialLocalRoute: 'Payment Method',
            onIndexChanged: (index) {
              // Handle navigation change
              Navigator.pop(context);
            },
          );
        }
      },
    );
  }
}
