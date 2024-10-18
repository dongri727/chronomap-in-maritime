import 'package:chronomap_in_maritime/search/search_page.dart';
import 'package:chronomap_in_maritime/globe_test.dart';
import 'package:chronomap_in_maritime/scalable/menu/scalable.dart';
import 'package:chronomap_in_maritime/scatter/columbus/columbus.dart';
import 'package:chronomap_in_maritime/test1_page.dart';
import 'package:chronomap_in_maritime/utils/theme.dart';
import 'package:flutter/material.dart';
import 'add_events/principal_page.dart';
import 'scatter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints.expand( ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/sea.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: OutlinedButton(
                  child: Text(
                    AppLocalizations.of(context)!.indexA,
                    style: MaritimeTheme.textTheme.headlineMedium,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrincipalPage()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: OutlinedButton(
                  child: Text(
                    'Search & View',
                    style: MaritimeTheme.textTheme.headlineMedium,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchPage()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: OutlinedButton(
                  child: Text('Columbus',
                    style: MaritimeTheme.textTheme.headlineMedium,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ColumbusPage()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: OutlinedButton(
                  child: Text('scatter-test',
                    //AppLocalizations.of(context)!.indexB,
                    style: MaritimeTheme.textTheme.headlineMedium,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DBView()));
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: OutlinedButton(
                  child: Text('scalable',
                    //AppLocalizations.of(context)!.indexD,
                    style: MaritimeTheme.textTheme.headlineMedium,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Scalable()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: OutlinedButton(
                  child: Text('Test1Page',
                    //AppLocalizations.of(context)!.indexE,
                    style: MaritimeTheme.textTheme.headlineMedium,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Test1Page()));
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: OutlinedButton(
                  child: Text('globe-test',
                    //AppLocalizations.of(context)!.indexA,
                    style: MaritimeTheme.textTheme.headlineMedium,
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyChart()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}