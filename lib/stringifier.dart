import 'package:architect/models/class.dart';

class StringifyResult {
  final String result;
  final int count;

  StringifyResult(this.result, this.count);
}

StringifyResult stringifyFoundClasses(List<Class> classes) {
  final result = classes.map((c) => c.getDescription()).join('\n');
  return StringifyResult(result, classes.length);
}

StringifyResult stringifyClassErrors(List<Class> knownClasses) {
  var errorCount = 0;
  final result = <String>[];
  for (final knownClass in knownClasses) {
    if (knownClass.errors.isNotEmpty) {
      result.add(knownClass.getDescriptionWithErrors());
      errorCount += knownClass.errors.length;
    }
  }
  return StringifyResult(result.join('\n'), errorCount);
}
