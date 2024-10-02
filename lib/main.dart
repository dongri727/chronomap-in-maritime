import 'package:flutter/material.dart';

import 'index.dart';



// final display = createDisplay(decimal: 2);

//flutter_echarts exampleから変形
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IndexPage(),
      //home: const MyChart(),
    );
  }
}


