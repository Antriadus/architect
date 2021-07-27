import 'package:architect/printers/base_printer.dart';
import 'package:architect/project_class.dart';

class ConsolePrinter implements BasePrinter {
  @override
  void printInfo(String message) => print(message);

  @override
  void printClasses(List<ProjectClass> classes) {
    classes.map(_stringifyProjectClass).join('\n');
  }

  String _stringifyProjectClass(ProjectClass projectClass) {
    return [
      '${projectClass.classElement.displayName}',
      '\n\tlayer: ${projectClass.layer?.displayName ?? "unknown"}',
      '\n\tpath: $projectClass.filePath\n',
      if (projectClass.errors.isNotEmpty) ...[
        '\terrors:',
        ...projectClass.errors.map(
          (error) => '\n\t${error.getErrorMessage()}',
        ),
        '\n'
      ],
    ].join();
  }
}
