import 'package:adicto_school/src/pages/main/presentation/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:adicto_school/Mobile/screens/dashboard_screen.dart'; // No longer direct import probably
import 'package:adicto_school/src/pages/home/presentation/home_screen.dart'; // Maybe needed? Usually main imports MainScreen wrapper.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adicto School',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        textTheme: GoogleFonts.outfitTextTheme(),
      ),
      home: const MainScreen(),
    );
  }
}
