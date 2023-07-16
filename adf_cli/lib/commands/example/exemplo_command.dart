import 'package:args/command_runner.dart';

class ExemploCommand extends Command {
  @override
  String get description => 'Exemplo de comando';

  @override
  String get name => 'exemplo';

  ExemploCommand() {
    argParser.addOption('template', abbr: 't', help: 'Template de criação do projeto');
  }

  @override
  void run() {
    print(argResults?['template']);
    print('Executar qualquer coisa.');
  }
}