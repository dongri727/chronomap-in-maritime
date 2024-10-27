import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import '../../gl_script.dart';

class OnGlobeView extends StatelessWidget {
  final List<Map<String, dynamic>>? maritimeData;
  final List<dynamic>? globeLine;
  final List<dynamic>? globeRidge;
  final List<dynamic>? globeTrench;

  OnGlobeView({
    super.key,
    this.maritimeData,
    this.globeLine,
    this.globeRidge,
    this.globeTrench
  });

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


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
          targetCoord:[-30, 30],
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
          symbolSize: 5,
          itemStyle: {
            color: "white",
            opacity: 1
          },
          data: ${json.encode(data['coastline'])},
        },
        {
          type: "scatter3D",
          coordinateSystem: "globe",
          blendMode: "lighter",
          symbolSize: 5,
          itemStyle: {
            color: "#adff2f",
            opacity: 1
          },
          data: ${json.encode(data['ridgeline'])},
        },
        {
          type: "scatter3D",
          coordinateSystem: "globe",
          blendMode: "lighter",
          symbolSize: 5,
          itemStyle: {
            color: "#008000",
            opacity: 1
          },
          data: ${json.encode(data['trenchline'])},
        },
        {
          type: "scatter3D",
          coordinateSystem: "globe",
          blendMode: "lighter",
          symbolSize: 10,
          itemStyle: {
            color: "yellow",
            opacity: 1
          },
          data: ${json.encode(data['maritimeData'])},
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
    if (maritimeData == null || globeLine == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Create data map for creating the option
    final data = {
      'coastline': globeLine!,
      'ridgeline': globeRidge!,
      'trenchline': globeTrench!,
      'maritimeData': maritimeData!,
    };

    // Generate the ECharts option string
    String option = createOption(data);

    return Scaffold(
      key: scaffoldKey,
      body: Echarts(
        extensions: const [glScript],
        option: option,
      ),
    );
  }
}


