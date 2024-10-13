import 'package:chronomap_in_maritime/fetch/fetch_ptincipal.dart';
import 'package:chronomap_in_maritime/utils/autocomplete_clear.dart';
import 'package:flutter/material.dart';
import 'package:acorn_client/acorn_client.dart';
import 'package:provider/provider.dart';
import 'data_repository.dart';
import 'lists/targets_list.dart';
import 'serverpod_client.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClassicPage extends StatefulWidget {
  const ClassicPage({super.key});

  @override
  State<ClassicPage> createState() => ClassicPageState();
}

class ClassicPageState extends State<ClassicPage> {
  List<Principal> listPrincipal = [];
  List<int> principalIds = [];
  TextEditingController searchController =
  TextEditingController(); // 検索キーワードを入力するためのController

  final FetchPrincipalRepository fetchPrincipalRepository = FetchPrincipalRepository();
  List<int> maritimeCode = [695];

  @override
  void initState() {
    super.initState();
    getOptions();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchJapaneseNamesIfNeeded();
    });
  }

/*  Future<void> fetchPrincipalByLocation(String keywords) async {
    try {
      // 文字列をリストに変換してkeywords引数を渡す
      List<String> location = keywords.split(',').map((e) => e.trim()).toList();
      listPrincipal = await client.principal.getPrincipal(keywords: location);
      principalIds = listPrincipal.map((item) => item.id as int).toList();
      setState(() {}); // データの更新をUIに反映させる
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }*/

  List<String> options = [];
  void getOptions() {
    for (var target in targets) {
      options.add(target['name']);
    }
  }

  //DB多言語化
  Future<void> fetchJapaneseNamesIfNeeded() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    if (dataRepository.isJapaneseLanguage(context)) {
      await dataRepository.fetchAllJapaneseNames();
    }
  }

  void resetSearch() {
    setState(() {
      searchController.clear();
      listPrincipal = [];
      principalIds = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataRepository = Provider.of<DataRepository>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('CLASSIC'),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0,right: 20.0),
              child: Column(
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.question_mark,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Search Hint'),
                                content: Text(AppLocalizations.of(context)!.search),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('close'))
                                ],
                              );
                            });
                      }
                  ),
                  AutocompleteWithClear(
                    options: options,
                    searchController: searchController,
                    onSearch: () {
                      fetchPrincipalRepository.fetchPrincipalByDetailId(detailIds: maritimeCode);
                    },
                    onPressed: resetSearch,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            // ListView.builderをExpandedで囲むことで、利用可能なスペースを埋めます
            child: ListView.builder(
              itemCount: listPrincipal.length,
              itemBuilder: (context, index) {
                final principalId = listPrincipal[index].id;
                return Card(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${listPrincipal[index].annee}-${listPrincipal[index].month}-${listPrincipal[index].day}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        SelectableText(
                          dataRepository.isJapaneseLanguage(context)
                              ? dataRepository.getJapaneseName(principalId!)
                              : listPrincipal[index].affair,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          '${listPrincipal[index].location}, ${listPrincipal[index].precise}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}