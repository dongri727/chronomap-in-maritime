import 'dart:convert';
import 'package:chronomap_in_maritime/fetch/fetch_ptincipal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../fetch/fetch_with_map.dart';
import '../fetch/fetch_japanese.dart';
import 'package:acorn_client/acorn_client.dart';
import '../serverpod_client.dart';

class SearchModel with ChangeNotifier {

  late final FetchPrincipalRepository fetchPrincipalRepository;
  late final FetchWithMapRepository fetchWithMapRepository;
  late final FetchJapaneseRepository fetchJapaneseRepository;

  SearchModel() {
    fetchPrincipalRepository = FetchPrincipalRepository();
    fetchWithMapRepository = FetchWithMapRepository();
    fetchJapaneseRepository = FetchJapaneseRepository();
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


  Future<void> fetchPrincipalByDetailId({List<int>? detailIds}) async {
    try {
      listPrincipal = await client.principal.getPrincipalByDetailIds(detailIds: detailIds);
      principalIds = listPrincipal.map((item) => item.id as int).toList();
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('Failed to fetch principals: $e');
    }
  }

  //DB多言語化
  Future<void> fetchJapaneseNamesIfNeeded(BuildContext context) async {
    final fetchJapaneseRepository = Provider.of<FetchJapaneseRepository>(context, listen: false);
    if (fetchJapaneseRepository.isJapaneseLanguage(context)) {
      await fetchJapaneseRepository.fetchAllJapaneseNames();
      notifyListeners();
    }
  }

  Future<void> fetchMapData(List<int>? principalIds, BuildContext context) async {
    //print("Principal IDs before fetchWithMap: $principalIds");

    await fetchJapaneseNamesIfNeeded(context);
    await fetchWithMapRepository.fetchWithMap(keyNumbers: principalIds);

    //print("Fetched listWithMap: ${fetchWithMapRepository.listWithMap}");

    maritimeData = fetchWithMapRepository.listWithMap.map((withMap) {
      //print("WithMap PrincipalId: ${withMap.principalId}");

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
      //print("WithMap PrincipalId: ${withMap.principalId}");

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

}

