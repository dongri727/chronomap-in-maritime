import 'dart:convert';
import 'package:acorn_client/acorn_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:provider/provider.dart';
import '../fetch/fetch_with_map.dart';
import '../fetch/fetch_japanese.dart';
import '../gl_script.dart';

class Atlantic extends StatefulWidget {
  final List<int>? principalIds;
  const Atlantic({super.key, this.principalIds});

  @override
  AtlanticState createState() => AtlanticState();
}

class AtlanticState extends State<Atlantic> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<dynamic>? coastLine;

  List<Map<String, dynamic>>? maritimeData;
  final FetchWithMapRepository fetchWithMapRepository = FetchWithMapRepository();

  @override
  void initState() {
    super.initState();
    fetchJapaneseNamesIfNeeded();
    _loadData(widget.principalIds);
    _loadCoastLine();
  }

  //DB多言語化
  Future<void> fetchJapaneseNamesIfNeeded() async {
    final fetchJapaneseRepository = Provider.of<FetchJapaneseRepository>(context, listen: false);
    if (fetchJapaneseRepository.isJapaneseLanguage(context)) {
      await fetchJapaneseRepository.fetchAllJapaneseNames();
    }
  }

  Future<void> _loadData(List<int>? principalIds) async {
    final FetchJapaneseRepository fetchJapaneseRepository = FetchJapaneseRepository();
    await fetchJapaneseRepository.fetchAllJapaneseNames();
    await fetchWithMapRepository.fetchWithMap(keyNumbers: principalIds);
    setState(() {
      maritimeData = fetchWithMapRepository.listWithMap.map((withMap) => {
        "value": [withMap.longitude, withMap.latitude, withMap.logarithm],
          "name": fetchJapaneseRepository.isJapaneseLanguage(context)
          ? fetchJapaneseRepository.getJapaneseName(withMap.principalId)
            : withMap.affair,
      }).toList();
    });
  }

  Future<void> _loadCoastLine() async {
    final String jsonString = await rootBundle.loadString('assets/json/coastline.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    setState(() {
      coastLine = jsonData.map((coordinate) => [...coordinate, 0]).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
