import 'package:analyzer/dart/element/element.dart';
import 'package:architect/models/architecture_errors/error.dart';
import 'package:architect/models/configuration/layer.dart';

class ClassNameError extends ArchitectureError {
  final ClassElement element;
  final Layer layer;
  final RegExp regex;

  ClassNameError({
    required this.element,
    required this.layer,
    required this.regex,
  });

  @override
  String getErrorMessage() {
    final allMatches = regex.allMatches(element.displayName);
    return allMatches.map(_printMatch).toList().join('');
  }

  String _printMatch(RegExpMatch match) {
    return '- wrong class name from: ${match.start} to: ${match.end} wrong phrase: "${element.displayName.substring(match.start, match.end)}"';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassNameError && other.element == element && other.regex == regex && other.layer == layer;
  }

  @override
  int get hashCode => element.hashCode ^ regex.hashCode ^ layer.hashCode;
}

class AAAA {
  static int A = 1;
}

class BBBB with AAAA {}
