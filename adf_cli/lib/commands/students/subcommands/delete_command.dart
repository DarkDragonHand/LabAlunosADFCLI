import 'package:args/command_runner.dart';
import '../../../repositories/student_repository.dart';

class DeleteCommand extends Command {
  final StudentRepository studentRepository;

  DeleteCommand(this.studentRepository);

  @override
  String get description => 'Delete student';

  @override
  String get name => 'delete';

  @override
  void run() {}
}