import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinoviev_kiuki_21_8/models/department.dart';
import 'package:zinoviev_kiuki_21_8/models/student.dart';
import 'package:zinoviev_kiuki_21_8/providers/departments_provider.dart';
import 'package:zinoviev_kiuki_21_8/providers/students_provider.dart';

class NewStudent extends ConsumerStatefulWidget {
  const NewStudent({super.key, this.studentIndex});

  final int? studentIndex;

  @override
  ConsumerState<NewStudent> createState() {
    return _NewStudentState();
  }
}

class _NewStudentState extends ConsumerState<NewStudent> {
  late Department _selectedDepartment;
  Genders _selectedGender = Genders.male;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _gradeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _selectedDepartment = ref.read(departmentsProvider).first;

    if (widget.studentIndex != null) {
      final student = ref.read(studentsProvider)[widget.studentIndex!];

      _firstNameController.text = student.firstName;
      _lastNameController.text = student.lastName;
      _gradeController.text = student.grade.toString();
      _selectedGender = student.gender;
      _selectedDepartment = ref
          .read(departmentsProvider)
          .firstWhere((department) => department.id == student.departmentId);
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _gradeController.dispose();

    super.dispose();
  }

  void _submitStudent() {
    final inputGrade = int.tryParse(_gradeController.text);
    final gradeIsInvalid = inputGrade == null || inputGrade <= 0;
    final firstNameIsInvalid = _firstNameController.text.trim().isEmpty;
    final lastNameIsInvalid = _lastNameController.text.trim().isEmpty;

    if (firstNameIsInvalid || lastNameIsInvalid || gradeIsInvalid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid student data'),
          content: const Text(
              'Please enter a valid first name, last name and grade.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('OK'))
          ],
        ),
      );

      return;
    }

    if (widget.studentIndex != null) {
      ref.read(studentsProvider.notifier).editStudent(
          Student(
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            departmentId: _selectedDepartment.id,
            gender: _selectedGender,
            grade: inputGrade,
          ),
          widget.studentIndex!);
    } else {
      ref.read(studentsProvider.notifier).addStudent(
            Student(
                firstName: _firstNameController.text.trim(),
                lastName: _lastNameController.text.trim(),
                departmentId: _selectedDepartment.id,
                gender: _selectedGender,
                grade: inputGrade),
          );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _firstNameController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("First name")),
            style: textTheme.titleMedium!
                .copyWith(color: theme.colorScheme.tertiary),
          ),
          TextField(
            controller: _lastNameController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Last name")),
            style: textTheme.titleMedium!
                .copyWith(color: theme.colorScheme.tertiary),
          ),
          TextField(
            controller: _gradeController,
            decoration: const InputDecoration(label: Text("Grade")),
            style: textTheme.titleMedium!
                .copyWith(color: theme.colorScheme.tertiary),
          ),
          DropdownButton(
            value: _selectedGender,
            items: Genders.values
                .map(
                  (gender) => DropdownMenuItem(
                    value: gender,
                    child: Row(
                      children: [
                        Icon(
                          genderIcons[gender],
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          gender.name.toUpperCase(),
                          style: textTheme.titleSmall!
                              .copyWith(color: theme.colorScheme.tertiary),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value == null) {
                return;
              }
              setState(() {
                _selectedGender = value;
              });
            },
          ),
          DropdownButton(
            value: _selectedDepartment,
            items: ref
                .read(departmentsProvider)
                .map(
                  (department) => DropdownMenuItem(
                    value: department,
                    child: Row(
                      children: [
                        Icon(
                          department.icon,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          department.name.toUpperCase(),
                          style: textTheme.titleSmall!
                              .copyWith(color: theme.colorScheme.tertiary),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value == null) {
                return;
              }
              setState(() {
                _selectedDepartment = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  _submitStudent();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.inversePrimary),
                child: const Text("Save"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
