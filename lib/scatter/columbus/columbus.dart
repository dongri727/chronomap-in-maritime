import 'package:chronomap_in_maritime/scatter/columbus/columbus1st.dart';
import 'package:chronomap_in_maritime/utils/theme.dart';
import 'package:flutter/material.dart';
import '../../index.dart';
import '../../utils/navi_button.dart';
import 'columbus2nd.dart';
import 'columbus3rd.dart';


class ColumbusPage extends StatelessWidget {
  const ColumbusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
              'Columbus Exploration',
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
              Tab(text: "1stVoyage"),
              Tab(text: "2ndVoyage"),
              Tab(text: "3rdVoyage"),
            ],
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Columbus1st(),
            Columbus2nd(),
            Columbus3rd(),
          ],
        ),
      ),
    );
  }
}