import 'package:acorn_client/acorn_client.dart';
import 'package:flutter/material.dart';
import '../serverpod_client.dart';

class FetchTargetRepository with ChangeNotifier {
  List<Target> targetsList = [];

  Future<void> fetchAllTargets() async {
    try {
      targetsList = await client.target.getTarget();
      debugPrint('Fetched Targets: ${targetsList.length} items');
    } catch (e) {
      debugPrint('Failed to fetch targets: $e');
    }
    notifyListeners();
  }
}
