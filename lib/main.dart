import 'package:flutter/material.dart';
import 'package:untangle/screens/screens.dart';
import 'package:untangle/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      title: 'Untangle',
      home: HomeScreen(),
    );
  }
}
