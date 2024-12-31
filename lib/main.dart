import 'package:algvisualizerprovider/bubbleLogic.dart';
import 'package:algvisualizerprovider/bubbleUi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark, // Dark theme
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.lightBlue),
        ),
      ),
      themeMode: ThemeMode.dark,
      home: ChangeNotifierProvider(
        create: (context) => BubbleLogic(),
        child: BubbleSortVisualizer(),
      ),
    );
  }
}
