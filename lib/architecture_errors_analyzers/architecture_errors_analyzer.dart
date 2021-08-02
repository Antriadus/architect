import 'package:analyzer/dart/element/element.dart';
import 'package:architect/architecture_errors/architecture_error.dart';
import 'package:architect/configuration/layer.dart';
import 'package:architect/configuration/project_configuration.dart';

abstract class ArchitectureErrorsAnalyzer<Error extends ArchitectureError> {
  Set<Error> findErrors(
    ClassElement element,
    Layer? layer,
    ProjectConfiguration configuration,
  );
}
