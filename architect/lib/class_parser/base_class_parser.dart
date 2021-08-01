import 'package:analyzer/dart/element/element.dart';
import 'package:architect/configuration/project_configuration.dart';

abstract class BaseClassParser {
  Future<List<ClassElement>> parseClasses(
      ProjectConfiguration configuration, String projectPath);
}
