import 'dart:io';

Future<void> writeStringToFile(String content, String path) async {
  try {
    final errorsFile = File(path);
    await errorsFile.writeAsString(content, mode: FileMode.writeOnly);
  } on FileSystemException catch (exception) {
    print(
      'Failed writing to file ${exception.path} (${exception.osError})',
    );
    exit(1);
  }
}
