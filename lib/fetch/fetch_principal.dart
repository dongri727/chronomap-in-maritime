import 'package:acorn_client/acorn_client.dart';
import 'package:flutter/material.dart';
import '../serverpod_client.dart';

class FetchPrincipalRepository {
  List<Principal> listPrincipal = [];
  List<int> principalIds = [];

  Future<void> fetchPrincipal() async {
    try {
      listPrincipal = await client.principal.getPrincipal();
      principalIds = listPrincipal.map((item) => item.id as int).toList();
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> fetchPrincipalByLocation({List<String>? location}) async {
    try {
      listPrincipal = await client.principal.getPrincipal(keywords: location);
      principalIds = listPrincipal.map((item) => item.id as int).toList();
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> fetchPrincipalByDetailId({List<int>? detailIds}) async {
    try {
      listPrincipal =
      await client.principal.getPrincipalByDetailIds(detailIds: detailIds);
      principalIds = listPrincipal.map((item) => item.id as int).toList();
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }
}