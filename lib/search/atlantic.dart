import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import '../gl_script.dart';

class Atlantic extends StatelessWidget {
  final List<Map<String, dynamic>>? maritimeData;
  final List<dynamic>? coastLine;
  final List<dynamic>? ridgeLine;
  final List<dynamic>? trenchLine;
  const Atlantic({
    super.key,
    this.maritimeData,
    this.coastLine,
    this.ridgeLine,
    this.trenchLine
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
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
            child: maritimeData == null
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
          min: -1000,
          max: 1000,
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
            data: ${json.encode(maritimeData)},
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
              data: ${json.encode(coastLine)},
              itemStyle: { color: 'white' } 
            }, 
            {
              type: 'scatter3D',
              symbolSize: 3,
              data: ${json.encode(ridgeLine)},
                itemStyle: {color: '#bc8f8f'}              
            }, 
            {
              type: 'scatter3D',
              symbolSize: 3,
              data: ${json.encode(trenchLine)},
                itemStyle: {color: '#800000'}              
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
