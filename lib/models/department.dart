import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Department {
  Department({
    required this.name,
    required this.color,
    required this.icon,
  }) : id = uuid.v4();

  final String id;
  final String name;
  final Color color;
  final IconData icon;
}
