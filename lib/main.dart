import 'package:flutter/material.dart';
import 'package:wall_paper_app/screens/home_screen.dart';
import 'package:wall_paper_app/widgets/custom_appbar.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
      title: "WallPaper App",
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
      ),

      home: const HomeScreen()

    );
  }
}








