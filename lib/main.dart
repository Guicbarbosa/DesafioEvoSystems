import 'package:flutter/material.dart';
import 'package:desafio/screens/screen_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Challenge(),  //Redireciona para página challenge (screen_list)
    );
  }
}