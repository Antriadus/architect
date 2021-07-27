import 'package:analyzer/dart/element/element.dart';
import 'package:architect/analyzer/base_analyzer.dart';
import 'package:architect/architecture_errors/class_name_error.dart';
import 'package:architect/architecture_errors/import_error.dart';
import 'package:architect/project_class.dart';
import 'package:architect/configuration/project_configuration.dart';
import 'package:architect/configuration/layer.dart';

class SimpleAnalyzer implements BaseAnalyzer {
  int _compareClasses(ProjectClass a, ProjectClass b) => a.classElement.displayName.compareTo(b.classElement.displayName);

  @override
  Future<List<ProjectClass>> analyze(List<ClassElement> classElements, ProjectConfiguration configuration) async {
    final projectClasses = <ProjectClass>[];
    var errorsCount = 0;
    for (var i = 0; i < classElements.length; i++) {
      final element = classElements[i];
      final elementPath = _getElementPath(element);
      final elementLayer = _findPathLayer(elementPath, configuration.layers);
      final classNameErrors = _getClassNameErrors(element, elementLayer, configuration);
      final importErrors = _getImportErrors(configuration, element, elementLayer);
      final currentClass = ProjectClass(
        classElement: element,
        filePath: elementPath,
        layer: elementLayer,
        errors: {
          ...classNameErrors,
          ...importErrors,
        },
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

  Set<ClassNameError> _getClassNameErrors(
    ClassElement element,
    Layer? layer,
    ProjectConfiguration configuration,
  ) {
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

  Set<ImportError> _getImportErrors(ProjectConfiguration configuration, ClassElement element, Layer? layer) {
    if (layer == null) {
      return {};
    }
    final result = <ImportError>{};
    final imports = element.library.imports;
    for (final import in imports) {
      if (import.uri != null) {
        final importPath = (import.importedLibrary?.identifier ?? import.uri)!.split('/').skip(1).join('/');
        final importLayer = _findPathLayer(
          importPath,
          configuration.layers,
        );

        if (importLayer != null) {
          final bannedConnections = configuration.bannedImports[layer] ?? <Layer>{};
          if (bannedConnections.contains(importLayer)) {
            result.add(
              ImportError(
                importedClassPath: importPath,
                importedLayer: importLayer,
              ),
            );
          }
        }
      }
    }

    return result;
  }
}
