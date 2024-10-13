import 'package:acorn_client/acorn_client.dart';
import 'package:flutter/material.dart';
import '../serverpod_client.dart';

class FetchSeasRepository {

  List<Seas> listSeas = [];

  ///fetch stars in stars with area
  fetchSeas(keyArea) async {
    try{
      listSeas = await client.seas.getSeas(keyword: keyArea);
    } catch (e) {
      debugPrint('$e');
    }
  }
//以下の関数はまだdeployできていない
/*  ///adds a sea with keyArea into table Seas
  ///and at same time adds and get seas without keyArea into table Detail.
  addSeasAndFetch(String newSea, String keyArea) async {
    try {
      var seas = Seas(sea: newSea, area: keyArea);
      var keyword = keyArea;
      listSeas =
      await client.seas.addAndReturnSeasWithKeyArea(seas, keyword);
    } catch (e) {
      debugPrint('$e');
    }
  }*/
}