import 'package:chronomap_in_maritime/lists/targets_list.dart';
import 'package:chronomap_in_maritime/search/result_tab_top.dart';
import 'package:chronomap_in_maritime/search/search_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/tff_format.dart';
import '../utils/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final List<Map<String, dynamic>> items = targets;

  // 選択された id を格納する変数
  int? selectedTargetId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchModel = Provider.of<SearchModel>(context, listen: false);
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
                // Chip をリストから生成
                Wrap(
                  spacing: 8.0,
                  children: targets.map((item) {
                    return ChoiceChip(
                      label: Text(item['name']),
                      selected: selectedTargetId == item['id'],
                      onSelected: (bool isSelected) async {
                        setState(() {
                          selectedTargetId = isSelected ? item['id'] : null;
                        });
          
                        // Chipが選択されたら全ての関数を走らせて一括で結果を取る
                        if (selectedTargetId != null) {
                          //todo アプリが日本語バージョンを選択しており取得済みのList[Japanese]がある場合、これを受け取る。
                          await searchModel.fetchPrincipalByDetailId(detailIds: [selectedTargetId!]);//principalを取る。
          
                          if (!context.mounted) return;
                          await searchModel.fetchMapData(searchModel.principalIds, context); //principalに相当するMapを取り、対応する日本語を取り込む。
                          print(searchModel.principalIds);
          
                          await searchModel.fetchCoastLine(); //海岸線を取る。
                          await searchModel.fetchRidgeLine(); //ridgeを取る
                          await searchModel.fetchTrenchLine(); //trenchを取る
                        }
                      },
                    );
                  }).toList(),
                ),
          
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: OutlinedButton(
                    child: Text(AppLocalizations.of(context)!.searchC,
                      style: MaritimeTheme.textTheme.headlineMedium,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultTabTop(
                                listPrincipal: searchModel.listPrincipal,
                                principalIds: searchModel.principalIds,
                                maritimeData: searchModel.maritimeData!,
                                pacificData: searchModel.pacificData!,
                                coastLine: searchModel.coastLine!,
                                pacificLine: searchModel.pacificLine!,
                                globeLine: searchModel.globeLine!,
                                ridgeLine: searchModel.ridgeLine!,
                                pacificRidge: searchModel.pacificRidge!,
                                globeRidge: searchModel.globeRidge!,
                                trenchLine: searchModel.trenchLine!,
                                pacificTrench: searchModel.pacificTrench!,
                                globeTrench: searchModel.globeTrench!,
                              )));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
