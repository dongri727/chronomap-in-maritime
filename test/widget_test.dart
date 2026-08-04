// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:chronomap_in_maritime/main.dart';
import 'package:chronomap_in_maritime/serverpod_client.dart';

void main() {
  testWidgets('shows the cover page', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    GoogleFonts.config.allowRuntimeFetching = false;
    await initializeServerpodClient();

    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('Start'), findsOneWidget);
  });
}
