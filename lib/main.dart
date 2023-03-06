import 'package:flutter/material.dart';
import 'allpages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tax Calculation System',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
