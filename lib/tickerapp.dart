import 'package:flutter/material.dart';
import 'package:tickr/screens/homescreen.dart';
import 'package:tickr/utils/theme.dart';

class TickrApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tickr App',
      theme: darkTheme,
      home: HomeScreen(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}
