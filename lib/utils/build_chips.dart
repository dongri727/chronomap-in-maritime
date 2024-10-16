// widget_helpers.dart
import 'package:flutter/material.dart';

import 'chips_format.dart';

Widget buildFilterFormatImediat({
  required List<String> filteredKeys,
  required List<int> filteredValues,
  required String filterKey,
  required int filterValue,
  required Function(String, int) onSelected,
}) {
  return FilterFormatImediat(
    filteredImKeys: filteredKeys,
    filteredImValues: filteredValues,
    filterImKey: filterKey,
    filterImValue: filterValue,
    onSelected: onSelected,
  );
}

Widget buildFilterFormatImediatSI({
  required List<String> filteredKeys,
  required String filterKey,
  required Function(String) onSelected,
}) {
  return FilterFormatImediatSI(
    filteredImSiKeys: filteredKeys,
    filterImSiKey: filterKey,
    onSelectedSI: onSelected,
  );
}

Widget buildChoiceSIFormat({
  required List<String> choiceSIList,
  required String choiceSIKey,
  required onChoiceSISelected,
}) {
  return ChoiceSIFormat(
      choiceSIList: choiceSIList,
      choiceSIKey: choiceSIKey,
      onChoiceSISelected: onChoiceSISelected
  );
}

Widget buildChoiceFormat({
  required List<String> choiceList,
  required String choiceKey,
  required int choiceId,
  required OnChoiceSelected onChoiceSelected,
}) {
  return ChoiceFormat(
      choiceList: choiceList,
      choiceKey: choiceKey,
      choiceId: choiceId,
      onChoiceSelected: onChoiceSelected);
}