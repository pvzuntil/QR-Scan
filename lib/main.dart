import 'package:flutter/material.dart';
import 'package:scanner/MainMenu.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        canvasColor: Colors.transparent,
      ),
      title: 'SCANNAN',
      home: MainMenu(),
      // home: BuildResultBottomSheet(),
    );
  }
}
