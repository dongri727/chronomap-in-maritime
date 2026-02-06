import 'package:acorn_client/acorn_client.dart';
import 'package:flutter/material.dart';
import '../serverpod_client.dart';

class FetchWithMapRepository {
  List<WithMap> listWithMap = [];
  List<int> withMapIds = [];

  // Serverpod側の endpoint 仕様変更で limit が必須になったため追加
  Future<List<WithMap>> fetchWithMap({
    List<int>? keyNumbers,
    int limit = 3000,
  }) async {
    try {
      // データ取得
      listWithMap = await client.withMap.getWithMap(
        keyNumbers: keyNumbers,
        limit: limit,
      );
      withMapIds = listWithMap
          .where((item) => item.id != null)
          .map((item) => item.id!)
          .toList();
      return listWithMap; // 取得したデータを返す
    } on Exception catch (e) {
      debugPrint('fetchWithMap failed: $e');
      return []; // エラー時には空のリストを返す
    }
  }
}