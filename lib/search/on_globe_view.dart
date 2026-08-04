import 'dart:convert';

import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

import '../../gl_script.dart';

class OnGlobeView extends StatefulWidget {
  final List<Map<String, dynamic>>? maritimeData;
  final List<dynamic>? globeLine;
  final List<dynamic>? globeRidge;
  final List<dynamic>? globeTrench;

  const OnGlobeView({
    super.key,
    this.maritimeData,
    this.globeLine,
    this.globeRidge,
    this.globeTrench,
  });

  @override
  State<OnGlobeView> createState() => _OnGlobeViewState();
}

class _OnGlobeViewState extends State<OnGlobeView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? _renderingError;

  String createOption(
    Map<String, List<dynamic>> data, {
    required bool showLabels,
  }) {
    final labelOption = showLabels
        ? '''
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
        '''
        : '';

    return '''
    {
      tooltip: {
        show: true,
        formatter: function(param) {
          return param.data && param.data.name ? param.data.name : '';
        }
      },
      visualMap: {
        show: false,
        min: 0,
        max: 60,
        inRange: {
          symbolSize: [1.0, 10.0]
        }
      },
      globe: {
        globeOuterRadius: 100,
        baseColor: "#000",
        shading: "color",
        light: {
          ambient: {
            intensity: 0.8
          },
          main: {
            intensity: 0.4,
            shadow: false
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
          $labelOption
        }
      ]
    }
    ''';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.maritimeData == null ||
        widget.globeLine == null ||
        widget.globeRidge == null ||
        widget.globeTrench == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final data = {
      'coastline': widget.globeLine!,
      'ridgeline': widget.globeRidge!,
      'trenchline': widget.globeTrench!,
      'maritimeData': widget.maritimeData!,
    };
    final option = createOption(
      data,
      // ECharts GL 3D labels crash in Android WebView's sprite atlas builder.
      // Names remain available through the tooltip on Android.
      showLabels: defaultTargetPlatform != TargetPlatform.android,
    );

    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          Echarts(
            extensions: const [glScript],
            option: option,
            captureAllGestures: true,
            extraScript: '''
              var originalSetOption = chart.setOption.bind(chart);
              chart.setOption = function() {
                try {
                  return originalSetOption.apply(chart, arguments);
                } catch (error) {
                  console.error('Globe setOption failed: ' + (error.stack || error));
                  if (typeof Messager !== 'undefined') {
                    Messager.postMessage('error:' + String(error));
                  }
                  throw error;
                }
              };
              window.addEventListener('error', function(event) {
                if (typeof Messager !== 'undefined') {
                  Messager.postMessage('error:' + (event.message || 'JavaScript error'));
                }
              });
              window.addEventListener('unhandledrejection', function(event) {
                if (typeof Messager !== 'undefined') {
                  Messager.postMessage('error:' + String(event.reason || 'JavaScript rejection'));
                }
              });
              var probeCanvas = document.createElement('canvas');
              var probeGl = probeCanvas.getContext('webgl') ||
                  probeCanvas.getContext('experimental-webgl');
              if (!probeGl) {
                console.error('WebGL is not available on this device');
                if (typeof Messager !== 'undefined') {
                  Messager.postMessage('error:WebGL is not available on this device');
                }
              }
            ''',
            onMessage: (message) {
              if (!message.startsWith('error:')) return;
              final error = message.substring('error:'.length);
              debugPrint('Globe rendering error: $error');
              if (mounted) setState(() => _renderingError = error);
            },
            onWebResourceError: (_, error) {
              debugPrint('Globe WebView resource error: $error');
              if (mounted) setState(() => _renderingError = error.toString());
            },
          ),
          if (_renderingError != null)
            ColoredBox(
              color: Colors.black87,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Globeを表示できませんでした。\n'
                    'Android System WebViewを更新して、もう一度お試しください。\n\n'
                    'Unable to display Globe. Update Android System WebView '
                    'and try again.\n\n$_renderingError',
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
