import 'package:flutter/material.dart';
import 'package:zinoviev_kiuki_21_8/widgets/students.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Students(),
    );
  }
}
