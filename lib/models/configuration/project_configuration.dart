import 'package:architect/models/configuration/layer.dart';
import 'package:architect/models/configuration/banned_class_name.dart';
import 'package:architect/models/configuration/banned_imports.dart';
import 'package:architect/models/configuration/regex.dart';

const _layersKey = 'layers';
const _excludePathsKey = 'excludePaths';
const _layerBannedImportsKey = 'bannedImports';
const _layerBannedClassNamesKey = 'bannedClassNames';

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
      map[_layersKey]?.map((x) => Layer.fromMap(x)),
    );
    final excludePaths = List<RegExp>.from(
      (map[_excludePathsKey]?.map((x) => Regex.fromMap(x)) ?? []),
    );
    final bannedImportsList = List<BannedImports>.from(
      map[_layerBannedImportsKey]?.map((x) => BannedImports.fromMap(x)),
    );
    final bannedClassNamesList = List<BannedClassName>.from(
      map[_layerBannedClassNamesKey]?.map((x) => BannedClassName.fromMap(x)),
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

  factory ProjectConfiguration.empty() {
    return ProjectConfiguration(
      [],
      [],
      <Layer, Set<Layer>>{},
      <Layer, Set<RegExp>>{},
    );
  }
}
