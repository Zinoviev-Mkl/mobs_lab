import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum Genders { male, female }

const genderIcons = {
  Genders.male: Icons.man,
  Genders.female: Icons.woman,
};

const uuid = Uuid();

class Student {
  Student(
      {required this.firstName,
      required this.lastName,
      required this.departmentId,
      required this.grade,
      required this.gender})
      : id = uuid.v4();

  Student.withId(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.departmentId,
      required this.gender,
      required this.grade});
  
   Student copyWith(firstName, lastName, departmentId, gender, grader) {
    return Student.withId(
        id: id,
        firstName: firstName,
        lastName: lastName,
        departmentId: departmentId,
        gender: gender,
        grade: grade);
  }

  String id;
  final String firstName;
  final String lastName;
  final String departmentId;
  final int grade;
  final Genders gender;
}
