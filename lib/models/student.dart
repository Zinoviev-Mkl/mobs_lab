import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

const dbUrl = "nure-mobs-lab-default-rtdb.firebaseio.com";
const studentsPath = 'students';

enum Genders { male, female }

const genderIcons = {
  Genders.male: Icons.man,
  Genders.female: Icons.woman,
};

class Student {
  Student(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.departmentId,
      required this.grade,
      required this.gender});

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

  final String id;
  final String firstName;
  final String lastName;
  final String departmentId;
  final int grade;
  final Genders gender;

  static Future<List<Student>> remoteGetList() async {
    final url = Uri.https(dbUrl, "$studentsPath.json");

    final response = await http.get(
      url,
    );

    if (response.statusCode >= 400) {
      throw Exception("Failed to retrieve the data");
    }

    if (response.body == "null") {
      return [];
    }

    final Map<String, dynamic> data = json.decode(response.body);
    final List<Student> loadedItems = [];
    for (final item in data.entries) {
      loadedItems.add(
        Student(
          id: item.key,
          firstName: item.value['first_name']!,
          lastName: item.value['last_name']!,
          departmentId: item.value['department_id']!,
          gender: Genders.values
              .firstWhere((v) => v.toString() == item.value['gender']!),
          grade: item.value['grade']!,
        ),
      );
    }
    return loadedItems;
  }

  static Future<Student> remoteCreate(
    firstName,
    lastName,
    departmentId,
    gender,
    grade,
  ) async {
    final url = Uri.https(dbUrl, "$studentsPath.json");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'first_name': firstName!,
          'last_name': lastName,
          'department_id': departmentId,
          'gender': gender.toString(),
          'grade': grade,
        },
      ),
    );

    if (response.statusCode >= 400) {
      throw Exception("Couldn't create a student");
    }

    final Map<String, dynamic> responseData = json.decode(response.body);

    return Student(
        id: responseData['name'],
        firstName: firstName,
        lastName: lastName,
        departmentId: departmentId,
        gender: gender,
        grade: grade);
  }

  static Future remoteDelete(studentId) async {
    final url = Uri.https(dbUrl, "$studentsPath/$studentId.json");

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      throw Exception("Couldn't delete a student");
    }
  }

  static Future<Student> remoteUpdate(
    studentId,
    firstName,
    lastName,
    departmentId,
    gender,
    grade,
  ) async {
    final url = Uri.https(dbUrl, "$studentsPath/$studentId.json");

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'first_name': firstName!,
          'last_name': lastName,
          'department_id': departmentId,
          'gender': gender.toString(),
          'grade': grade,
        },
      ),
    );

    if (response.statusCode >= 400) {
      throw Exception("Couldn't update a student");
    }

    return Student(
        id: studentId,
        firstName: firstName,
        lastName: lastName,
        departmentId: departmentId,
        gender: gender,
        grade: grade);
  }
}
