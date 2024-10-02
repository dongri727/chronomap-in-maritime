import 'package:chronomap_in_maritime/globe_test.dart';
import 'package:chronomap_in_maritime/test1_page.dart';
import 'package:flutter/material.dart';

import 'scatter_test.dart';

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
/*
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/main.png'),
              fit: BoxFit.cover,
            ),
          ),
*/
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: OutlinedButton(
                  child: Text('globe-test'
/*                    AppLocalizations.of(context)!.indexA,
                    style: SpaceTheme.textTheme.headlineMedium,*/
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyChart()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: OutlinedButton(
                  child: Text('scatter-test'
/*                    AppLocalizations.of(context)!.indexB,
                    style: SpaceTheme.textTheme.headlineMedium,*/
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Planets()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: OutlinedButton(
                  child: Text('test1'
/*                    AppLocalizations.of(context)!.indexC,
                    style: SpaceTheme.textTheme.headlineMedium,*/
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage()));
                  },
                ),
              ),
/*              Padding(
                padding: const EdgeInsets.all(12.0),
                child: OutlinedButton(
                  child: Text(
                    AppLocalizations.of(context)!.indexD,
                    style: SpaceTheme.textTheme.headlineMedium,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Paths()));
                  },
                ),
              ),*/
             /* Padding(
                padding: const EdgeInsets.all(12.0),
                child: OutlinedButton(
                  child: Text(
                    AppLocalizations.of(context)!.indexE,
                    style: SpaceTheme.textTheme.headlineMedium,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Planets()));
                  },
                ),
              ),*/
/*              Padding(
                padding: const EdgeInsets.all(12.0),
                child: OutlinedButton(
                  child: Text(
                    'Mini Moon',
                    style: SpaceTheme.textTheme.headlineMedium,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MiniMoonPage()));
                  },
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}