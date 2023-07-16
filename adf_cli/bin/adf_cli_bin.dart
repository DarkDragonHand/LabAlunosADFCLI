//*import 'package:args/args.dart';
//*import 'package:adf_cli/commands/example/exemplo_command.dart';
import 'package:adf_cli/commands/students/students_command.dart';
import 'package:args/command_runner.dart';

void main(List<String> arguments) {  
  CommandRunner('ADF Cli', 'CLI da Academia do Flutter')
    ..addCommand(StudentsCommand())
    ..run(arguments);
}