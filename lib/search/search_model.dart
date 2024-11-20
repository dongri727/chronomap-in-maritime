import 'dart:convert';
import 'package:chronomap_in_maritime/fetch/fetch_principal.dart';
import 'package:chronomap_in_maritime/search/result_tab_top.dart';
import 'package:chronomap_in_maritime/utils/build_chips.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../fetch/fetch_target.dart';
import '../fetch/fetch_with_map.dart';
import '../fetch/fetch_japanese.dart';
import 'package:acorn_client/acorn_client.dart';
import '../serverpod_client.dart';

class SearchModel extends ChangeNotifier {

  late final FetchPrincipalRepository fetchPrincipalRepository;
  late final FetchWithMapRepository fetchWithMapRepository;
  late final FetchJapaneseRepository fetchJapaneseRepository;
  late final FetchTargetRepository fetchTargetRepository;

  SearchModel() {
    fetchPrincipalRepository = FetchPrincipalRepository();
    fetchWithMapRepository = FetchWithMapRepository();
    fetchJapaneseRepository = FetchJapaneseRepository();
    fetchTargetRepository = FetchTargetRepository();
  }

  List<Principal> listPrincipal = [];
  List<int> principalIds = [];
  List<WithMap> listWithMap = [];
  List<Map<String, dynamic>>? maritimeData;
  List<Map<String, dynamic>>? pacificData;
  List<dynamic>? coastLine;
  List<dynamic>? pacificLine;
  List<dynamic>? globeLine;
  List<dynamic>? ridgeLine;
  List<dynamic>? pacificRidge;
  List<dynamic>? globeRidge;
  List<dynamic>? trenchLine;
  List<dynamic>? pacificTrench;
  List<dynamic>? globeTrench;
  List<Japanese>? japaneseList;
  List<Target>? targetList;

  // 選択された id を格納する変数
  late List<int> selectedDetailIds = [];

  List<dynamic> currentTargetsList = [];

  Future<void> fetchTarget() async {
    await fetchTargetRepository.fetchAllTargets();
    currentTargetsList = fetchTargetRepository.targetsList;
    print(currentTargetsList);
    notifyListeners();
  }

  List<String> filtersTarget = <String>[];
  List<int> filtersDetailId = <int>[];
  String selectedTarget = '';
  int selectedDetailId = 0;

  Widget buildItemWidget(dynamic item) {
    return buildFilterFormatImediat(
        filteredKeys: filtersTarget,
        filteredValues: filtersDetailId,
        filterKey: item.specialite,
        filterValue: item.detailId,
        onSelected: (filterKey, filterId) {
          selectedTarget = filterKey;
          selectedDetailId = filterId;
          updateSelectedTarget(filterKey);
        });
  }

  void updateSelectedTarget(String newSelectedTarget) {
    selectedTarget = newSelectedTarget;
    notifyListeners();
  }

  void setSelectedDetailId(List<int> id) {
    selectedDetailIds = id;
    notifyListeners();
    print(selectedDetailIds);
  }

  Future<void> fetchPrincipalByDetailId({List<int>? detailIds}) async {
    try {
      listPrincipal = await client.principal.getPrincipalByDetailIds(detailIds: detailIds);
      principalIds = listPrincipal.map((item) => item.id as int).toList();
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('Failed to fetch principals: $e');
    }
  }

  Future<void> fetchMapData(List<int>? principalIds, BuildContext context) async {

    // JapaneseList を取得するリポジトリを Provider 経由でアクセス
    final fetchJapaneseRepository = Provider.of<FetchJapaneseRepository>(context, listen: false);

    // 必要ならば日本語リストを取得
    if (fetchJapaneseRepository.isJapaneseLanguage(context) && fetchJapaneseRepository.japaneseList.isEmpty) {
      await fetchJapaneseRepository.fetchAllJapaneseNames();
    }

    await fetchWithMapRepository.fetchWithMap(keyNumbers: principalIds);

    maritimeData = fetchWithMapRepository.listWithMap.map((withMap) {

      String japaneseName = fetchJapaneseRepository.getJapaneseName(withMap.principalId);
      print("Japanese name for PrincipalId ${withMap.principalId}: $japaneseName");

      return {
        "value": [withMap.longitude, withMap.latitude, withMap.logarithm],
        "name": fetchJapaneseRepository.isJapaneseLanguage(context)
            ? japaneseName
            : withMap.affair,
      };
    }).toList();

    pacificData = fetchWithMapRepository.listWithMap.map((withMap) {

      String japaneseName = fetchJapaneseRepository.getJapaneseName(withMap.principalId);
      print("Japanese name for PrincipalId ${withMap.principalId}: $japaneseName");

      return {
        "value": [shiftLongitude(withMap.longitude), withMap.latitude, withMap.logarithm],
        "name": fetchJapaneseRepository.isJapaneseLanguage(context)
            ? japaneseName
            : withMap.affair,
      };
    }).toList();

    print("Final maritimeData: $pacificData");
  }

  Future<void> fetchCoastLine() async {
    final String jsonString = await rootBundle.loadString('assets/json/coastline.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    coastLine = jsonData.map((coordinate) => [...coordinate, 0]).toList();
    globeLine = jsonData.map((dataItem) => [dataItem[0], dataItem[1], 7]).toList();
    pacificLine = jsonData.map((coordinate) {
      // Ensure that all values are converted to double
      double longitude = shiftLongitude((coordinate[0] as num).toDouble());
      double latitude = (coordinate[1] as num).toDouble();
      return [longitude, latitude, 0.0]; // Add a z-value of 0.0 for 3D compatibility
    }).toList();

    notifyListeners();
  }

  Future<void> fetchRidgeLine() async {
    final String jsonString = await rootBundle.loadString('assets/json/ridge.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    ridgeLine = jsonData.map((coordinate) => [...coordinate, 0]).toList();
    globeRidge = jsonData.map((dataItem) => [dataItem[0], dataItem[1], 7]).toList();
    pacificRidge = jsonData.map((coordinate) {
      // Ensure that all values are converted to double
      double longitude = shiftLongitude((coordinate[0] as num).toDouble());
      double latitude = (coordinate[1] as num).toDouble();
      return [longitude, latitude, 0.0]; // Add a z-value of 0.0 for 3D compatibility
    }).toList();

    notifyListeners();
  }

  Future<void> fetchTrenchLine() async {
    final String jsonString = await rootBundle.loadString('assets/json/trench.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    trenchLine = jsonData.map((coordinate) => [...coordinate, 0]).toList();
    globeTrench = jsonData.map((dataItem) => [dataItem[0], dataItem[1], 7]).toList();
    pacificTrench = jsonData.map((coordinate) {
      // Ensure that all values are converted to double
      double longitude = shiftLongitude((coordinate[0] as num).toDouble());
      double latitude = (coordinate[1] as num).toDouble();
      return [longitude, latitude, 0.0]; // Add a z-value of 0.0 for 3D compatibility
    }).toList();

    notifyListeners();
  }

  double shiftLongitude(double longitude) {
    // Shift the longitude by 205 degrees, and wrap it around using modulo 360
    double shifted = longitude + 205.0;
    if (shifted > 180.0) shifted -= 360.0;
    return shifted;
  }

  Future<void> showResult(BuildContext context, int selectedDetailId) async {
    //todo アプリが日本語バージョンを選択しており取得済みのList[Japanese]がある場合、これを受け取る。
    await fetchPrincipalByDetailId(detailIds: [selectedDetailId]);//principalを取る。
    print(listPrincipal);
    if (!context.mounted) return;
    await fetchMapData(principalIds, context); //principalに相当するMapを取り、対応する日本語を取り込む。
    //print(principalIds);
    await fetchCoastLine(); //海岸線を取る。
    await fetchRidgeLine(); //ridgeを取る
    await fetchTrenchLine(); //trenchを取る

    if (!context.mounted) return;

    Navigator.push (
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultTabTop(
                  listPrincipal: listPrincipal,
                  principalIds: principalIds,
                  maritimeData: maritimeData!,
                  pacificData: pacificData!,
                  coastLine: coastLine!,
                  pacificLine: pacificLine!,
                  globeLine: globeLine!,
                  ridgeLine: ridgeLine!,
                  pacificRidge: pacificRidge!,
                  globeRidge: globeRidge!,
                  trenchLine: trenchLine!,
                  pacificTrench: pacificTrench!,
                  globeTrench: globeTrench!)
        ));

    }
}


