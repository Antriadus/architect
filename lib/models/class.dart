import 'package:analyzer/dart/element/element.dart';
import 'package:architect/models/architecture_errors/error.dart';
import 'package:architect/models/configuration/layer.dart';
import 'package:collection/collection.dart';

class Class {
  final ClassElement classElement;
  final String filePath;
  final Layer? layer;
  final Set<ArchitectureError> errors;

  Class({
    required this.classElement,
    required this.filePath,
    required this.layer,
    required this.errors,
  });

  String getDescriptionWithErrors() {
    return [
      getDescription(),
      '\terrors:',
      ...errors.map(
        (error) => '\n\t${error.getErrorMessage()}',
      ),
      '\n',
    ].join();
  }

  String getDescription() {
    return [
      '${classElement.displayName}',
      '\n\tlayer: ${layer?.displayName ?? "unknown"}',
      '\n\tpath: $filePath\n',
    ].join();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final setEquals = const DeepCollectionEquality().equals;

    return other is Class &&
        other.classElement == classElement &&
        other.filePath == filePath &&
        other.layer == layer &&
        setEquals(other.errors, errors);
  }

  @override
  int get hashCode {
    return classElement.hashCode ^ filePath.hashCode ^ layer.hashCode ^ errors.hashCode;
  }
}
