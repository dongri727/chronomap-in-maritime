import 'dart:convert';
import 'package:chronomap_in_maritime/fetch/fetch_ptincipal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'fetch/fetch_with_map.dart';
import 'gl_script.dart' show glScript;

class DBView extends StatefulWidget {
  const DBView({super.key});

  @override
  DBViewState createState() => DBViewState();
}

class DBViewState extends State<DBView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<int> maritimeCode = [327,328,329,330,331,332,333,334,336,337,338,339,340,341,342,343,344];
  List<dynamic>? coastLine;

  List<Map<String, dynamic>>? maritimeData;
  final FetchWithMapRepository fetchWithMapRepository = FetchWithMapRepository();
  final FetchPrincipalRepository fetchPrincipalRepository = FetchPrincipalRepository();

  @override
  void initState() {
    super.initState();
    _loadData(maritimeCode);
    _loadCoastLine();
  }

  int? selectedId;

  Future<void> getPrincipalIds(selectedId) async {
    await fetchPrincipalRepository.fetchPrincipalByDetailId(detailIds: selectedId);
  }

  Future<void> _loadData(maritimeCode) async {
    await fetchWithMapRepository.fetchWithMap(keyNumbers: maritimeCode);
    setState(() {
      maritimeData = fetchWithMapRepository.listWithMap.map((withMap) => {
        "value": [withMap.longitude, withMap.latitude, withMap.logarithm],
        "name": withMap.affair,
      }).toList();
    });
  }
  
  Future<void> _loadCoastLine() async {
    final String jsonString = await rootBundle.loadString('assets/json/coastline.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    setState(() {
      coastLine = jsonData.map((coordinate) => [...coordinate, 895]).toList();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('DB View'),
      ),
      body: Container(
        constraints: const BoxConstraints.expand( ),
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
            beta: -60
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
          min: 890,
          max: 900,
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