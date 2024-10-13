import 'package:chronomap_in_maritime/utils/shadowed_container.dart';
import 'package:chronomap_in_maritime/utils/theme.dart';
import 'package:flutter/material.dart';

//Used for the Add Term Buttons on Input Pages.
class ButtonFormat extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const ButtonFormat ({
    required this.label,
    required this.onPressed,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text(label,
        style: const TextStyle(
            fontSize: 16,
            color: Colors.green),
      ),
    );
  }
}

///Vertically aligned RadioButton showing choices
class RadioButtonFormat extends StatefulWidget {
  final List<String> options;
  final String? initialOption;
  final ValueChanged<String?> onChanged;

  const RadioButtonFormat({
    super.key,
    required this.options,
    this.initialOption,
    required this.onChanged,
  });

  @override
  State<RadioButtonFormat> createState() => _RadioButtonFormatState();
}

class _RadioButtonFormatState extends State<RadioButtonFormat> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.initialOption;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.map((option) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ShadowedContainer(
            child: ListTile(
              title: Text(
                option,
              ),
              leading: Radio<String>(
                //activeColor: Colors.yellow,
                value: option,
                groupValue: _selectedOption,
                onChanged: (String? value) {
                  setState(() {
                    _selectedOption = value;
                  });
                  widget.onChanged(value);
                },
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

///Side-by-side RadioButton showing choices
///Used for latitude and longitude input and search page
class RadioButtonRowFormat extends StatefulWidget {
  final List<String> options;
  final String? initialOption;
  final ValueChanged<String?> onChanged;

  const RadioButtonRowFormat({
    super.key,
    required this.options,
    this.initialOption,
    required this.onChanged,
  });

  @override
  State<RadioButtonRowFormat> createState() => _RadioButtonRowFormatState();
}

class _RadioButtonRowFormatState extends State<RadioButtonRowFormat> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.initialOption;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.options.map((option) {
        return Expanded(
          child: ListTile(
            title: Text(option),
            leading: Radio<String>(
              activeColor: Colors.black,
              value: option,
              groupValue: _selectedOption,
              onChanged: (String? value) {
                setState(() {
                  _selectedOption = value;
                });
                widget.onChanged(value);
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}

//Used for the Add Term Buttons on Input Pages.
class TextButtonFormat extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const TextButtonFormat ({
    required this.label,
    required this.onPressed,
    required this.color,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: onPressed,
        child: Text(label,
          style: TextStyle(
            fontSize: 18,
            color: color,
          ),
        ),
      ),
    );
  }
}
