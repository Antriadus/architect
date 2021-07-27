import 'package:architect/architecture_errors/class_name_error.dart';
import 'package:architect/configuration/project_configuration.dart';
import 'package:architect/configuration/layer.dart';
import 'package:analyzer/dart/element/element.dart';
import 'architecture_errors_analyzer.dart';

class ClassNameAnalyzer implements ArchitectureErrorsAnalyzer<ClassNameError> {
  @override
  Set<ClassNameError> findErrors(ClassElement element, Layer? layer, ProjectConfiguration configuration) {
    if (layer == null) {
      return {};
    }
    final result = <ClassNameError>{};
    final layerBannedClassNames = configuration.bannedClassNames[layer] ?? <RegExp>{};
    for (final bannedClassName in layerBannedClassNames) {
      if (bannedClassName.hasMatch(element.displayName)) {
        result.add(ClassNameError(
          element: element,
          layer: layer,
          regex: bannedClassName,
        ));
      }
    }
    return result;
  }
}
