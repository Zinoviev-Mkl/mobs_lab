import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinoviev_kiuki_21_8/models/student.dart';
import 'package:zinoviev_kiuki_21_8/providers/departments_provider.dart';

class StudentsNotifier extends StateNotifier<List<Student>> {
  StudentsNotifier(super.state);

  void addStudent(Student student) {
    state = [...state, student];
  }

  void editStudent(Student student, int index) {
    final newState = [...state];
    newState[index] = newState[index].copyWith(
      student.firstName,
      student.lastName,
      student.departmentId,
      student.gender,
      student.grade,
    );
    state = newState;
  }

  void insertStudent(Student student, int index) {
    final newState = [...state];
    newState.insert(index, student);
    state = newState;
  }

  void removeStudent(Student student) {
    state = state.where((m) => m.id != student.id).toList();
  }
}

final studentsProvider =
    StateNotifierProvider<StudentsNotifier, List<Student>>((ref) {
  final departments = ref.read(departmentsProvider);

  return StudentsNotifier([
    Student(
        firstName: "John",
        lastName: "Carmack",
        departmentId: departments[0].id,
        grade: 9,
        gender: Genders.male),
    Student(
        firstName: "Judie",
        lastName: "Heal",
        departmentId: departments[3].id,
        grade: 6,
        gender: Genders.female),
    Student(
        firstName: "Jordan",
        lastName: "Belfort",
        departmentId: departments[1].id,
        grade: 8,
        gender: Genders.male),
    Student(
        firstName: "Jim",
        lastName: "Carrey",
        departmentId: departments[2].id,
        grade: 6,
        gender: Genders.male),
    Student(
        firstName: "Lana",
        lastName: "Stewart",
        departmentId: departments[0].id,
        grade: 7,
        gender: Genders.female),
  ]);
});
