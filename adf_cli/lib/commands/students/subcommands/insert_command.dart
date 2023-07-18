import 'dart:async';
import 'dart:io';
import 'package:args/command_runner.dart';
import '../../../models/address.dart';
import '../../../models/city.dart';
import '../../../models/phone.dart';
import '../../../models/student.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/student_repository.dart';

class InsertCommand extends Command {
  final StudentRepository studentRepository;
  final productRepository = ProductRepository();

  InsertCommand(this.studentRepository) {
    argParser.addOption(
      'file',
      help: 'Path of the file',
      abbr: 'f',
    );
  }

  @override
  String get description => 'Insert Student';

  @override
  String get name => 'insert';

  @override
  void run() async {
    print('Aguarde...');

    final filePath = argResults?['file'];
    final students = File(filePath).readAsLinesSync();
    print('=======================================');

    for (var student in students) {
      final studentData = student.split(';');
      final coursesCSV = studentData[2].split(',').map((course) => course.trim()).toList();
      final coursesFuture = coursesCSV.map((c) async {
        final course = await productRepository.findByName(c);
        course.isStudent = true;
        return course;
      }).toList();
      final courses = await Future.wait(coursesFuture);

      final studentModel = Student(
        name: studentData[0],
        age: int.tryParse(studentData[1]),
        nameCourses: coursesCSV,
        courses: courses,
        address: Address(
          street: studentData[3],
          number: int.parse(studentData[4]),
          zipCode: studentData[5],
          city: City(id: 1, name: studentData[6]),
          phone: Phone(ddd: int.parse(studentData[7]), phone: studentData[8]),
        ),
      );

      await studentRepository.insert(studentModel);
    }
    print('=======================================');
    print('Alunos adicionados com sucesso!');
  }
}
