import 'package:architect/models/architecture_errors/error.dart';
import 'package:architect/models/configuration/layer.dart';

class ImportError extends ArchitectureError {
  final Layer importedLayer;
  final String importedClassPath;

  ImportError({
    required this.importedLayer,
    required this.importedClassPath,
  });

  @override
  String getErrorMessage() {
    //TODO add more info
    return '- import from ${importedLayer.displayName}  $importedClassPath';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImportError && other.importedLayer == importedLayer && other.importedClassPath == importedClassPath;
  }

  @override
  int get hashCode => importedLayer.hashCode ^ importedClassPath.hashCode;
}
