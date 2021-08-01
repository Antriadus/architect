import 'package:args/args.dart';

const _printParsedFilesLogsKey = 'print-filelogs';
const _printProjectClassesKey = 'print-founded-classes';
const _printClassErrorsKey = 'print-class-errors';
const _inputPathKey = 'input-path';
const _helpKey = 'help';
const _architectureFileNameKey = 'architecture-file-name';

class ConsoleArguments {
  final bool printParsedFiles;
  final bool printProjectClasses;
  final bool printClassErrors;
  final bool showHelp;
  final String inputPath;
  final String architectureFileName;

  ConsoleArguments({
    required this.printParsedFiles,
    required this.showHelp,
    required this.printProjectClasses,
    required this.printClassErrors,
    required this.architectureFileName,
    required this.inputPath,
  });

  factory ConsoleArguments.fromConsole(List<String> arguments) {
    final results = argParser.parse(arguments);
    final printParsedFilesLogs = results[_printParsedFilesLogsKey];
    final printProjectClasses = results[_printProjectClassesKey];
    final printClassErrors = results[_printClassErrorsKey];

    final inputPath = results[_inputPathKey];
    final showHelp = results[_helpKey];
    final architectureFileNameKey = results[_architectureFileNameKey];
    return ConsoleArguments(
      showHelp: showHelp,
      printProjectClasses: printProjectClasses,
      printClassErrors: printClassErrors,
      printParsedFiles: printParsedFilesLogs,
      inputPath: inputPath,
      architectureFileName: architectureFileNameKey,
    );
  }
}

final argParser = ArgParser()
  ..addFlag(
    _helpKey,
    abbr: 'h',
    help: 'Show help message.',
    defaultsTo: false,
  )
  ..addFlag(
    _printParsedFilesLogsKey,
    abbr: 'f',
    help: 'Print after every parsed file',
    defaultsTo: false,
  )
  ..addFlag(
    _printProjectClassesKey,
    abbr: 'c',
    help: 'Print all project classes',
    defaultsTo: false,
  )
  ..addFlag(
    _printClassErrorsKey,
    abbr: 'e',
    help: 'Print all architecture errors from project classes',
    defaultsTo: true,
  )
  ..addOption(
    _inputPathKey,
    help: 'Path to directory with pubspec.yaml and lib directory',
    valueHelp: 'DIRECTORY',
    defaultsTo: '/Users/kamilmrowiec/Documents/Repos/architect/example',
  )
  ..addOption(
    _architectureFileNameKey,
    help: "Architecure configuration yaml file's name",
    valueHelp: 'FILE',
    defaultsTo: 'architecture_no_errors.yaml',
  );
