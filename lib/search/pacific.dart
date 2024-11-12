import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import '../gl_script.dart' show glScript;

class Pacific extends StatelessWidget {
  final List<Map<String, dynamic>>? pacificData;
  final List<dynamic>? pacificLine;
  final List<dynamic>? pacificRidge;
  final List<dynamic>? pacificTrench;
  const Pacific({
    super.key,
    this.pacificData,
    this.pacificLine,
    this.pacificRidge,
    this.pacificTrench
  });

  @override
  Widget build(BuildContext context) {
    if (pacificData == null || pacificData!.isEmpty) {
      return const CircularProgressIndicator();
    }

    // pacificDataから3番目の値（z軸）を抽出して最小値・最大値を計算
    List<double> zValues = pacificData!
        .map((item) => item['value'][2] as double)
        .toList();

    double minZ = zValues.reduce(min).floorToDouble(); // 最小値を切り捨て
    double maxZ = zValues.reduce(max).ceilToDouble(); // 最大値を切り上げ
    double midZ = (minZ + maxZ) / 2; // 中間値を計算

    // coastLine, ridgeLine, trenchLine の z 軸値を midZ に設定
    List<dynamic> transformedPacificLine = pacificLine?.map((coordinate) {
      return [coordinate[0], coordinate[1], midZ];
    }).toList() ?? [];

    List<dynamic> transformedPacificRidge = pacificRidge?.map((coordinate) {
      return [coordinate[0], coordinate[1], midZ];
    }).toList() ?? [];

    List<dynamic> transformedPacificTrench = pacificTrench?.map((coordinate) {
      return [coordinate[0], coordinate[1], midZ];
    }).toList() ?? [];

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sea.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 1200,
            height: 1000,
            child: pacificData == null
                ? const CircularProgressIndicator()
                : Echarts(
              extensions: const [glScript],
              option: '''
    (function() {
      return {
        tooltip: {
          show: true,
          formatter: function(params) {
            var data = params.data;
            return 'Name: ' + data.name;
          
          }
        },
        grid3D: {
          viewControl: {
            alpha: 40,
            beta: -60,
            projection: 'orthographic'
          }
        },
        xAxis3D: {
          type: 'value',
          min: -90,
          max: 90,
          splitLine: {show: false},
          name: 'Longitude',
          axisLine: {
            lineStyle: {color: '#E6E1E6'}
          }
        },
        yAxis3D: {
          type: 'value',
          min: -90,
          max: 90,
          splitLine: {show: false},                  
          name: 'Latitude',
          axisLine: {
            lineStyle: {color: '#E6E1E6'}
          }
        },
        zAxis3D: {
          type: 'value',
          min: $minZ,
          max: $maxZ,
          splitLine: {show: false},
          name: 'timeline',
          axisLine: {
            lineStyle: {color: '#E6E1E6'}
          }                                 
        },
        series: [
          {
            type: 'scatter3D',
            symbolSize: 6,
            data: ${json.encode(pacificData)},
              label: {
                show: true,
                textStyle: {
                  fontSize: 12,
                  borderWidth: 1
                },
                formatter: function(param) {
                  return param.data.name;
                }
              },
              itemStyle: {color: 'yellow', opacity: 0.8}    
            },
            {
              type: 'scatter3D',
              symbolSize: 3,
              data: ${json.encode(transformedPacificLine)},
              itemStyle: { color: 'white' } 
            },  
            {
              type: 'scatter3D',
              symbolSize: 3,
              data: ${json.encode(transformedPacificRidge)},
              itemStyle: { color: '#bc8f8f' } 
            },
            {
              type: 'scatter3D',
              symbolSize: 3,
              data: ${json.encode(transformedPacificTrench)},
              itemStyle: { color: '#cd5c5c' } 
            },     
          ]
        };
            })()
            ''',
            ),
          ),
        ),
      ),
    );
  }
}