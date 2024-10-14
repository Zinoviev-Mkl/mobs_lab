import 'package:flutter/material.dart';
import 'package:zinoviev_kiuki_21_8/models/student.dart';

class StudentItem extends StatelessWidget {
  const StudentItem({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: student.gender == Genders.male ? Colors.blue : Colors.pink,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        child: Row(
          children: [
            Text(
              '${student.firstName} ${student.lastName}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Row(
              children: [
                Icon(departmentIcons[student.department]),
                const SizedBox(width: 8),
                Text(student.grade.toString()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
