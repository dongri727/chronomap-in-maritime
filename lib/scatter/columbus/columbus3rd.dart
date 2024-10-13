import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_echarts/flutter_echarts.dart';
import '../../gl_script.dart';

class Columbus3rd extends StatefulWidget {
  const Columbus3rd({super.key});

  @override
  Columbus3rdState createState() => Columbus3rdState();
}

class Columbus3rdState extends State<Columbus3rd> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String option = '';
  Future<Map<String, List<dynamic>>>? _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = loadAndProcessData();
  }

  Future<Map<String, List<dynamic>>> loadAndProcessData() async {
    // coastline.jsonの読み込み
    String coastlineJsonString = await rootBundle.loadString('assets/json/coastline.json');
    List<dynamic> coastlineData = json.decode(coastlineJsonString);
    coastlineData = coastlineData.map((dataItem) => [dataItem[0], dataItem[1], 7]).toList();

    // columbus.jsonの読み込み
    String columbusJsonString = await rootBundle.loadString('assets/json/columbus3rd.json');
    List<dynamic> columbus2ndData = json.decode(columbusJsonString);

    return {
      'coastline': coastlineData,
      'columbus3rd': columbus2ndData
    };
  }

  String createOption(Map<String, List<dynamic>> data) {
    return '''
    {
      visualMap: {
        show: false,
        min: 0,
        max: 60,
        inRange: {
          symbolSize: [1.0, 10.0]
        }
      },
      globe: {
        environment: "　",
        heightTexture: "　",
        displacementScale: 0.05,
        displacementQuality: "high",
        globeOuterRadius: 100,
        baseColor: "#000",
        shading: "realistic",
        postEffect: {
          enable: true,
          depthOfField: {
            focalRange: 15,
            enable: false,
            focalDistance: 100
          }
        },
        temporalSuperSampling: {
          enable: true
        },
        light: {
          ambient: {
            intensity: 0
          },
          main: {
            intensity: 0.1,
            shadow: false
          },
          ambientCubemap: {
            texture: "asset://assets/lake.hdr",
            exposure: 1,
            diffuseIntensity: 0.5,
            specularIntensity: 2
          }
        },
        viewControl: {
          autoRotate: false,
          targetCoord:[-60, 15],
          beta: 180,
          alpha: 20,
          distance: 200
        }
      },
      series: [
        {
          type: "scatter3D",
          coordinateSystem: "globe",
          blendMode: "lighter",
          symbolSize: 2,
          itemStyle: {
            color: "rgb(255, 255, 255)",
            opacity: 1
          },
          data: ${json.encode(data['coastline'])}
        },
        {
          type: "scatter3D",
          coordinateSystem: "globe",
          blendMode: "lighter",
          symbolSize: 10,
          itemStyle: {
            opacity: 1
          },
          data: ${json.encode(data['columbus3rd'])},
          label: {
                show: true,
                textStyle: {
                  fontSize: 20,
                  borderWidth: 1
                },
                formatter: function(param) {
                  return param.data.name;
                }
              },
        }
      ]
    }
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: FutureBuilder<Map<String, List<dynamic>>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String option = createOption(snapshot.data!);
            return Echarts(
              extensions: const [glScript],
              option: option,
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('データの読み込み中にエラーが発生しました'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}