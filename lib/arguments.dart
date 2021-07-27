import 'package:args/args.dart';

const _printArchitectureKey = 'print-architecture';
const _printParsedFilesLogsKey = 'print-filelogs';
const _printFoundedClassesKey = 'print-founded-classes';
const _printClassErrorsKey = 'print-class-errors';
const _classesErrorsOutputKey = 'classes-errors-output';
const _foundedClassesOutputKey = 'founded-classes-output';
const _inputPathKey = 'input-path';

class Arguments {
  final bool printArchitecture;
  final bool printParsedFiles;
  final bool printFoundedClasses;
  final bool printClassErrors;
  final String classesErrorsOutput;
  final String foundedClassesOutput;
  final String? inputPath;

  Arguments({
    required this.printArchitecture,
    required this.printParsedFiles,
    required this.printFoundedClasses,
    required this.printClassErrors,
    required this.classesErrorsOutput,
    required this.foundedClassesOutput,
    required this.inputPath,
  });

  factory Arguments.fromConsole(List<String> arguments) {
    final results = argParser.parse(arguments);
    final printArchitecture = results[_printArchitectureKey];
    final printParsedFilesLogs = results[_printParsedFilesLogsKey];
    final printFoundedClasses = results[_printFoundedClassesKey];
    final printClassErrors = results[_printClassErrorsKey];
    final classesErrorsOutput = results[_classesErrorsOutputKey];
    final foundedClassesOutput = results[_foundedClassesOutputKey];
    final inputPath = results[_inputPathKey];
    return Arguments(
      printArchitecture: printArchitecture,
      printFoundedClasses: printFoundedClasses,
      printClassErrors: printClassErrors,
      printParsedFiles: printParsedFilesLogs,
      classesErrorsOutput: classesErrorsOutput,
      foundedClassesOutput: foundedClassesOutput,
      inputPath: inputPath,
    );
  }
}

final argParser = ArgParser(usageLineLength: 80)
  ..addFlag(
    _printArchitectureKey,
    abbr: 'a',
    help: 'Console print architecture from architecture.yaml file.',
    defaultsTo: false,
  )
  ..addFlag(
    _printParsedFilesLogsKey,
    abbr: 'f',
    help: 'Console print after every parsed file',
    defaultsTo: false,
  )
  ..addFlag(
    _printFoundedClassesKey,
    abbr: 'c',
    help: 'Console print all founded classes',
    defaultsTo: false,
  )
  ..addFlag(
    _printClassErrorsKey,
    abbr: 'e',
    help: 'Console print all architecture errors from founded classes',
    defaultsTo: false,
  )
  ..addOption(
    _classesErrorsOutputKey,
    abbr: 'o',
    help: 'File to which classes errors should be written',
    valueHelp: 'FILE',
    defaultsTo: '',
  )
  ..addOption(
    _foundedClassesOutputKey,
    help: 'File to which founded classes should be written',
    valueHelp: 'FILE',
    defaultsTo: '',
  )
  ..addOption(
    _inputPathKey,
    help: 'Path to directory with pubspec.yaml and lib directory',
    valueHelp: 'DIRECTORY',
  );
// '/Users/kamilmrowiec/Documents/Repos/skeo-flutter-new';
// "/Users/kamilmrowiec/Documents/Repos/Magisterka/input";
