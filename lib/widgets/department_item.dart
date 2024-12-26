import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinoviev_kiuki_21_8/models/department.dart';
import 'package:zinoviev_kiuki_21_8/providers/students_provider.dart';

class DepartmentItem extends ConsumerWidget {
  const DepartmentItem({super.key, required this.department});

  final Department department;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enrolledStudents = ref
        .watch(studentsProvider)
        .where((s) => s.departmentId == department.id)
        .length;

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            department.color.withValues(alpha: .55),
            department.color.withValues(alpha: .95),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            department.name,
            style: textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          Row(
            children: [
              Text(
                'Students enrolled:',
                style: textTheme.titleSmall!.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),
              SizedBox(width: 8),
              Text(
                enrolledStudents.toString(),
                style: textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.secondary),
              )
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                department.icon,
                color: theme.colorScheme.primary,
              )
            ],
          )
        ],
      ),
    );
  }
}
