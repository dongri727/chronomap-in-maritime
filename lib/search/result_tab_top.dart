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
  const ResultTabTop({super.key, required this.listPrincipal, this.principalIds});

  @override
  Widget build(BuildContext context) {
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
            labelStyle: MaritimeTheme.textTheme.headlineMedium,
            indicatorColor: Colors.yellow,
            tabs: const [
              Tab(text: "CLASSIC View"),
              Tab(text: "Atlantic View"),
              Tab(text: "Pacific View"),
              Tab(text: "onGlobe View"),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ClassicViewPage(listPrincipal: listPrincipal, principalIds: principalIds),
            Atlantic(principalIds: principalIds),
            Pacific(principalIds: principalIds),
            OnGlobeView(principalIds: principalIds),
          ],
        ),
      ),
    );
  }
}