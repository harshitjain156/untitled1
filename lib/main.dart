import 'package:flutter/material.dart';
import 'package:untitled1/screen/home_screen.dart';
import 'package:untitled1/screen/todo_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        brightness: Brightness.dark,
        appBarTheme:AppBarTheme(color: Colors.black12)
      ),
      debugShowCheckedModeBanner: false,

      home: TodoHomeScreen(),
    );
  }
}


