import 'package:acorn_client/acorn_client.dart';
//import 'package:chronomap_in_maritime/search/search_model.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

class ClassicViewPage extends StatelessWidget {
  final List<Principal> listPrincipal;
  final List<int>? principalIds;
  final List<Map<String, dynamic>>? maritimeData;
  const ClassicViewPage({super.key, required this.listPrincipal, this.principalIds, this.maritimeData});

  @override
  Widget build(BuildContext context) {
    //final searchModel = Provider.of<SearchModel>(context);
    return Scaffold(
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
              const SizedBox(height: 20),
              // 取得されたListをListTileとして表示
              Expanded(
                child: ListView.builder(
                  itemCount: listPrincipal.length,
                  itemBuilder: (context, index) {
                    //final principalId = listPrincipal[index].id;
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
                            Text(
                                maritimeData != null && index < maritimeData!.length
                                    ? maritimeData![index]['name'] ?? 'N/A'  // maritimeDataがnullでないことと、インデックスが範囲内であることを確認
                                    : 'N/A'  // 安全なデフォルト値
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
        ),
      ),
    );
  }
}