import 'dart:convert';

import '../models/student.dart';
import 'package:http/http.dart' as http;

class StudentRepository {
  Future<List<Student>> findAll() async {
    final studentsResult =
        await http.get(Uri.parse('http://localhost:8080/students'));

    if (studentsResult.statusCode != 200) {
      throw Exception();
    }

    final studentsData = jsonDecode(studentsResult.body);

    return studentsData
        .map<Student>((student) => Student.fromMap(student))
        .toList();
  }

  Future<Student> findById(int id) async {
    final studentResult = await http.get(Uri.parse('http://localhost:8080/students/$id'));

    if (studentResult.statusCode != 200) {
      throw Exception();
    }

    if (studentResult.body == '{}') {
      throw Exception();
    }

    return Student.fromJson(studentResult.body);
  }

  Future<void> insert(Student student) async {
    final result = await http.get(Uri.parse('http://localhost:8080/students?'));
  }

  Future<void> update(Student student) async {
    final result = await http.get(Uri.parse('http://localhost:8080/students'));
  }

  Future<void> deleteById(int id) async {
    final result = await http.get(Uri.parse('http://localhost:8080/students'));
  }
}
