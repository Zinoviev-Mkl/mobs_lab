import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinoviev_kiuki_21_8/providers/students_provider.dart';
import 'package:zinoviev_kiuki_21_8/widgets/students_list.dart';

class StudentsScreen extends ConsumerWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget mainContent = const Center(
      child: CircularProgressIndicator(),
    );

    var students = ref.watch(studentsProvider);
    if (students != null) {
      mainContent = StudentsList(students: students);
    }

    return mainContent;
  }
}
