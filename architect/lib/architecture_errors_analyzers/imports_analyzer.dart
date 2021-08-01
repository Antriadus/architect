import 'package:architect/architecture_errors/import_error.dart';
import 'package:architect/configuration/project_configuration.dart';
import 'package:architect/configuration/layer.dart';
import 'package:analyzer/dart/element/element.dart';
import 'architecture_errors_analyzer.dart';

class ImportsAnalyzer implements ArchitectureErrorsAnalyzer<ImportError> {
  @override
  Set<ImportError> findErrors(
      ClassElement element, Layer? layer, ProjectConfiguration configuration) {
    if (layer == null) {
      return {};
    }
    final result = <ImportError>{};
    final imports = element.library.imports;
    for (final import in imports) {
      if (import.uri != null) {
        final importPath = (import.importedLibrary?.identifier ?? import.uri)!
            .split('/')
            .skip(1)
            .join('/');
        final importLayer = _findPathLayer(
          importPath,
          configuration.layers,
        );

        if (importLayer != null) {
          final bannedConnections =
              configuration.bannedImports[layer] ?? <Layer>{};
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

  Layer? _findPathLayer(String path, List<Layer> layers) {
    for (var layer in layers) {
      if (layer.pathRegex.hasMatch(path)) {
        return layer;
      }
    }
    return null;
  }
}
