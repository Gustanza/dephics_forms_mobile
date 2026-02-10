import 'package:flutter/material.dart';
import 'package:survey_app/views/all_forms.dart';
import 'package:survey_app/views/survey_input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Outlet Interaction Report',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F3F7),
        useMaterial3: true,
      ),
      home: AllForms(),
    );
  }
}
