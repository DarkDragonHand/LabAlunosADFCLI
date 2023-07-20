import 'dart:async';
import 'package:args/command_runner.dart';
import '../../../repositoriesDio/student_dio_repository.dart';

class FindByIdCommand extends Command {
  final StudentDioRepository studentRepository;

  FindByIdCommand(this.studentRepository) {
    argParser.addOption('id', help: 'Student Id', abbr: 'i');
  }

  @override
  String get description => 'Find student by Id';

  @override
  String get name => 'findById';

  @override
  Future<void> run() async {
    if (argResults?['id'] == null) {
      print('Por favor, envie o id do aluno com o comando --id ou -i');
      return;
    }
    final id = int.parse(argResults?['id']);
    print('Rodando o findById');
    print('Aguarde buscando aluno...');
    final student = await studentRepository.findById(id);
    print('=======================================');
    print('Aluno: ${student.id}');
    print('Nome: ${student.name}');
    print('Idade: ${student.age == 0 ? 'Não informada' : student.age}');
    print('Cursos:');
    student.nameCourses.forEach(print);
    print('Cursos Adquiridos:');
    print(
        '${student.courses.where((course) => course.isStudent).map((nameCourse) => nameCourse.name)}');
    print('Endereço:');
    print('${student.address.street} - ${student.address.zipCode}');
    print('Cidade: ${student.address.city.name}');
    print('Telefone: ${student.address.phone.phone}');
    print('=======================================');
  }
}
