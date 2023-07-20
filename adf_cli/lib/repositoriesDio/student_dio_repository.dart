import 'package:dio/dio.dart';
import '../models/student.dart';

class StudentDioRepository {
  Future<List<Student>> findAll() async {
    try {
      final studentsResult = await Dio().get('http://localhost:8080/students');
      return studentsResult.data
          .map<Student>((student) => Student.fromMap(student))
          .toList();
    } on DioException catch (de) {
      print(de);
      throw Exception();
    }
  }

  Future<Student> findById(int id) async {
    try {
      final studentResult = await Dio()
          .get('http://localhost:8080/students', queryParameters: {
            'id': id
          });
      if (studentResult.data == null) {
        throw Exception();
      }
      return Student.fromMap(studentResult.data);
    } on DioException catch (de) {
      print(de);
      throw Exception();
    }
  }

  Future<void> insert(Student student) async {
    try {
      await Dio().post('http://localhost:8080/students', data: student.toMap());
    } on DioException catch (de) {
      print(de);
      throw Exception();
    }
  }

  Future<void> update(Student student) async {
    try {
      await Dio().put('http://localhost:8080/students/${student.id}',
          data: student.toMap());
    } on DioException catch (de) {
      print(de);
      throw Exception();
    }
  }

  Future<void> deleteById(int id) async {
    try {
      await Dio().delete('http://localhost:8080/students/$id');
    } on DioException catch (de) {
      print(de);
      throw Exception();
    }
  }
}
