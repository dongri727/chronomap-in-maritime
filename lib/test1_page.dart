import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

import 'gl_script.dart';

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