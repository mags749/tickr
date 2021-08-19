import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tickr/tickerapp.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(TickrApp());
}
