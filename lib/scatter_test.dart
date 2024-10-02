import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

import 'gl_script.dart' show glScript;

class Planets extends StatefulWidget {
  const Planets({super.key});

  @override
  PlanetsState createState() => PlanetsState();
}

class PlanetsState extends State<Planets> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<dynamic>? cassini;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final String jsonString = await rootBundle.loadString('assets/json/cassini_timeline.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    setState(() {
      cassini = jsonData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Planets Explore'),
      ),
      body: Container(
/*        constraints: const BoxConstraints.expand( ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/space.png'),
            fit: BoxFit.cover,
          ),
        ),*/
        child: Center(
          child: SizedBox(
            width: 1200,
            height: 1000,
            child: cassini == null
                ? const CircularProgressIndicator()
                : Echarts(
              extensions: const [glScript],
              option: '''
    (function() {
      function generateOrbitData(radius, interval) {
        var data = [];
        for (var t = 0; t < 2 * Math.PI; t += interval) {
          var x = radius * Math.cos(t);
          var y = radius * Math.sin(t);
          var z = 2450000;  //時間軸対応
          data.push([x, y, z]);
        }
        return data;
      }

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
            beta: -60
          }
        },
        xAxis3D: {
          type: 'value',
          min: -30,
          max: 30,
          splitLine: {show: false},
          name: 'Pisces-Virgo',
          axisLine: {
            lineStyle: {color: '#E6E1E6'}
          }
        },
        yAxis3D: {
          type: 'value',
          min: -30,
          max: 30,
          splitLine: {show: false},                  
          name: 'Gemini-Sagittarius',
          axisLine: {
            lineStyle: {color: '#E6E1E6'}
          }
        },
        zAxis3D: {
          type: 'value',
          min: 2450000,
          max: 2455000,
          splitLine: {show: false},
          name: 'timeline(JulianD)',
          axisLine: {
            lineStyle: {color: '#E6E1E6'}
          }                                 
        },
        series: [
          {
            type: 'scatter3D',
            symbolSize: 5,
            data: ${json.encode(cassini)},
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
              itemStyle: {opacity: 0.8}    
            },
            {
              type: 'scatter3D',
              symbolSize: 2,
              data: generateOrbitData(5.82, 0.01), // 水星
              itemStyle: { color: '#FF6347' } 
            },
            {
              type: 'scatter3D',
              symbolSize: 2,
              data: generateOrbitData(10.75, 0.01), // 金星
              itemStyle: { color: '#FF6347' } 
            },
            {
              type: 'scatter3D',
              symbolSize: 2,
              data: generateOrbitData(14.93, 0.01), // 地球
              itemStyle: { color: 'blue' } 
            },
            {
              type: 'scatter3D',
              symbolSize: 2,
              data: generateOrbitData(22.68, 0.01), // 火星
              itemStyle: { color: '#FF6347' } 
            },
            {
              type: 'scatter3D',
              symbolSize: 2,
              data: generateOrbitData(40.31, 0.01), // 小惑星帯
              itemStyle: { color: '#FF6347' } 
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