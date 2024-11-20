import 'package:acorn_client/acorn_client.dart';
import 'package:flutter/material.dart';
import '../serverpod_client.dart';

class FetchTargetRepository {
  List<Target> targetsList = [];
  late int detailId;

  Future<void> fetchAllTargets() async {
    try {
      targetsList = await client.target.getTarget();
      debugPrint('Fetched Targets: ${targetsList.length} items');
    } catch (e) {
      debugPrint('Failed to fetch targets: $e');
    }
  }

  ///detailに保存してidを取得する
  Future<int> addTargetToDetail(String genre, String newTarget) async {
    try {
      var detailTarget = Detail(genre: genre, mot: newTarget);
      detailId = await client.detail.addDetail(detailTarget);
      return detailId;
    } catch (e) {
      return 0;
      debugPrint('$e');
    }
  }

  ///detailIdを使って、targetに保存する
  addTargetAndFetch(String newTarget, int detailId) async {
    try {
      var target = Target(specialite: newTarget, detailId: detailId);
      targetsList = await client.target.addAndReturnTarget(target);
    } catch (e) {
      debugPrint('$e');
    }
  }
}
