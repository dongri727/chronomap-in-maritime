import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../utils/discribe_card.dart';

class AddHintPage extends StatelessWidget {
  const AddHintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hints'),
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/sea.png'),
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
                        textContent: AppLocalizations.of(context)!.addHintA),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: CustomTextContainer(
                        textContent: AppLocalizations.of(context)!.addHintB),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: CustomTextContainer(
                        textContent: AppLocalizations.of(context)!.addHintC),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: CustomTextContainer(
                        textContent: AppLocalizations.of(context)!.addHintD),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: CustomTextContainer(
                        textContent: AppLocalizations.of(context)!.addHintE),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: CustomTextContainer(
                        textContent: AppLocalizations.of(context)!.addHintF),
                  ),

                ],
              ),
            ),
          ),
        ));
  }
}