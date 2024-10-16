import 'package:acorn_client/acorn_client.dart';
import 'package:chronomap_in_maritime/fetch/fetch_ptincipal.dart';
import 'package:flutter/material.dart';
import '../lists/targets_list.dart';

class SearchModel extends ChangeNotifier {
  late final FetchPrincipalRepository _fetchPrincipalRepository;

  SearchModel() {
    _fetchPrincipalRepository = FetchPrincipalRepository();
  }

  //Chipで表示するもの
  List<Map<String, dynamic>> items = targets;
  List<String> currentChipsDisplayList = [];

  //Chipで選ばれたもの
  String selectedTargets = '';
  int selectedIds = 0;

  //検索結果
  List<Principal> listPrincipal = [];
  List<int> principalIds = [];

  List<int> maritimeCode = [695];

  void updateSelectedIds(int newSelectedIds) {
    selectedIds = newSelectedIds;
    notifyListeners();
    print(selectedIds);
  }
}