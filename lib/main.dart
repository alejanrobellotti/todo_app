import 'package:flutter/material.dart';
import 'package:todo_app/config/app_theme.dart';
import 'package:todo_app/screens/todo_list.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const TodoListPage(),
    );
  }
}
