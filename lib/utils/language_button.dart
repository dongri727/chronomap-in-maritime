import 'package:acorn_client/acorn_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../fetch/fetch_japanese.dart';

class LanguageDropdownButton extends StatefulWidget {
  const LanguageDropdownButton({super.key});

  @override
  LanguageDropdownButtonState createState() => LanguageDropdownButtonState();
}

class LanguageDropdownButtonState extends State<LanguageDropdownButton> {
  String? currentLanguage = 'ja';// 初期値として'ja' (日本の国旗) を設定

  List<Japanese> japaneseList = [];

  //DB多言語化
  Future<void> fetchJapaneseNamesIfNeeded() async {
    final fetchJapaneseRepository = Provider.of<FetchJapaneseRepository>(context, listen: false);
    if (fetchJapaneseRepository.isJapaneseLanguage(context)) {
      await fetchJapaneseRepository.fetchAllJapaneseNames();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadLanguage();  // 起動時に言語設定を読み込む
  }

  void _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode');

    // SharedPreferencesから言語が読み込めたら、それを使ってUIを更新
    if (languageCode != null) {
      setState(() {
        currentLanguage = languageCode;
      });
    }
  }

  void _changeLanguage(String languageCode) async {
    Locale newLocale = Locale(languageCode);

    // 言語を保存する
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);

    if (!mounted) return;

    MyApp.setLocale(context, newLocale); // MyApp内のsetLocaleメソッドを呼び出し

    // 言語が日本語なら、特定の関数を呼び出す
    if (languageCode == 'ja') {
      await fetchJapaneseNamesIfNeeded();
      setState(() {
        // UIを更新するためにsetStateを呼び出す
        debugPrint('Fetched Japanese names: ${Provider.of<FetchJapaneseRepository>(context, listen: false).japaneseList.length} items');
      });
    }

    // setStateを呼び出して、UIを更新
    setState(() {
      currentLanguage = languageCode;  // 現在の言語を更新
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(15),
      value: currentLanguage,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            currentLanguage = newValue;
            _changeLanguage(newValue);  // 選択された言語コードを_changeLanguageに渡す
          });
        }
      },
      items: <String>['en', 'ja', 'fr']  // 言語コードのリスト
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value == 'en' ? 'English' : value == 'ja' ? '日本語' : 'Français'),  // 国旗の表示
        );
      }).toList(),
    );
  }
}