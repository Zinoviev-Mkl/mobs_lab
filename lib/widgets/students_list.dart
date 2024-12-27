import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinoviev_kiuki_21_8/models/student.dart';
import 'package:zinoviev_kiuki_21_8/providers/students_provider.dart';
import 'package:zinoviev_kiuki_21_8/widgets/new_student.dart';
import 'package:zinoviev_kiuki_21_8/widgets/student_item.dart';

class StudentsList extends ConsumerWidget {
  const StudentsList({
    super.key,
    required this.students,
  });

  final List<Student> students;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(students[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withValues(alpha: .75),
          margin: const EdgeInsets.symmetric(horizontal: 16),
        ),
        onDismissed: (direction) {
          final studentToDelete = students[index];
          final notifier = ref.read(studentsProvider.notifier);
          notifier.removeStudentLocal(studentToDelete);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 3),
                  content: const Text('Student deleted'),
                  action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        notifier.insertStudentLocal(studentToDelete, index);
                      }),
                ),
              )
              .closed
              .then(
            (value) {
              if (value != SnackBarClosedReason.action) {
                notifier.removeStudent(studentToDelete);
              }
            },
          );
        },
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
                useSafeArea: true,
                isScrollControlled: true,
                context: context,
                builder: (ctx) => NewStudent(
                      studentIndex: index,
                    ));
          },
          child: StudentItem(student: students[index]),
        ),
      ),
    );
  }
}
