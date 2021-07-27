import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:architect/arguments.dart';
import 'package:architect/models/configuration/project_configuration.dart';
import 'package:path/path.dart' as path;

import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart';

Future<List<ClassElement>> findClassElements(
  String inputPath,
  ProjectConfiguration configuration,
  Arguments args,
) async {
  print('Parsing start with path $inputPath');

  final dartFilesPaths = _getDartFilesPaths(inputPath, configuration);

  final contextCollection = getAnalysisContextCollection(inputPath, dartFilesPaths);

  final collector = ClassElementCollector();

  for (var i = 0; i < dartFilesPaths.length; i++) {
    final filePath = dartFilesPaths[i];
    AnalysisContext context;
    try {
      context = contextCollection.contextFor(filePath);
    } on StateError catch (_) {
      context = AnalysisContextCollectionImpl(includedPaths: [filePath]).contextFor(filePath);
    } catch (e) {
      //TODO logging files that throws exception and save to file
      continue;
    }

    final unitResult = await context.currentSession.getResolvedUnit(filePath);
    if (!unitResult.isPart) {
      unitResult.libraryElement.accept(collector);
    }
    if (args.printParsedFiles) {
      final short = filePath..replaceAll(inputPath, '');
      print('Parsing ${i + 1} of ${dartFilesPaths.length} files  - ${short}');
    }
  }
  final classes = collector.classElements;
  print('Parsing ${dartFilesPaths.length} files done - founded ${classes.length} class');

  return classes;
}

AnalysisContextCollectionImpl getAnalysisContextCollection(String pubspecPath, List<String> dartFilesPaths) {
  return AnalysisContextCollectionImpl(
    includedPaths: [
      path.absolute(pubspecPath),
      _makePackageSubPath(pubspecPath, 'lib'),
      _makePackageSubPath(pubspecPath, 'lib', 'src'),
      ...dartFilesPaths,
    ],
  );
}

List<String> _getDartFilesPaths(String inputPath, ProjectConfiguration configuration) {
  return Directory(inputPath)
      .listSync(recursive: true)
      .where((file) => path.extension(file.path) == '.dart')
      .where((element) => !configuration.excludePaths.any((exclude) => exclude.hasMatch(element.path)))
      .map((file) => normalizeAbsolutePath(file.path))
      .toList();
}

String _makePackageSubPath(String pubspecPath, String part0, [String? part1]) {
  return normalizeAbsolutePath(
    path.join(
      pubspecPath,
      part0,
      part1,
    ),
  );
}

String normalizeAbsolutePath(String filePath) {
  return path.normalize(path.absolute(filePath));
}

class ClassElementCollector extends RecursiveElementVisitor<void> {
  final List<ClassElement> _classElements = [];

  List<ClassElement> get classElements => _classElements;

  @override
  void visitClassElement(ClassElement element) {
    _classElements.add(element);
  }
}
