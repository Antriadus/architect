import 'package:analyzer/dart/element/element.dart';
import 'package:architect/architecture_errors/architecture_error.dart';
import 'package:architect/configuration/layer.dart';
import 'package:collection/collection.dart';

class ProjectClass {
  final ClassElement classElement;
  final String filePath;
  final Layer? layer;
  final Set<ArchitectureError> errors;

  ProjectClass({
    required this.classElement,
    required this.filePath,
    required this.layer,
    required this.errors,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final setEquals = const DeepCollectionEquality().equals;

    return other is ProjectClass &&
        other.classElement == classElement &&
        other.filePath == filePath &&
        other.layer == layer &&
        setEquals(other.errors, errors);
  }

  @override
  int get hashCode {
    return classElement.hashCode ^
        filePath.hashCode ^
        layer.hashCode ^
        errors.hashCode;
  }

  ProjectClass copyWith({
    ClassElement? classElement,
    String? filePath,
    Layer? layer,
    Set<ArchitectureError>? errors,
  }) {
    return ProjectClass(
      classElement: classElement ?? this.classElement,
      filePath: filePath ?? this.filePath,
      layer: layer ?? this.layer,
      errors: errors ?? this.errors,
    );
  }
}
