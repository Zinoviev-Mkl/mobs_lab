import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinoviev_kiuki_21_8/models/department.dart';

final Provider<List<Department>> departmentsProvider = Provider((ref) {

  return [
    Department(
        name: 'Computer Engineering',
        color: Colors.blue,
        icon: Icons.laptop,
        ),
    Department(
        name: 'Computer Science',
        color: Colors.cyan,
        icon: Icons.science,
        ),
    Department(
        name: 'Cybersecurity',
        color: Colors.purple,
        icon: Icons.security,
        ),
    Department(
        name: 'Artificial Intelligence',
        color: Colors.pink,
        icon: Icons.smart_toy,
        ),
  ];
});
