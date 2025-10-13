import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

import '../utils/discribe_card.dart';


class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Information'),
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/main.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 50, 50, 0),
                    child: CustomTextContainer(
                        textContent: AppLocalizations.of(context)!.infoA),
                  ),
                  LaunchUrlContainer(
                    textContent: AppLocalizations.of(context)!.infoB,
                    url: 'https://app.laporte.academy',
                  ),
                  LaunchUrlContainer(
                      textContent: AppLocalizations.of(context)!.infoC,
                      url: 'https://tempo-spaco.web.app'),
                  LaunchUrlContainer(
                      textContent: AppLocalizations.of(context)!.infoD,
                      url: 'https://www.youtube.com/@laporte_academy'),
                  CustomTextContainer(
                      textContent: AppLocalizations.of(context)!.infoE),
                  CustomTextContainer(
                      textContent: AppLocalizations.of(context)!.infoF),
                  CustomTextContainer(
                      textContent: AppLocalizations.of(context)!.infoG),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: CustomTextContainer(
                        textContent: AppLocalizations.of(context)!.infoH),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: CustomTextContainer(
                        textContent: AppLocalizations.of(context)!.infoI),
                  ),
                  const CustomTextContainer(
                      textContent: 'when.where.what.database727@gmail.com'),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: LaunchUrlContainer(
                      textContent: 'Ecole la Porte Privacy Policy',
                      url:
                      'https://laporte727.github.io/ecole.la.porte/chronomap.html',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}