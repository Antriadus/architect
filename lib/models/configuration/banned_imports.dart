import 'package:architect/models/configuration/layer.dart';

const _layerKey = 'layer';
const _cannotImportFromKey = 'banned';

class BannedImports {
  final Layer layer;
  final List<Layer> cannotImportFrom;

  BannedImports(
    this.layer,
    this.cannotImportFrom,
  );

  factory BannedImports.fromMap(Map<dynamic, dynamic> map) {
    return BannedImports(
      Layer.fromMap(map[_layerKey]),
      List<Layer>.from(map[_cannotImportFromKey]?.map((x) => Layer.fromMap(x))),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BannedImports && other.layer == layer && other.cannotImportFrom == cannotImportFrom;
  }

  @override
  int get hashCode => layer.hashCode ^ cannotImportFrom.hashCode;
}
