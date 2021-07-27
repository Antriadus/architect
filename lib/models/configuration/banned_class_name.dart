import 'package:architect/models/configuration/layer.dart';
import 'package:architect/models/configuration/regex.dart';

const _layerKey = 'layer';
const _bannedClassNames = 'banned';

class BannedClassName {
  final Layer layer;
  final List<RegExp> bannedClassNames;

  BannedClassName(
    this.layer,
    this.bannedClassNames,
  );

  factory BannedClassName.fromMap(Map<dynamic, dynamic> map) {
    return BannedClassName(
      Layer.fromMap(map[_layerKey]),
      List<RegExp>.from(map[_bannedClassNames]?.map((x) => Regex.fromMap(x))),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BannedClassName && other.layer == layer && other.bannedClassNames == bannedClassNames;
  }

  @override
  int get hashCode => layer.hashCode ^ bannedClassNames.hashCode;
}
