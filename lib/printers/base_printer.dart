import 'package:architect/project_class.dart';

abstract class BasePrinter {
  void printInfo(String message);
  void printClasses(List<ProjectClass> classes);
}
