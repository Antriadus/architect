import 'package:analyzer/dart/element/element.dart';
import 'package:architect/analyzer/base_analyzer.dart';
import 'package:architect/architecture_errors/architecture_error.dart';
import 'package:architect/architecture_errors_analyzers/architecture_errors_analyzer.dart';
import 'package:architect/project_class.dart';
import 'package:architect/configuration/project_configuration.dart';
import 'package:architect/configuration/layer.dart';

class SimpleAnalyzer implements BaseAnalyzer {
  final List<ArchitectureErrorsAnalyzer> analyzers;

  SimpleAnalyzer(this.analyzers);

  int _compareClasses(ProjectClass a, ProjectClass b) => a.classElement.displayName.compareTo(b.classElement.displayName);

  @override
  Future<List<ProjectClass>> analyze(List<ClassElement> classElements, ProjectConfiguration configuration) async {
    final projectClasses = <ProjectClass>[];
    var errorsCount = 0;
    for (var i = 0; i < classElements.length; i++) {
      final element = classElements[i];
      final elementPath = _getElementPath(element);
      final elementLayer = _findPathLayer(elementPath, configuration.layers);
      final errors = <ArchitectureError>{};
      for (var analyzer in analyzers) {
        errors.addAll(analyzer.findErrors(element, elementLayer, configuration));
      }
      final currentClass = ProjectClass(
        classElement: element,
        filePath: elementPath,
        layer: elementLayer,
        errors: errors,
      );
      errorsCount += currentClass.errors.length;

      projectClasses.add(currentClass);
    }
    projectClasses.sort(_compareClasses);
    print('Analyze completed. $errorsCount errors found');
    return projectClasses;
  }

  String _getElementPath(ClassElement element) {
    return element.source.uri.pathSegments.skip(1).join('/');
  }

  Layer? _findPathLayer(String path, List<Layer> layers) {
    for (var layer in layers) {
      if (layer.pathRegex.hasMatch(path)) {
        return layer;
      }
    }
    return null;
  }
}
