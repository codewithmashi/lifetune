import 'package:flutter/material.dart';
import 'package:lifetune/welcome.dart';

void main() {
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lifetune',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xffF7ECE0),
        ),
        scaffoldBackgroundColor: Color(0xffF7ECE0),
        useMaterial3: true,
        
      ),
      home: Welcome(),
    );
  }
}

