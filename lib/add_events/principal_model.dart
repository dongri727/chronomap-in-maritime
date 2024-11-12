import 'package:chronomap_in_maritime/fetch/fetch_target.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:acorn_client/acorn_client.dart';
import '../fetch/fetch_place.dart';
import '../fetch/fetch_ptincipal.dart';
import '../fetch/fetch_seas.dart';
import '../lists/countries_list.dart';
import '../lists/oceans_list.dart';
import '../lists/epoch_list.dart';
import '../lists/principal_options_list.dart';
import '../lists/targets_list.dart';
import '../serverpod_client.dart';
import '../utils/build_chips.dart';
import 'principal_page.dart';
import 'dart:math' as math;

class PrincipalModel extends ChangeNotifier {

  late final FetchPrincipalRepository _fetchPrincipalRepository;
  late final FetchPlaceRepository _fetchPlaceRepository;
  //late final FetchSeasRepository _fetchSeasRepository;
  late final FetchTargetRepository _fetchTargetRepository;

  PrincipalModel() {
    _fetchPrincipalRepository = FetchPrincipalRepository();
    _fetchPlaceRepository = FetchPlaceRepository();
    //_fetchSeasRepository = FetchSeasRepository();
    _fetchTargetRepository = FetchTargetRepository();
  }

  List<Target> targets = [];

  // 選択された id を格納する変数
  int? selectedTargetId;

  //ボタンが押されたか判定
  bool showChips = false;

  void toggleShowChips() {
    showChips = !showChips;
    notifyListeners();
  }

  List<dynamic> currentTargetsList = [];

  Future<void> fetchTarget() async {
    await _fetchTargetRepository.fetchAllTargets();
    currentTargetsList = _fetchTargetRepository.targetsList;
    notifyListeners();
  }

  void setSelectedTargetId(int? id) {
    selectedTargetId = id;
    notifyListeners();
    print(selectedTargetId);
  }

  double log10(num x) => log(x) / ln10;

  var newYearD = 0.0; //変換用の年
  var newYearI = 0; //入力された年
  var newAnnee = ''; //時代を含む年
  var newMonth = 0; //入力された月
  var newDay = 0; //入力された日
  late int newPoint; //時間軸point
  late double newLogarithm; //2100年基点対数
  late double newCoefficient; //座標係数
  var newName = ''; //事象名
  var calendarNo = 0; //時代コード
  var newLatitude =0.0;
  var newLongitude =0.0;
  double cx = 0.0;
  double cy = 0.0;
  double cz = 0.0;

  int maritimeCode = 695;

  List<String> periods = epoch;
  List<String> periodsFr = epochFr;
  List<String> periodsJa = epochJa;

  List<String> ns = [
    'N',
    'S',
  ];

  nsSwitch(value) async {
    switch (selectedOption) {
      case 'N':
        newLatitude = double.tryParse(value)!;
        break;
      case 'S':
        newLatitude = -double.tryParse(value)!;
        break;
    }
  }

  List<String> ew = [
    'E',
    'W',
  ];

  ewSwitch(value) async {
    switch (selectedOption) {
      case 'E':
        newLongitude = double.tryParse(value)!;
        break;
      case 'W':
        newLongitude = -double.tryParse(value)!;
        break;
    }
  }

  ///Pays
  List<Map<String, dynamic>> pays = countries;
  ///Oceans
  List<String> oceans = mer;

  List<dynamic> currentDisplayList = [];

  String? selectedOption = '';

  List<String> principalOption = principalOptions;
  List<String> principalOptionFr = principalOptionsFr;
  List<String> principalOptionJa = principalOptionsJp;

  List<String> preciseOption = preciseOptions;
  List<String> preciseOptionFr = preciseOptionsFr;
  List<String> preciseOptionJa = preciseOptionsJp;

  String location = "";
  String precise = "";

  var newLocation = '';
  final List<String> filtersLocation = <String>[];
  final List<int> filtersLocationId = <int>[];

  String chosenLocation ='';

  var newPrecise = '';
  final List<String> filtersPrecise = <String>[];
  final List<int> filtersPreciseId = <int>[];

  String chosenPrecise ='';

  var newPlace = '';
  final List<String> filtersPlaces= <String>[];
  final List<int> filtersPlacesId = <int>[];
  String chosenPlace = '';

  void updateLocation(String newLocation) {
    location = newLocation;
    notifyListeners();
  }

  void updatePrecise(String newPrecise) {
    precise = newPrecise;
    notifyListeners();
  }

  void updateCurrentDisplayList(dynamic newCurrentDisplayList) {
    currentDisplayList = newCurrentDisplayList;
    notifyListeners();
  }

/*  Future<void> fetchSeas(location) async {
    await _fetchSeasRepository.fetchSeas(location);
    currentDisplayList = _fetchSeasRepository.listSeas;
    notifyListeners();
  }*/

  ///RadioButtonの選択に応じてlocationの候補を取得する
  Future<void> listRadioButtonBasis(selectedOption) async {
    switch (selectedOption) {
      case 'Current Country-name':
      case 'Nom actuel du pays':
      case '現在の国名':
        currentDisplayList = pays.map((country) => country['name'] as String).toList();
        break;
      case 'Ocean-name':
      case 'Nom de l\'océan':
      case '海洋名':
        currentDisplayList = oceans;
        break;
    }
    notifyListeners();
  }

  // Method to clear the country/ocean name and replace with city/sea name chips
  Future<void> replaceLocationWithPrecise() async {
    currentDisplayList = [];// Clear currentDisplayList (country/ocean)
    await fetchRadioButtonBasisForPrecise(selectedOption);// Fetch and set the city or sea name options based on the selectedOption
    notifyListeners(); // Update the UI
  }

  ///RadioButtonの選択にかかわらず統合preciseの候補を取得する
  Future<void> fetchRadioButtonBasisForPrecise(selectedOption) async {
    await _fetchPlaceRepository.fetchPlaces(location);
    currentDisplayList = _fetchPlaceRepository.listPlaces
        .map((placeItem) => placeItem.place)
        .toList();
/*    switch (selectedOption) {
      case 'Current Place-name':
      case 'Nom actuel du lieu':
      case '現在の地名':
        await _fetchPlaceRepository.fetchPlaces(location);
        currentDisplayList = _fetchPlaceRepository.listPlaces
        .map((placeItem) => placeItem.place)
        .toList();
        break;
      case 'Sea-name':
      case 'Nom de la mer':
      case '海域名':
        await _fetchSeasRepository.fetchSeas(location);
        currentDisplayList = _fetchSeasRepository.listSeas
        .map((seaItem) => seaItem.sea)
        .toList();
        break;
    }*/
    notifyListeners();
  }

  //ChipでLocationを表示
  Widget buildItemWidget(dynamic item) {
    return buildChoiceSIFormat(
        choiceSIList: filtersLocation,
        choiceSIKey: item,
        onChoiceSISelected: (choiceSIKey) {
          chosenLocation = choiceSIKey;
        }
    );
  }

  //ChipでPreciseを表示
  Widget buildItemWidgetPrecise(dynamic item) {
    return buildChoiceSIFormat(
        choiceSIList: filtersPrecise,
        choiceSIKey: item,
        onChoiceSISelected: (choiceSIKey) {
          chosenPrecise = choiceSIKey;
        }
    );
  }

  //選択されたLocationを表示
  void setChosenLocation(String location) {
    chosenLocation = location;
    notifyListeners();
  }

  //選択されたPreciseを表示
  void setChosenPrecise(String precise) {
    chosenPrecise = precise;
    notifyListeners();
  }

  Future<void> addAndFetchRadioButtonBasis(selectedOption) async {
    //placeとseasを統合する
    await _fetchPlaceRepository.addPlacesAndFetch(newPlace, location);
    currentDisplayList = _fetchPlaceRepository.listPlaces
        .map((placeItem) => placeItem.place)
        .toList();
/*    switch (selectedOption) {
    //keyCountryが取得されているので、国名付きで保存される。
      case 'Current Place-name':
      case 'Nom actuel du lieu':
      case '現在の地名':
        await _fetchPlaceRepository.addPlacesAndFetch(newPlace, location);
        currentDisplayList = _fetchPlaceRepository.listPlaces
            .map((placeItem) => placeItem.place)
            .toList();
        break;
      case 'Sea-name':
      case 'Nom de la mer':
      case '海域名':
*//*        await _fetchSeasRepository.addSeasAndFetch(newSea, location);
        currentDisplayList = _fetchSeasRepository.listSeas
          .map((seaItem) => seaItem.sea)
          .toList();*//*
        await _fetchPlaceRepository.addPlacesAndFetch(newPlace, location);
        currentDisplayList = _fetchPlaceRepository.listPlaces
            .map((placeItem) => placeItem.place)
            .toList();

        break;
    }*/
    notifyListeners();
  }

  //WHATを記入
  setNewName(text) {
    newName = text;
    notifyListeners();
  }

  //記入された地名・海域名を取得
  setNewPlace(text) {
    newPlace = text;
    notifyListeners();
  }

  //WHENを記入
  String selectedCalendar = 'Common-Era';

  void setCalendar(String? value) {
    if (value != null) {
      //selectedCalendar = value;
      switch (value) {
        case 'Billion Years':
        case "Milliards d'années":
        case '〜十億年前':
          selectedCalendar = 'Billion Years';
          break;
        case 'Million Years':
        case "Millions d'années":
        case '〜百万年前':
          selectedCalendar = 'Million Years';
          break;
        case 'Thousand Years':
        case "Milliers d'années":
        case '千年単位':
          selectedCalendar = 'Thousand Years';
          break;
        case 'Years by Dating Methods':
        case "Années par méthodes de datation":
        case '炭素年代測定':
          selectedCalendar = 'Years by Dating Methods';
          break;
        case 'Before-CommonEra':
        case "Avant l'ère commune":
        case '紀元前':
          selectedCalendar = 'Before-CommonEra';
          break;
        case 'Common-Era':
        case "Ère commune":
        case '西暦':
          selectedCalendar = 'Common-Era';
          break;
      }
    }
    notifyListeners();
  }

  setNewYearD(value) {
    newYearD = double.parse(value);
    notifyListeners();
  }

  setNewMonth(value) {
    try {
      newMonth = int.parse(value);
    } catch (e) {
      newMonth = 0;
    }
    notifyListeners();
  }

  setNewDay(value) {
    try {
      newDay = int.parse(value);
    } catch (e) {
      newDay = 0;
    }
    notifyListeners();
  }

  /// convert the years depending on the selected calendar period
  void convertPoint() {
    switch (selectedCalendar) {
      case 'Billion Years':
      case "Milliards d'années":
      case '〜十億年前':
        newYearI = (newYearD * 1000000000).round();
        newYearI = -newYearI.abs();
        break;
      case 'Million Years':
      case "Millions d'années":
      case '〜百万年前':
        newYearI = (newYearD * 1000000).round();
        newYearI = -newYearI.abs();
        break;
      case 'Thousand Years':
      case "Milliers d'années":
      case '千年単位':
        newYearI = (newYearD * 1000).round();
        newYearI = -newYearI.abs();
        break;
      case 'Years by Dating Methods':
      case "Années par méthodes de datation":
      case '炭素年代測定':
        newYearI = (2000 - newYearD).round();
        break;
      case 'Before-CommonEra':
      case "Avant l'ère commune":
      case '紀元前':
        newYearI = (newYearD).round();
        newYearI = -newYearI.abs();
        break;
      case 'Common-Era':
      case "Ère commune":
      case '西暦':
        newYearI = (newYearD).round();
        break;
    }

    ///make data of point
    newPoint =
        (((newYearI - 1) * 366 + (newMonth - 1) * 30.5 + newDay)
            .toDouble())
            .round();

    ///make data of logarithm
    newLogarithm = double.parse(
        (5885.0 - (1000 * (log10((newPoint - 768600).abs()))))
            .toStringAsFixed(4));

    ///make data of reverseLogarithm
    newCoefficient = 6820.0 + newLogarithm;

    double ns = (math.pi * newLatitude) / 180;
    double ew = (math.pi * newLongitude) / 180;
    cx = math.cos(ns) * math.cos(ew) * newCoefficient;
    cy = math.sin(ns) * newCoefficient;
    cz = math.cos(ns) * math.sin(ew) * newCoefficient;

    switch (selectedCalendar) {
      case 'Billion Years':
        newAnnee = '${newYearD}B years ago';
        break;
      case 'Million Years':
        newAnnee = '${newYearD}M years ago';
        break;
      case 'Thousand Years':
        newAnnee = '${newYearD}K years ago';
        break;
      case 'Years by Dating Methods':
        newAnnee = 'about $newYearD years ago';
        break;
      case 'Before-CommonEra':
        newAnnee = 'BCE ${(newYearD).round()}';
        break;
      case 'Common-Era':
        newAnnee = 'CE ${(newYearD).round()}';
        break;
    }
  }

  Future<int> save() async {
    if (newYearI != 0 && newName != "") {
      try {
        var principal = Principal(
          period: selectedCalendar,
          annee: newAnnee,
          month: newMonth,
          day: newDay,
          point: newPoint,
          affair: newName,
          location: location,
          precise: precise,
        );
        var principalId = await client.principal.addPrincipal(principal);

        //principal-detail
        if (selectedTargetId != null) {
          try {
            var pDetailTerms = PrincipalDetail(principalId: principalId, detailId: selectedTargetId!);
            await client.principalDetail.addPDetail(pDetailTerms);
          } catch (e) {
            print('Error adding PrincipalDetail: $e');
          }
        } else {
          print('selectedTargetId is null');
        }

/*        var pDetailCategory = PrincipalDetail(
            principalId: principalId, detailId: maritimeCode);
        await client.principalDetail.addPDetail(pDetailCategory);*/

        //with Map
        var withMap = WithMap(
            principalId: principalId,
            annee: newAnnee,
            affair: newName,
            location: location,
            precise: precise,
            latitude: newLatitude,
            longitude: newLongitude,
            logarithm: newLogarithm);
        await client.withMap.addWithMap(withMap);

        //with Globe
        var withGlobe = WithGlobe(
            principalId: principalId,
            annee: newAnnee,
            affair: newName,
            location: location,
            precise: precise,
            xCoordinate: double.parse((cx).toStringAsFixed(4)),
            yCoordinate: double.parse((cy).toStringAsFixed(4)),
            zCoordinate: double.parse((cz).toStringAsFixed(4)),
            coefficient: newCoefficient);
        await client.withGlobe.addWithGlobe(withGlobe);

        return 0;
      } catch (e) {
        return 1;
      }
    } else {
      return 2;
    }
  }

  void showCustomDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            GestureDetector(
              child: const Text('OK'),
              onTap: () {
                Navigator.push<String>(
                  context,
                  MaterialPageRoute(builder: (context) => const PrincipalPage()),
                ); // ダイアログを閉じる
              },
            ),
          ],
        );
      },
    );
  }
}