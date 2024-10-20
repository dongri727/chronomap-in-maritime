import 'package:chronomap_in_maritime/utils/theme.dart';
import 'package:flutter/material.dart';

class TffFormat extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final Color tffColor1;
  final Color tffColor2;

  const TffFormat({
    required this.hintText,
    required this.onChanged,
    required this.tffColor1,
    required this.tffColor2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 20,
          color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(5.0),
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 18,
            color: tffColor1),
        fillColor: tffColor2,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: tffColor2,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: tffColor2,
            width: 1.0,
          ),
        ),
      ),
      onChanged: onChanged,
    );
  }
}

class HintText extends StatelessWidget {
  final String hintText;

  const HintText({
    required this.hintText,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        hintText,
        textAlign: TextAlign.left,
        style: MaritimeTheme.textTheme.headlineMedium,
/*        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),*/
      ),
    );
  }
}