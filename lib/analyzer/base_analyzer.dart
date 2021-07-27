import 'package:analyzer/dart/element/element.dart';
import 'package:architect/configuration/project_configuration.dart';
import 'package:architect/project_class.dart';

abstract class BaseAnalyzer {
  Future<List<ProjectClass>> analyze(List<ClassElement> classElements, ProjectConfiguration configuration);
}
