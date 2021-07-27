import 'package:flutter/material.dart';
import 'package:example/presentation/main_page.dart';
import 'package:example/utils/mixin_test.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget with MixinA {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Architect Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}
