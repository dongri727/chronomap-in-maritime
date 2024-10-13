import 'package:flutter/material.dart';

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