import 'package:flutter/material.dart';
import 'package:zinoviev_kiuki_21_8/models/student.dart';
import 'package:zinoviev_kiuki_21_8/widgets/student_item.dart';

class StudentsList extends StatelessWidget {
  const StudentsList({
    super.key,
    required this.students,
    required this.onRemoveStudent,
    required this.onSelectStudent,
  });

  final List<Student> students;
  final void Function(Student student) onRemoveStudent;
  final void Function(Student student) onSelectStudent;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(students[index]),
        onDismissed: (direction) {
          onRemoveStudent(students[index]);
        },
        child: StudentItem(
          student: students[index],
          onSelectStudent: () {
            onSelectStudent(students[index]);
          },
        ),
      ),
    );
  }
}
