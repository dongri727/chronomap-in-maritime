import 'dart:async';
import 'dart:convert';

import 'package:chronomap_in_maritime/globe_test.dart';
import 'package:flutter/material.dart';

import 'package:flutter_echarts/flutter_echarts.dart';
//import 'package:number_display/number_display.dart';

import 'gl_script.dart' show glScript;

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
      home: const MyHomePage(),
      //home: const MyChart(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Globe Test'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[

              const Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
                child: Text('Using WebGL for 3D charts',
                    style: TextStyle(fontSize: 20)),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 100),
                child: Text('- chart capture all gestures'),
              ),

              Container(
                width: 400,
                height: 500,
                child: Echarts(
                  extensions: const [glScript],
                  captureAllGestures: true,
                  option: '''
                    {
                      backgroundColor: "#000",
  globe: {
    baseTexture: "asset://assets/images/world.topo.bathy.200401.jpg",
    heightTexture: "asset://assets/images/bathymetry_bw_composite_4k.jpg",
    displacementScale: 0.2,
    shading: 'realistic',
    environment: "asset://assets/images/starfield.jpg",
    postEffect: {
      enable: true
    },
    viewControl: {
      autoRotate: false
    },
    light: {
      main: {
        intensity: 2,
        shadow: true
      },
      ambientCubemap: {
        exposure: 2,
        diffuseIntensity: 2,
        specularIntensity: 2
      }
    }
  }

                    }
                  ''',

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
