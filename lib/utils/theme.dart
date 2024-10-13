import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaritimeTheme {
  static TextTheme textTheme = TextTheme(
    titleLarge:GoogleFonts.hinaMincho(
        fontSize: 100, fontWeight: FontWeight.bold, color: const Color(0xFF006400)),//green
    titleMedium: GoogleFonts.hinaMincho(
        fontSize: 80, fontWeight: FontWeight.bold, color: const Color(0xFFf5f5f5)),//white
    titleSmall: GoogleFonts.hinaMincho(
        fontSize: 60, fontWeight: FontWeight.bold, color: const Color(0xFFffd700)),//green
    headlineLarge: GoogleFonts.hinaMincho(
        fontSize: 50, fontWeight: FontWeight.normal, color: const Color(0xFF006400)),//white
    headlineMedium: GoogleFonts.hinaMincho(
        fontSize: 30, fontWeight: FontWeight.normal, color: const Color(0xFFf5f5f5)),//white
    headlineSmall: GoogleFonts.hinaMincho(
        fontSize: 16, fontWeight: FontWeight.normal, color: const Color(0xFFa9a9a9)),//gray
    bodyLarge: GoogleFonts.hinaMincho(
        fontSize: 30, fontWeight: FontWeight.normal, color: const Color(0xFF006400)),//white
    bodyMedium: GoogleFonts.hinaMincho(
        fontSize: 20, fontWeight: FontWeight.normal, color: const Color(0xFF006400)),//green
    bodySmall: GoogleFonts.hinaMincho(
        fontSize: 20, fontWeight: FontWeight.normal, color: Colors.black54),//black
  );
  static AppBarTheme appBarTheme = const AppBarTheme(
    backgroundColor: Color(0x4D8Ec6ff),
  );
}