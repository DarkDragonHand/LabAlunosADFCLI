import 'dart:io';
import 'package:args/command_runner.dart';
import '../../../repositories/student_repository.dart';

class FindAllCommand extends Command {
  final StudentRepository studentRepository;

  FindAllCommand(this.studentRepository);

  @override
  String get description => 'Find all students';

  @override
  String get name => 'findAll';

  @override
  Future<void> run() async {
    print('Rodando o findAll');
    print('Aguarde buscando alunos...');
    final students = await studentRepository.findAll();

    print('Apresentar também os cursos? (S) ou (N)');
    final showCourses = stdin.readLineSync();
    print('=======================================');
    print('Alunos:');
    print('=======================================');
    for (var student in students) {
      if (showCourses?.toLowerCase() == 's') {
        print('${student.id} - ${student.name} - ${student.courses.where((course) => course.isStudent)
        .map((nameCourse) => nameCourse.name).toList()}');
      } else {
        print('${student.id} - ${student.name}');
      }
    }
  }
}
