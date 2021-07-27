import 'package:architect/analyzer.dart';
import 'package:architect/configuration_printer.dart';
import 'package:architect/configuration_reader.dart';
import 'package:architect/file_writer.dart';
import 'package:architect/find_class_elements.dart';
import 'package:architect/arguments.dart';
import 'package:architect/stringifier.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

Future<void> main(List<String> arguments) async {
  final args = Arguments.fromConsole(arguments);
  final inputPath = args.inputPath;
  if (inputPath == null) {
    print("Must provide input path!");
    exit(0);
  }
  final pubspecPath = path.join(args.inputPath!, 'pubspec.yaml');

  if (args.inputPath == null) {
    print('Pubspec file not found at $pubspecPath');
    exit(1);
  }
  await _checkIfPubspecExist(pubspecPath);

  final configuration = await readConfiguration(inputPath);
  if (args.printArchitecture) {
    print(printConfiguration(configuration));
  }

  final classesElements = await findClassElements(inputPath, configuration, args);

  final classes = await analyzeArchitecure(classesElements.toList(), inputPath, configuration);

  if (args.printFoundedClasses) {
    print(stringifyFoundClasses(classes).result);
  }
  if (args.foundedClassesOutput.isNotEmpty) {
    final stringified = stringifyFoundClasses(classes);
    await writeStringToFile(stringified.result, args.foundedClassesOutput);
    print('Saved ${stringified.count} classes to ${args.classesErrorsOutput}');
  }

  if (args.printClassErrors) {
    print(stringifyClassErrors(classes).result);
  }
  if (args.classesErrorsOutput.isNotEmpty) {
    final stringified = stringifyClassErrors(classes);
    await writeStringToFile(stringified.result, args.classesErrorsOutput);
    print('Saved ${stringified.count} classes errors to ${args.classesErrorsOutput}');
  }
}

Future<void> _checkIfPubspecExist(String pubspecPath) async {
  final pubspec = File(pubspecPath);
  if (!(await pubspec.exists())) {
    print('Pubspec file not found at $pubspecPath');
    exit(1);
  }
}
