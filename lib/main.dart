import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'cover.dart';
import 'fetch/fetch_japanese.dart';
import 'scalable/bloc_provider.dart';
import 'scalable/timeline/timeline.dart';
import 'search/search_model.dart';
import 'serverpod_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeServerpodClient();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _loadSavedLanguage();
  }

  void setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  void _loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguageCode = prefs.getString('languageCode');
    if (savedLanguageCode != null) {
      setState(() {
        _locale = Locale(savedLanguageCode);
      });
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FetchJapaneseRepository()),
        ChangeNotifierProvider(create: (_) => SearchModel()),
    ],
      child: BlocProvider(
        t: Timeline(Theme.of(context).platform),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chronomap in Maritime',
          theme: ThemeData(
            textTheme: GoogleFonts.tsukimiRoundedTextTheme(
                Theme.of(context).textTheme
            ),
            appBarTheme: MaritimeTheme.appBarTheme,

            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: const [Locale('en'), Locale('ja'), Locale('fr')],
          locale: _locale,
          home: const CoverPage(),
        ),
      ),
    );
  }
}


