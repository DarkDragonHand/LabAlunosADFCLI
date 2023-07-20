import 'dart:io';
import 'package:args/command_runner.dart';
import '../../../repositoriesDio/student_dio_repository.dart';

class DeleteCommand extends Command {
  final StudentDioRepository studentRepository;

  DeleteCommand(this.studentRepository) {
    argParser.addOption('delete', help: 'Delete Student', abbr: 'd');
    argParser.addOption('id', help: 'Student Id', abbr: 'i');
  }

  @override
  String get description => 'Delete student';

  @override
  String get name => 'delete';

  @override
  Future<void> run() async {
    print('Aguarde...');
    print('Rodando o delete');
    final id = int.parse(argResults?['id']);
    if (argResults?['id'] == null) {
      print('Por favor, envie o id do aluno com o comando --id ou -i');
      return;
    }
    print('=======================================');
    print('Aguarde buscando aluno...');
    final student = await studentRepository.findById(id);

    print('Você confirma para deletar o aluno "${student.name}" do ID:${student.id}? (S) ou (N)');
    final confirmDelete = stdin.readLineSync();
    if (confirmDelete?.toLowerCase() == 's') {
      await studentRepository
          .deleteById(id)
          .then((value) => print('Aluno do ID:$id deletado com sucesso!'));
    } else if (confirmDelete?.toLowerCase() == 'n') {
      print('Operação cancelada');
      return;
    } else {
      print('Comando inválido.');
      return;
    }
    print('=======================================');
  }
}
