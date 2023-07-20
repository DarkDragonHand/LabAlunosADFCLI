import 'dart:io';
import 'package:args/command_runner.dart';
import '../../../models/address.dart';
import '../../../models/city.dart';
import '../../../models/phone.dart';
import '../../../models/student.dart';
import '../../../repositoriesDio/product_dio_repository.dart';
import '../../../repositoriesDio/student_dio_repository.dart';

class UpdateCommand extends Command {
  final StudentDioRepository studentRepository;
  final productRepository = ProductDioRepository();

  UpdateCommand(this.studentRepository) {
    argParser.addOption('file', help: 'Path of the file', abbr: 'f');
    argParser.addOption('id', help: 'Student id', abbr: 'i');
  }

  @override
  String get description => 'Update student';

  @override
  String get name => 'update';

  @override
  Future<void> run() async {
    print('Aguarde...');
    print('Rodando o update');
    final filePath = argResults?['file'];
    final id = argResults?['id'];
    if (id == null) {
      print('Por favor, envie o id do aluno com o comando --id ou -i');
      return;
    }

    print('Aguarde, atualizando dados do aluno...');
    final students = File(filePath).readAsLinesSync();
    print('=======================================');

    if (students.length > 1) {
      print('Por favor, informe somente um aluno no arquivo $filePath');
    } else if (students.isEmpty) {
      print('Não há alunos no arquivo $filePath');
    }

    final student = students.first;
    final studentData = student.split(';');
    final coursesCSV =
        studentData[2].split(',').map((course) => course.trim()).toList();

    final coursesFuture = coursesCSV.map((c) async {
      final course = await productRepository.findByName(c);
      course.isStudent = true;
      return course;
    }).toList();
    final courses = await Future.wait(coursesFuture);

    final studentModel = Student(
      id: int.parse(id),
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

    await studentRepository.update(studentModel);
    print('=======================================');
    print('Aluno atualizado com sucesso!');
  }
}
