import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const RepresApp());
}

class RepresApp extends StatelessWidget {
  const RepresApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Conteo de Estudiantes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 21, 121, 192)),
        scaffoldBackgroundColor: Colors.blue[800],
      ),
      home: const HomeScreen(),
    );
  }
}
