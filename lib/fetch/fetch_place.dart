import 'package:acorn_client/acorn_client.dart';
import 'package:flutter/material.dart';
import '../serverpod_client.dart';

class FetchPlaceRepository{
  List<Places> listPlaces = [];
  List<Detail> listDetailPlaces = [];

  ///Gets places from table Place with key Country
  fetchPlaces(keyCountry) async {
    try {
      listPlaces = await client.places.getPlaces(keyword: keyCountry);
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }

  ///Adds a place with keyCountry into table Place
  ///and at same time adds a place without keyCountry into table Detail
  addPlacesAndFetch(String newPlace, String keyCountry) async {
    try {
      var places = Places(place: newPlace, country: keyCountry);
      var keyword = keyCountry;
      var detail = Detail(genre: 'places_involved', mot: newPlace);
      listPlaces =
      await client.places.addAndReturnPlacesWithKeyCountry(places, keyword);
      await client.detail.addDetail(detail);
    } catch (e) {
      debugPrint('$e');
    }
  }

  ///Gets places in table Detail with genre
  fetchPlaceInvolvedInDetail() async {
    try {
      listDetailPlaces = await client.detail.getDetailByGenre(genre: 'places_involved');
    } catch (e) {
      debugPrint('$e');
    }
  }

  ///Adds and gets detail with genre
  ///and at same time adds a place without keyCountry into table Place
  addDetailPlacesAndFetch(String placesInv, String newPlace) async {
    try {
      var detailPInv = Detail(genre: placesInv, mot: newPlace);
      var places = Places(place: newPlace, country: '');
      listDetailPlaces = await client.detail.addAndReturnDetailByGenre(detailPInv);
      await client.places.addPlaces(places);
    } catch (e) {
      debugPrint('$e');
    }
  }
}