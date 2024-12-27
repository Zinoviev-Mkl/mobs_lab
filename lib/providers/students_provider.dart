import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinoviev_kiuki_21_8/models/student.dart';

class StudentsNotifier extends StateNotifier<List<Student>?> {
  StudentsNotifier(super.state);

  void getStudentsList() async {
    state = await Student.remoteGetList();
  }

  Future addStudent(
    firstName,
    lastName,
    departmentId,
    gender,
    grade,
  ) async {
    final student = await Student.remoteCreate(
        firstName, lastName, departmentId, gender, grade);
    state = [...state!, student];
  }

  Future editStudent(
    index,
    firstName,
    lastName,
    departmentId,
    gender,
    grade,
  ) async {
    final student = await Student.remoteUpdate(
      state![index].id,
      firstName,
      lastName,
      departmentId,
      gender,
      grade,
    );

    final newState = [...state!];
    newState[index] = student;
    state = newState;
  }

  Future insertStudentLocal(Student student, int index) async {
    final newState = [...state!];
    newState.insert(index, student);
    state = newState;
  }

  void removeStudentLocal(Student student) async {
    state = state!.where((m) => m.id != student.id).toList();
  }

  Future removeStudent(Student student) async {
    await Student.remoteDelete(student.id);
    state = state!.where((m) => m.id != student.id).toList();
  }
}

final studentsProvider =
    StateNotifierProvider<StudentsNotifier, List<Student>?>((ref) {
  final notifier = StudentsNotifier(null);
  notifier.getStudentsList();
  return notifier;
});