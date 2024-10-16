import 'package:flutter/material.dart';

typedef OnChoiceSelected = void Function(String choiceKey, int choiceId);

///ひとつ選ぶ
class ChoiceFormat extends StatefulWidget {
  final List<String> choiceList;
  final String choiceKey;
  final int choiceId;
  final OnChoiceSelected onChoiceSelected;

  const ChoiceFormat({
    super.key,
    required this.choiceList,
    required this.choiceKey,
    required this.choiceId,
    required this.onChoiceSelected,
  });

  @override
  ChoiceFormatState createState() => ChoiceFormatState();
}

class ChoiceFormatState extends State<ChoiceFormat> {
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(widget.choiceKey),
      selected: widget.choiceList.contains(widget.choiceKey),
      selectedColor: Colors.yellow,
      onSelected: (bool value) {
        setState(() {
          if (value) {
            widget.choiceList.clear();
            widget.choiceList.add(widget.choiceKey);
          } else {
            widget.choiceList
                .removeWhere((filter) => filter == widget.choiceKey);
          }
        });
        widget.onChoiceSelected(widget.choiceKey, widget.choiceId);
      },
    );
  }
}

///Choice sansId
typedef OnChoiceSISelected = void Function(String choiceKey);

class ChoiceSIFormat extends StatefulWidget {
  final List<String> choiceSIList;
  final String choiceSIKey;
  final OnChoiceSISelected onChoiceSISelected;

  const ChoiceSIFormat({
    super.key,
    required this.choiceSIList,
    required this.choiceSIKey,
    required this.onChoiceSISelected,
  });

  @override
  ChoiceSIFormatState createState() => ChoiceSIFormatState();
}

class ChoiceSIFormatState extends State<ChoiceSIFormat> {
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(widget.choiceSIKey),
      selected: widget.choiceSIList.contains(widget.choiceSIKey),
      selectedColor: Colors.yellow,
      onSelected: (bool value) {
        setState(() {
          if (value) {
            widget.choiceSIList.clear();
            widget.choiceSIList.add(widget.choiceSIKey);
          } else {
            widget.choiceSIList
                .removeWhere((filter) => filter == widget.choiceSIKey);
          }
        });
        widget.onChoiceSISelected(widget.choiceSIKey);
      },
    );
  }
}

///複数選ぶ
class FilterFormat extends StatefulWidget {
  final List<String> filteredKeys;
  final List<dynamic> filteredValues;
  final String filterKey;
  final dynamic filterValue;

  const FilterFormat({
    super.key,
    required this.filteredKeys,
    required this.filteredValues,
    required this.filterKey,
    required this.filterValue,
  });

  @override
  FilterFormatState createState() => FilterFormatState();
}

class FilterFormatState extends State<FilterFormat> {
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.filterKey),
      selected: widget.filteredKeys.contains(widget.filterKey),
      onSelected: (bool value) {
        setState(() {
          if (value) {
            if (!widget.filteredKeys.contains(widget.filterKey)) {
              widget.filteredKeys.add(widget.filterKey);
            }
            if (!widget.filteredValues.contains(widget.filterValue)) {
              widget.filteredValues.add(widget.filterValue);
            }
          } else {
            widget.filteredKeys.removeWhere((key) => key == widget.filterKey);
            widget.filteredValues
                .removeWhere((value) => value == widget.filterValue);
          }
        });
      },
    );
  }
}

typedef OnSelected = void Function(String filterKey, int filterId);

class FilterFormatImediat extends StatefulWidget {
  final List<String> filteredImKeys;
  final List<dynamic> filteredImValues;
  final String filterImKey;
  final dynamic filterImValue;
  final OnSelected onSelected;

  const FilterFormatImediat({
    super.key,
    required this.filteredImKeys,
    required this.filteredImValues,
    required this.filterImKey,
    required this.filterImValue,
    required this.onSelected,
  });

  @override
  FilterFormatImediatState createState() => FilterFormatImediatState();
}

class FilterFormatImediatState extends State<FilterFormatImediat> {
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.filterImKey),
      selected: widget.filteredImKeys.contains(widget.filterImKey),
      onSelected: (bool value) {
        setState(() {
          if (value) {
            if (!widget.filteredImKeys.contains(widget.filterImKey)) {
              widget.filteredImKeys.add(widget.filterImKey);
            }
            if (!widget.filteredImValues.contains(widget.filterImValue)) {
              widget.filteredImValues.add(widget.filterImValue);
            }
          } else {
            widget.filteredImKeys
                .removeWhere((key) => key == widget.filterImKey);
            widget.filteredImValues
                .removeWhere((value) => value == widget.filterImValue);
          }
          // Notify the parent widget that the selection has changed.
          widget.onSelected(widget.filterImKey, widget.filterImValue);
        });
      },
    );
  }
}

typedef OnSelectedSI = void Function(String filterKey);

class FilterFormatImediatSI extends StatefulWidget {
  final List<String> filteredImSiKeys;
  final String filterImSiKey;
  final OnSelectedSI onSelectedSI;

  const FilterFormatImediatSI({
    super.key,
    required this.filteredImSiKeys,
    required this.filterImSiKey,
    required this.onSelectedSI,
  });

  @override
  FilterFormatImediatSIState createState() => FilterFormatImediatSIState();
}

class FilterFormatImediatSIState extends State<FilterFormatImediatSI> {
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.filterImSiKey),
      selected: widget.filteredImSiKeys.contains(widget.filterImSiKey),
      onSelected: (bool value) {
        setState(() {
          if (!widget.filteredImSiKeys.contains(widget.filterImSiKey)) {
            widget.filteredImSiKeys.add(widget.filterImSiKey);
          } else {
            widget.filteredImSiKeys
                .removeWhere((key) => key == widget.filterImSiKey);
          }
          // Notify the parent widget that the selection has changed.
          widget.onSelectedSI(widget.filterImSiKey);
        });
      },
    );
  }
}
