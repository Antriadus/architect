import 'package:architect/configuration/layer.dart';
import 'package:architect/configuration/banned_class_name.dart';
import 'package:architect/configuration/banned_imports.dart';
import 'package:architect/configuration/regex.dart';

class ProjectConfiguration {
  final List<Layer> layers;
  final List<RegExp> excludePaths;
  final Map<Layer, Set<Layer>> bannedImports;
  final Map<Layer, Set<RegExp>> bannedClassNames;

  ProjectConfiguration(
    this.layers,
    this.excludePaths,
    this.bannedImports,
    this.bannedClassNames,
  );

  factory ProjectConfiguration.fromMap(Map<dynamic, dynamic> map) {
    final layers = List<Layer>.from(
      map['layers']?.map((x) => Layer.fromMap(x)),
    );
    final excludePaths = List<RegExp>.from(
      (map['excludePaths']?.map((x) => Regex.fromMap(x)) ?? []),
    );
    final bannedImportsList = List<BannedImports>.from(
      map['bannedImports']?.map((x) => BannedImports.fromMap(x)),
    );
    final bannedClassNamesList = List<BannedClassName>.from(
      map['bannedClassNames']?.map((x) => BannedClassName.fromMap(x)),
    );

    final bannedImportsMap = <Layer, Set<Layer>>{};
    for (final bannedConnection in bannedImportsList) {
      bannedImportsMap[bannedConnection.layer] = bannedConnection.cannotImportFrom.toSet();
    }

    final bannedClassNamesMap = <Layer, Set<RegExp>>{};
    for (final bannedClassName in bannedClassNamesList) {
      bannedClassNamesMap[bannedClassName.layer] = bannedClassName.bannedClassNames.toSet();
    }

    return ProjectConfiguration(
      layers,
      excludePaths,
      bannedImportsMap,
      bannedClassNamesMap,
    );
  }
}
