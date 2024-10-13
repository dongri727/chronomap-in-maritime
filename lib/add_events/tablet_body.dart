import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../hints/add_hint_page.dart';
import '../index.dart';
import '../utils/blank_text_format.dart';
import '../utils/button_format.dart';
import '../utils/choice_si_format.dart';
import '../utils/dropdown_button_format.dart';
import '../utils/format_grey.dart';
import '../utils/navi_button.dart';
import '../utils/shadowed_container.dart';
import '../utils/tff_format.dart';
import 'principal_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TabletBody extends StatelessWidget {
  const TabletBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PrincipalModel>(
      create: (_) => PrincipalModel(),
      child: Consumer<PrincipalModel>(
        builder: (_, model, child) {
          String locale = Localizations.localeOf(context).languageCode;

          List<String> optionsP;
          switch (locale) {
            case 'fr':
              optionsP = model.periodsFr;
              break;
            case 'ja':
              optionsP = model.periodsJa;
              break;
            default:
              optionsP = model.periods;
          }

          List<String> optionsL;
          switch (locale) {
            case 'fr':
              optionsL = model.principalOptionFr;
              break;
            case 'ja':
              optionsL = model.principalOptionJa;
              break;
            default:
              optionsL = model.principalOption;
          }

          List<String> optionsO;
          switch (locale) {
            case 'fr':
              optionsO = model.preciseOptionFr;
              break;
            case 'ja':
              optionsO = model.preciseOptionJa;
              break;
            default:
              optionsO = model.preciseOption;
          }
          return Scaffold(
            appBar: AppBar(
              leading: const NavigationButton(
                  destinationPage: IndexPage(),
                  buttonText: 'INDEX'),
              leadingWidth: 100,
              title: Text(AppLocalizations.of(context)!.indexA),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddHintPage()));
                    },
                    icon: const Icon(
                      Icons.question_mark,
                      color: Colors.blue,
                    ))
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                  model.convertPoint();
                  int result = await model.save();
                  String title;
                  String content;

                  switch (result) {
                    case 0:
                      title = 'Succeeded';
                      content = 'Thank you for adding Information';
                      break;
                    case 1:
                      title = 'Failed';
                      content = 'Oops! Something went wrong...';
                      break;
                    case 2:
                      title = 'Failed';
                      content = 'Required fields are missing';
                      break;
                    default:
                      title = 'Unexpected Error';
                      content = 'Please try again later';
                      break;
                  }

                  if (!context.mounted) return;

                  model.showCustomDialog(context, title, content);
                },
                label: const Text('SAVE')),
            body: Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/sea.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                                child: Text(
                                  'WHAT',
                                  style: TextStyle(
                                    fontSize: 24,
                                      color: Colors.white
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TffFormat(
                                  hintText: AppLocalizations.of(context)!.name,
                                  onChanged: (text) {
                                    model.setNewName(text);
                                  },
                                  tffColor1: const Color(0xFF2f4f4f),
                                  tffColor2: const Color(0x99e6e6fa),
                                ),
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                                child: Text(
                                  'WHEN',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: ShadowedContainer(
                                          child: CustomDropdownButton(
                                            selectedValue:
                                            model.selectedCalendar,
                                            options: optionsP,
                                            onChanged: (value) {
                                              model.setCalendar(value);
                                            },
                                          ),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TffFormat(
                                          hintText: 'year',
                                          onChanged: (value) {
                                            model.setNewYearD(value);
                                          },
                                          tffColor1: Colors.black54,
                                          tffColor2: const Color(0x99e6e6fa),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TffFormat(
                                          hintText: 'Month 1-12 or 0',
                                          onChanged: (value) {
                                            model.setNewMonth(value);
                                          },
                                          tffColor1: Colors.black54,
                                          tffColor2: const Color(0x99e6e6fa),
                                        ),
                                      )),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 8, 20, 8),
                                        child: TffFormat(
                                          hintText: 'Date 1-31 or 0',
                                          onChanged: (value) {
                                            model.setNewDay(value);
                                          },
                                          tffColor1: Colors.black54,
                                          tffColor2: const Color(0x99e6e6fa),
                                        )),
                                  )
                                ],
                              ))
                        ],
                      ),
                      Row(children: [
                        const Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                              child: Text(
                                'WHERE',
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: ShadowedContainer(
                                            child: RadioButtonFormat(
                                              options: optionsL,
                                              onChanged: (String? value) {
                                                model.selectedOption = value;
                                              },
                                            ),
                                          ),
                                        )),
                                    //Location
                                    Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ShadowedContainer(
                                            child: ButtonFormat(
                                              label: AppLocalizations.of(context)!
                                                  .showOptions,
                                              onPressed: () async {
                                                await model.listRadioButtonBasis(model.selectedOption);
                                              },
                                            ),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: BlankTextFormat(
                                          text: model.location,
                                        )),
                                  ],
                                ),
                                //Precise
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: ShadowedContainer(
                                            child: RadioButtonFormat(
                                              options: optionsO,
                                              onChanged: (String? value) {
                                                model.selectedOption = value;
                                              },
                                            ),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ShadowedContainer(
                                            child: ButtonFormat(
                                              label: AppLocalizations.of(context)!
                                                  .showOptions,
                                              onPressed: () async {
                                                await model.replaceLocationWithPrecise();
                                              },
                                            ),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: BlankTextFormat(
                                          text: model.precise,
                                        )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FormatGrey(
                                          controller: model.seaController,
                                          hintText:
                                          AppLocalizations.of(context)!
                                              .newWord,
                                          onChanged: (text) {
                                            model.setNewPrecise(text);
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 8, 20, 8),
                                        child: ShadowedContainer(
                                          child: ButtonFormat(
                                            label: AppLocalizations.of(context)!
                                                .addWord,
                                            onPressed: () async {
                                              model.addAndFetchRadioButtonBasis(model.selectedOption);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 50, 20, 20),
                                    child: ShadowedContainer(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(AppLocalizations.of(context)!
                                              .ifYouMayKnow),
                                        ))),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.fromLTRB(20, 8, 20, 8),
                                            child: ShadowedContainer(
                                              child: RadioButtonRowFormat(
                                                  options: model.ns,
                                                  onChanged: (String? value) {
                                                    model.selectedOption = value!;
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TffFormat(
                                              hintText: 'latitude',
                                              onChanged: (value) {
                                                model.nsSwitch(value);
                                              },
                                              tffColor1: Colors.black54,
                                              tffColor2: const Color(0x99e6e6fa),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.fromLTRB(20, 8, 20, 8),
                                            child: ShadowedContainer(
                                              child: RadioButtonRowFormat(
                                                  options: model.ew,
                                                  onChanged: (String? value) {
                                                    model.selectedOption = value!;
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TffFormat(
                                              hintText: 'longitude',
                                              onChanged: (value) {
                                                model.ewSwitch(value);
                                              },
                                              tffColor1: Colors.black54,
                                              tffColor2: const Color(0x99e6e6fa),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ))
                      ]),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 5.0,
                          children: model.currentDisplayList.map((item) {
                            return ChoiceSIFormat(
                              // 国名・海洋名を表示する場合
                                choiceSIList: model.selectedOption == 'Current Country-name' ||
                                    model.selectedOption == 'Nom actuel du pays' ||
                                    model.selectedOption == '現在の国名' ||
                                    model.selectedOption == 'Ocean-name' ||
                                    model.selectedOption == 'Nom de l\'océan' ||
                                    model.selectedOption == '海洋名'
                                    ? model.filtersLocation // 国名・海洋名を表示
                                    : model.filtersSeas,    // 地名・海域名を表示
                                choiceSIKey: item,
                                onChoiceSISelected: (choiceSIKey) {
                                  // 選択された要素に基づき更新処理
                                  if (model.selectedOption == 'Current Country-name' ||
                                      model.selectedOption == 'Nom actuel du pays' ||
                                      model.selectedOption == '現在の国名' ||
                                      model.selectedOption == 'Ocean-name' ||
                                      model.selectedOption == 'Nom de l\'océan' ||
                                      model.selectedOption == '海洋名') {
                                    // 国名・海洋名の場合
                                    model.chosenLocation = choiceSIKey;
                                    model.updateLocation(choiceSIKey);
                                  } else {
                                    // 地名・海域名の場合
                                    model.chosenSea = choiceSIKey;
                                    model.updatePrecise(choiceSIKey);
                                  }
                                });
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}