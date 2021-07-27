import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:architect/models/configuration/project_configuration.dart';
import 'package:yaml/yaml.dart';

Future<ProjectConfiguration> readConfiguration(String input) async {
  final architectureFilePath = path.join(input, 'architecture.yaml');

  final architectureFile = File(architectureFilePath);
  if (!(await architectureFile.exists())) {
    print('Architecture file not found at $architectureFilePath');
    exit(1);
  }

  final architectureFileContent = await architectureFile.readAsString();
  var doc = loadYaml(architectureFileContent);

  return ProjectConfiguration.fromMap(doc.value);
}
