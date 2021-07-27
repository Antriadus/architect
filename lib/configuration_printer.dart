import 'package:architect/models/configuration/project_configuration.dart';
import 'package:architect/models/configuration/layer.dart';

String printConfiguration(ProjectConfiguration config) {
  return [
    _printLayers(config),
    '\n',
    _printExcluded(config),
    '\n',
  ].join('');
}

String _printLayers(ProjectConfiguration config) {
  return [
    '\n',
    '=' * 30,
    'LAYERS:',
    '=' * 30,
    '\n\n',
    ...config.layers.map((e) => _printLayer(config, e)),
  ].join('');
}

String _printLayer(ProjectConfiguration config, Layer layer) {
  return [
    '\n',
    '-' * 10,
    layer.displayName,
    '-' * 10,
    '\n\nfile path:\t${layer.pathRegex.pattern}    ${layer.pathRegex.isCaseSensitive ? "" : "case not sensitive"}\n',
    ..._printBannedClassNames(config.bannedClassNames[layer] ?? {}),
    ..._printBannedImports(config.bannedImports[layer] ?? {}),
    '\n\n',
  ].join('');
}

List<String> _printBannedClassNames(Set<RegExp> banned) {
  if (banned.isEmpty) return [''];
  return [
    '\nclass name should NOT match:',
    ...banned.map(_printRegex),
    '\n',
  ];
}

List<String> _printBannedImports(Set<Layer> banned) {
  if (banned.isEmpty) return [''];
  return [
    '\nclass should NOT import from layers:',
    ...banned.map((b) => '\n\t${b.displayName}'),
    '\n',
  ];
}

String _printExcluded(ProjectConfiguration config) {
  if (config.excludePaths.isEmpty) {
    return '';
  }
  return [
    '=' * 20,
    'EXCLUDED',
    '=' * 20,
    '\n',
    '\nFile paths excluded from analysis:',
    ...config.excludePaths.map(_printRegex),
  ].join('');
}

String _printRegex(RegExp regex) {
  return '\n\t${regex.pattern}    ${regex.isCaseSensitive ? "" : "case not sensitive"}';
}
