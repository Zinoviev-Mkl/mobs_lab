import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinoviev_kiuki_21_8/models/student.dart';
import 'package:zinoviev_kiuki_21_8/providers/departments_provider.dart';

class StudentItem extends ConsumerWidget {
  const StudentItem({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final department = ref
        .watch(departmentsProvider)
        .firstWhere((d) => d.id == student.departmentId);

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    var itemColor = student.gender == Genders.male ? Colors.blue : Colors.pink;
    return Card(
      color: itemColor.withValues(alpha: 0.65),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        child: Row(
          children: [
            Text(
              '${student.firstName} ${student.lastName}',
              style: textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Icon(
                  department.icon,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  student.grade.toString(),
                  style: textTheme.titleSmall!
                      .copyWith(color: theme.colorScheme.primary),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
