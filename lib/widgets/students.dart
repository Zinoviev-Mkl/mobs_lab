import 'package:flutter/material.dart';
import 'package:zinoviev_kiuki_21_8/models/student.dart';
import 'package:zinoviev_kiuki_21_8/widgets/student_item.dart';

class Students extends StatelessWidget {
  Students({super.key})
      : students = [
          Student(
              firstName: "John",
              lastName: "Carmack",
              department: Departments.it,
              grade: 9,
              gender: Genders.male),
          Student(
              firstName: "Judie",
              lastName: "Heal",
              department: Departments.medical,
              grade: 6,
              gender: Genders.female),
          Student(
              firstName: "Jordan",
              lastName: "Belfort",
              department: Departments.finance,
              grade: 8,
              gender: Genders.male),
          Student(
              firstName: "Jim",
              lastName: "Carrey",
              department: Departments.law,
              grade: 6,
              gender: Genders.male),
          Student(
              firstName: "Lana",
              lastName: "Stewart",
              department: Departments.it,
              grade: 7,
              gender: Genders.female),
        ];

  final List<Student> students;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students"),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) => StudentItem(student: students[index]),
      ),
    );
  }
}
