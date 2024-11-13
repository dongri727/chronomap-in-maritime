import 'package:acorn_client/acorn_client.dart';
import 'package:chronomap_in_maritime/search/classic_view.dart';
import 'package:chronomap_in_maritime/search/on_globe_view.dart';
import 'package:chronomap_in_maritime/search/atlantic.dart';
import 'package:chronomap_in_maritime/search/pacific.dart';
import 'package:chronomap_in_maritime/utils/theme.dart';
import 'package:flutter/material.dart';
import '../../index.dart';
import '../../utils/navi_button.dart';


class ResultTabTop extends StatelessWidget {
  final List<Principal> listPrincipal;
  final List<int>? principalIds;
  final List<Map<String, dynamic>> maritimeData;
  final List<Map<String, dynamic>> pacificData;
  final List<dynamic> coastLine;
  final List<dynamic> pacificLine;
  final List<dynamic> globeLine;
  final List<dynamic> ridgeLine;
  final List<dynamic> pacificRidge;
  final List<dynamic> globeRidge;
  final List<dynamic> trenchLine;
  final List<dynamic> pacificTrench;
  final List<dynamic> globeTrench;

  const ResultTabTop({
    super.key,
    required this.listPrincipal,
    this.principalIds,
    required this.maritimeData,
    required this.pacificData,
    required this.coastLine,
    required this.pacificLine,
    required this.globeLine,
    required this.ridgeLine,
    required this.pacificRidge,
    required this.globeRidge,
    required this.trenchLine,
    required this.pacificTrench,
    required this.globeTrench,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/sea.png'),
                    fit: BoxFit.cover)
            ),
          ),
          leading: const NavigationButton(
              destinationPage: IndexPage(),
              buttonText: 'INDEX'),
          leadingWidth: 100,
          title: Text(
            'Result View',
            style: MaritimeTheme.textTheme.headlineMedium,
          ),
          actions: [
            IconButton(
                onPressed: () {
/*                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MiniMoonHint()));*/
                },
                icon: const Icon(Icons.question_mark, color: Colors.blue,))
          ],
          bottom: TabBar(
            labelStyle: MaritimeTheme.textTheme.headlineMedium?.copyWith(
              fontSize: screenWidth < 600 ? 16 : 30),
            indicatorColor: Colors.yellow,
            tabs: const [
              Tab(text: "CLASSIC"),
              Tab(text: "Atlantic"),
              Tab(text: "Pacific"),
              Tab(text: "Globe"),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ClassicViewPage(listPrincipal: listPrincipal, principalIds: principalIds, maritimeData: maritimeData,),
            Atlantic(maritimeData: maritimeData, coastLine: coastLine, ridgeLine: ridgeLine, trenchLine: trenchLine),
            Pacific(pacificData: pacificData, pacificLine: pacificLine, pacificRidge: pacificRidge, pacificTrench: pacificTrench),
            OnGlobeView(maritimeData: maritimeData, globeLine: globeLine, globeRidge: globeRidge, globeTrench: globeTrench),
          ],
        ),
      ),
    );
  }
}