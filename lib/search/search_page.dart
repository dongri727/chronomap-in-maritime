import 'package:chronomap_in_maritime/search/search_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/shadowed_container.dart';
import '../utils/tff_format.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<SearchModel>(
      create: (_) => SearchModel(),
      child: Consumer<SearchModel>(
        builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.searchA),
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: HintText(
                        hintText: AppLocalizations.of(context)!.searchB,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: HintText(hintText: 'Select your tag(s)'),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      child: ShadowedContainer(
                          child: OutlinedButton(
                            onPressed: () async {
                              model.fetchTarget();
                            },
                            child: const Text('Show Tags')
                          )),
                    ),
                    Wrap(
                      spacing: 8.0,
                      children: model.currentTargetsList.map<Widget>((item) {
                        return model.buildItemWidget(item);
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.extended(
                label: const Text('Show Result'),
                onPressed: () {
                  model.showResult(context, model.selectedDetailId);
                },
            ),
          ),
        );
      }),
    );
  }
}
