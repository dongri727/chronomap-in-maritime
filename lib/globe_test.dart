import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_echarts/flutter_echarts.dart';
import 'gl_script.dart';


//GPTo1作成
class MyChart extends StatefulWidget {
  const MyChart({super.key});

  @override
  MyChartState createState() => MyChartState();
}

class MyChartState extends State<MyChart> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String option = '';
  Future<List<dynamic>>? _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = loadAndProcessData();
  }

  Future<List<dynamic>> loadAndProcessData() async {
    String jsonString = await rootBundle.loadString('assets/json/coastline.json');
    List<dynamic> data = json.decode(jsonString);

    data = data
        .map((dataItem) => [dataItem[0], dataItem[1], 7])
        .toList();

    return data;
  }


  String createOption(List<dynamic> data) {
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
          beta: 180,
          alpha: 20,
          distance: 100
        }
      },
      series: {
        type: "scatter3D",
        coordinateSystem: "globe",
        blendMode: "lighter",
        symbolSize: 2,
        itemStyle: {
          color: "rgb(255, 255, 255)",
          opacity: 1
        },
        data: ${json.encode(data)}
      }
    }
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('ECharts Example'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: _dataFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String option = createOption(snapshot.data!);
              return Echarts(
                extensions: const [glScript],
                captureAllGestures: true,
                option: option,
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('データの読み込み中にエラーが発生しました'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
