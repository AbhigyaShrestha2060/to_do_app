import 'package:flutter/material.dart';
import 'package:to_do_app/screen/to_do_app_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ToDoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
