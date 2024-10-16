import 'package:acorn_client/acorn_client.dart';
import 'package:chronomap_in_maritime/lists/targets_list.dart';
import 'package:flutter/material.dart';

import '../serverpod_client.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  // リストデータの例 (id と name)
  final List<Map<String, dynamic>> items = targets;

  // 選択された id を格納する変数
  int? selectedId;
  List<Principal> listPrincipal = [];
  List<int> principalIds = [];

  Future<void> fetchPrincipalByDetailId({List<int>? detailIds}) async {
    try {
      listPrincipal =
      await client.principal.getPrincipalByDetailIds(detailIds: detailIds);
      principalIds = listPrincipal.map((item) => item.id as int).toList();
      setState(() {
        listPrincipal = listPrincipal;
      });
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }


  @override
  void initState() {
    super.initState();
    // アルファベット順に並び替える
    items.sort((a, b) => a['name'].compareTo(b['name']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Item'),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sea.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Chip をリストから生成
              Wrap(
                spacing: 8.0,
                children: items.map((item) {
                  return ChoiceChip(
                    label: Text(item['name']),
                    selected: selectedId == item['id'],
                    onSelected: (bool isSelected) async {
                      setState(() {
                        selectedId = isSelected ? item['id'] : null;
                      });

                      print(selectedId);

                      // Chipが選択されたらfetchPrincipalByDetailIdを呼び出す
                      if (selectedId != null) {
                        await fetchPrincipalByDetailId(detailIds: [selectedId!]);
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              // 取得されたListをListTileとして表示
              Expanded(
                child: ListView.builder(
                  itemCount: listPrincipal.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Card(
                        color: const Color(0xFFe6e6fa),
                        child: ListTile(
                          leading: Text(
                            '${listPrincipal[index].annee}-${listPrincipal[index].month}-${listPrincipal[index].day}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          title: Text(
                            listPrincipal[index].affair,
                            style: const TextStyle(fontSize: 24),
                          ),
                          trailing: Text(
                            '${listPrincipal[index].location}, ${listPrincipal[index].precise}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    );
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
