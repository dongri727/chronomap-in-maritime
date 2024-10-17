import 'package:acorn_client/acorn_client.dart';
import 'package:flutter/material.dart';
import '../serverpod_client.dart';

class FetchWithMapRepository {
  List<WithMap> listWithMap = [];
  List<int> withMapIds = [];

  Future<void> fetchWithMap({List<int>? keyNumbers}) async {
    try {
      listWithMap = await client.withMap.getWithMap(keyNumbers: keyNumbers);
      withMapIds = listWithMap.map((item) => item.id as int).toList();
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }
}