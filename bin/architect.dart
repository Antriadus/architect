import 'package:architect/analyzer/base_analyzer.dart';
import 'package:architect/analyzer/simple_analyzer.dart';
import 'package:architect/class_parser/analyzer_class_parser.dart';
import 'package:architect/configuration_reader/configuration_reader.dart';
import 'package:architect/console_arguments.dart';
import 'package:architect/configuration/project_configuration.dart';
import 'package:architect/printers/base_printer.dart';
import 'package:architect/printers/console_printer.dart';
import 'dart:io';

Future<void> main(List<String> arguments) async {
  final BasePrinter printer = ConsolePrinter();
  final ConfigurationReader configurationReader = ConfigurationReader();

  final args = ConsoleArguments.fromConsole(arguments);

  if (args.showHelp) {
    printer.printInfo(argParser.usage);
    exit(0);
  }

  if (!await configurationReader.pubspecFileExist(args.inputPath)) {
    printer.printInfo('Pubspec file not found at $args.inputPath');
    exit(-1);
  }

  if (!await configurationReader.architectureFileExist(args.inputPath, args.architectureFileName)) {
    printer.printInfo('${args.architectureFileName} file not found at ${args.inputPath}');
    exit(-1);
  }

  final BaseAnalyzer analyzer = SimpleAnalyzer();
  final AnalyzerClassParser classParser = AnalyzerClassParser(printer, args.printProjectClasses);
  final ProjectConfiguration configuration = await configurationReader.readConfiguration(args.inputPath, args.architectureFileName);

  final classesElements = await classParser.parseClasses(configuration, args.inputPath);
  final projectClasses = await analyzer.analyze(classesElements, configuration);
  final classesWithErrors = projectClasses.where((c) => c.errors.isNotEmpty).toList();

  if (args.printProjectClasses) {
    if (args.printClassErrors) {
      printer.printClasses(projectClasses);
    } else {
      final classesWithoutClearedErrors = projectClasses.map((e) => e.copyWith(errors: {})).toList();
      printer.printClasses(classesWithoutClearedErrors);
    }
  } else if (args.printClassErrors) {
    printer.printClasses(classesWithErrors);
  }

  if (classesWithErrors.isNotEmpty) {
    exit(-1);
  }
  exit(0);
}
