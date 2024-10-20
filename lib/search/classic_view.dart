import 'package:acorn_client/acorn_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../fetch/fetch_japanese.dart';

class ClassicViewPage extends StatefulWidget {
  final List<Principal> listPrincipal;
  final List<int>? principalIds;
  const ClassicViewPage({super.key, required this.listPrincipal, this.principalIds});

  @override
  ClassicViewPageState createState() => ClassicViewPageState();
}

class ClassicViewPageState extends State<ClassicViewPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchJapaneseNamesIfNeeded();
    });
  }

  //DB多言語化
  Future<void> fetchJapaneseNamesIfNeeded() async {
    final fetchJapaneseRepository = Provider.of<FetchJapaneseRepository>(context, listen: false);
    if (fetchJapaneseRepository.isJapaneseLanguage(context)) {
      await fetchJapaneseRepository.fetchAllJapaneseNames();
    }
  }

  @override
  Widget build(BuildContext context) {
    final fetchJapaneseRepository = Provider.of<FetchJapaneseRepository>(context);
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
                  itemCount: widget.listPrincipal.length,
                  itemBuilder: (context, index) {
                    final principalId = widget.listPrincipal[index].id;
                    return Card(
                      margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.listPrincipal[index].annee}-${widget.listPrincipal[index].month}-${widget.listPrincipal[index].day}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              fetchJapaneseRepository.isJapaneseLanguage(context)
                                  ? fetchJapaneseRepository.getJapaneseName(principalId!)
                                  : widget.listPrincipal[index].affair,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              '${widget.listPrincipal[index].location}, ${widget.listPrincipal[index].precise}',
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