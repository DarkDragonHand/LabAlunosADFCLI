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
    final result = await http.post(
      Uri.parse('http://localhost:8080/students'), 
      body: student.toJson(),
      headers: {
        'content-type': 'application/json',
      }
    );

    if (result.statusCode != 200) {
      throw Exception();
    }
  }

  Future<void> update(Student student) async {
    final result = await http.put(Uri.parse('http://localhost:8080/students/${student.id}'),
        body: student.toJson(),
        headers: {
          'content-type': 'application/json',
        });

    if (result.statusCode != 200) {
      throw Exception();
    }
  }

  Future<void> deleteById(int id) async {
    final result = await http.delete(Uri.parse('http://localhost:8080/students/$id'));
      
    if (result.statusCode != 200) {
      throw Exception();
    }
  }
}