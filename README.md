To run analyzer please run 'dart run' from terminal
To print architecture from architecture.yaml please run "dart run bin/analyzer_tool.dart run -a"
To print all parsed files please run "dart run bin/analyzer_tool.dart run -f"
To print all founded classes please run "dart run bin/analyzer_tool.dart run -c"
To save all classes errors to file please run "dart run bin/analyzer_tool.dart --classes-errors-output=PATH-TO-FILE"
To save all founded classes to file please run "dart run bin/analyzer_tool.dart --founded-classes-output=PATH-TO-FILE"
To specify input project please run "dart run bin/analyzer_tool.dart --input-path=PATH-TO-FILE". By default --input-path=.
You can mix flags like "--classes-errors-output=PATH -afc" etc.