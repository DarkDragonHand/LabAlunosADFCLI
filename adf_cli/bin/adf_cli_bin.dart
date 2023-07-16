//import 'package:args/args.dart';
import 'package:args/command_runner.dart';

void main(List<String> arguments) {
  print(arguments);

  /*final argParser = ArgParser();

  argParser.addFlag('data', abbr: 'd');
  argParser.addOption('name', abbr: 'n');
  argParser.addOption('template', abbr: 't');
  final argResult = argParser.parse(arguments);

  print(argResult['data']);
  print(argResult['name']);
  print(argResult['template']);
  */

  CommandRunner('ADF Cli', 'CLI da Academia do Flutter')
    ..addCommand(ExemploCommand())
    ..run(arguments);
}

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
