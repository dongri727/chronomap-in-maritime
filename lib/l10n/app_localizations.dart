import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('ja')
  ];

  /// No description provided for @cover.
  ///
  /// In en, this message translates to:
  /// **'assets/images/cover_en.png'**
  String get cover;

  /// No description provided for @infoA.
  ///
  /// In en, this message translates to:
  /// **'This is an application specialized in the input and output of data related to the maritime events from the \"ChronoMap\". The \"ChronoMap\" is a database that encompasses all historical events from the origin of the universe to the endless \'now,\' without regard to field. It aims to accurately display temporal and spatial distances, with \'when\' and \'where\' as mandatory items.'**
  String get infoA;

  /// No description provided for @infoB.
  ///
  /// In en, this message translates to:
  /// **'Web version of \"ChronoMap\"'**
  String get infoB;

  /// No description provided for @infoC.
  ///
  /// In en, this message translates to:
  /// **'Web version of 3Dl and 4D views'**
  String get infoC;

  /// No description provided for @infoD.
  ///
  /// In en, this message translates to:
  /// **'How to use the \"ChronoMap\"'**
  String get infoD;

  /// No description provided for @infoE.
  ///
  /// In en, this message translates to:
  /// **'This app does not acquire any of your personal information, nor does it track or use information on your device.'**
  String get infoE;

  /// No description provided for @infoF.
  ///
  /// In en, this message translates to:
  /// **'The historical information you register is not linked to you. There are no records of what you register or search for.'**
  String get infoF;

  /// No description provided for @infoG.
  ///
  /// In en, this message translates to:
  /// **'Information contrary to the purpose of the \"ChronoMap\" will be handled by the administrator as follows.\n1. Correction\n2. Viewing stop (may be made public in the future)\n3. Deletion'**
  String get infoG;

  /// No description provided for @infoH.
  ///
  /// In en, this message translates to:
  /// **'The historical information you register is treated as a public good, and you yourself cannot delete it. Please be careful not to write personal information. If you want to delete information registered by mistake or find information that should be deleted, please contact the following address.'**
  String get infoH;

  /// No description provided for @infoI.
  ///
  /// In en, this message translates to:
  /// **'We are looking for people to join us in developing the \"ChronoMap.\" If you are an engineer who can handle Flutter, AWS, PostgreSQL, Unity, etc., or can assist with data entry and correction, please contact us below.'**
  String get infoI;

  /// No description provided for @scalableA.
  ///
  /// In en, this message translates to:
  /// **'This page plots and displays maritime events registered in the database on an adjustable timeline. When you register data, it will be reflected in real-time.'**
  String get scalableA;

  /// No description provided for @scalableB.
  ///
  /// In en, this message translates to:
  /// **'Step 1\nBe sure to press the Get button to obtain data.'**
  String get scalableB;

  /// No description provided for @scalableC.
  ///
  /// In en, this message translates to:
  /// **'Step 2\nThe 7 options at the bottom allow you to select the initial display area. You can scroll through the entire timeline after the initial display.'**
  String get scalableC;

  /// No description provided for @scalableD.
  ///
  /// In en, this message translates to:
  /// **'The logarithmic timeline is set with the year 2100 as the base, with time flowing from top to bottom. Events are fixed on the timeline, so events that occurred close in time are displayed near each other, while events that occurred over a longer span of time are displayed further apart. Zooming in will show details of events from the same era, while zooming out provides an overview of longer periods.'**
  String get scalableD;

  /// No description provided for @scalableE.
  ///
  /// In en, this message translates to:
  /// **'If you find any events plotted in the wrong position, please contact us at the following.'**
  String get scalableE;

  /// No description provided for @addHintA.
  ///
  /// In en, this message translates to:
  /// **'In the \"ChronoMap\" a historical event refers to a singular occurrence equipped with \"when\" and \"where\" information. For instance, \"Columbus\'s quest for a sea route to India\" is not considered a singular event. A proper entry would look like: \"October 12, 1492, Columbus reaches Guanahani Island in the West Indies, Bahamas, San Salvador Island.\"'**
  String get addHintA;

  /// No description provided for @addHintB.
  ///
  /// In en, this message translates to:
  /// **'To associate events and perform searches effectively, make use of search tags. Tap \"Show Tags\" to view existing tags. You can select one or multiple tags.'**
  String get addHintB;

  /// No description provided for @addHintC.
  ///
  /// In en, this message translates to:
  /// **'If you want to add a new search tag, type it into the \"Enter Tag\" field. Once you do so, the \"Add Tag\" button will appear. Tap it to add the new tag to the list of options, then select it.'**
  String get addHintC;

  /// No description provided for @addHintD.
  ///
  /// In en, this message translates to:
  /// **'For the \"WHEN\" section, first choose the unit using the dropdown button, then enter the year, month, and day. If the month or day is unknown, enter 0. However, note that events with month and day set to 0 may not retain the correct chronological order with other events in the same year.'**
  String get addHintD;

  /// No description provided for @addHintE.
  ///
  /// In en, this message translates to:
  /// **'For the \"WHERE\" section, start by selecting a country name or ocean name, then add a place name or sea area name. While country and ocean names cannot be added, place names and sea area names can be. When you enter a new name, the \"Add\" button will appear. Tap it to add the name to the list of options, then select it.'**
  String get addHintE;

  /// No description provided for @addHintF.
  ///
  /// In en, this message translates to:
  /// **'Latitude and longitude should be entered in decimal format. There is no need to include a minus sign for southern latitude or western longitude. Events with latitude and longitude will be reflected immediately on all display screens. If latitude and longitude are not entered, the event will only be displayed on the Stretchable Timeline and CLASSIC view.'**
  String get addHintF;

  /// No description provided for @indexA.
  ///
  /// In en, this message translates to:
  /// **'Register Events'**
  String get indexA;

  /// No description provided for @indexB.
  ///
  /// In en, this message translates to:
  /// **'Scalable Timeline'**
  String get indexB;

  /// No description provided for @indexC.
  ///
  /// In en, this message translates to:
  /// **'Search & View'**
  String get indexC;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Event(within 50 letters)'**
  String get name;

  /// No description provided for @showOptions.
  ///
  /// In en, this message translates to:
  /// **'Show Options'**
  String get showOptions;

  /// No description provided for @newWord.
  ///
  /// In en, this message translates to:
  /// **'another port, island or sea'**
  String get newWord;

  /// No description provided for @newTag.
  ///
  /// In en, this message translates to:
  /// **'Enter the tag you want to add'**
  String get newTag;

  /// No description provided for @addWord.
  ///
  /// In en, this message translates to:
  /// **'add a new word'**
  String get addWord;

  /// No description provided for @ifYouMayKnow.
  ///
  /// In en, this message translates to:
  /// **'Please enter if you may know'**
  String get ifYouMayKnow;

  /// No description provided for @searchA.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchA;

  /// No description provided for @searchB.
  ///
  /// In en, this message translates to:
  /// **'What narrows your search?'**
  String get searchB;

  /// No description provided for @searchC.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get searchC;

  /// No description provided for @searchHintA.
  ///
  /// In en, this message translates to:
  /// **'Touch the \"Show Tags\" button and select one option from the list. Since cross-searching is not yet implemented, if you select multiple options, only the last one chosen will be valid.'**
  String get searchHintA;

  /// No description provided for @searchHintB.
  ///
  /// In en, this message translates to:
  /// **'If you touch the \"Show Results\" button without selecting a tag, an error will occur. To display all items, please select the \"All\" tag.'**
  String get searchHintB;

  /// No description provided for @searchHintC.
  ///
  /// In en, this message translates to:
  /// **'The \"Show Results\" screen offers four different display types. All show the same content.'**
  String get searchHintC;

  /// No description provided for @searchHintD.
  ///
  /// In en, this message translates to:
  /// **'CLASSIC: A traditional timeline where the date, event name, and location are displayed together.'**
  String get searchHintD;

  /// No description provided for @searchHintE.
  ///
  /// In en, this message translates to:
  /// **'Atlantic / Pacific: A 3D view with a world map on the XY plane and the passage of time represented along the Z-axis. The view is fully rotatable in 360°. It is recommended to use this display in landscape mode.'**
  String get searchHintE;

  /// No description provided for @searchHintF.
  ///
  /// In en, this message translates to:
  /// **'Globe: A 3D view displayed on a globe. The view is fully rotatable in 360°. Note that the passage of time is not displayed in this format. Please refer to the other formats for time progression.'**
  String get searchHintF;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fr', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
    case 'ja': return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
