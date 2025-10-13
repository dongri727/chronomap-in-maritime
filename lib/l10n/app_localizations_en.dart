// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get cover => 'assets/images/cover_en.png';

  @override
  String get infoA => 'This is an application specialized in the input and output of data related to the maritime events from the \"ChronoMap\". The \"ChronoMap\" is a database that encompasses all historical events from the origin of the universe to the endless \'now,\' without regard to field. It aims to accurately display temporal and spatial distances, with \'when\' and \'where\' as mandatory items.';

  @override
  String get infoB => 'Web version of \"ChronoMap\"';

  @override
  String get infoC => 'Web version of 3Dl and 4D views';

  @override
  String get infoD => 'How to use the \"ChronoMap\"';

  @override
  String get infoE => 'This app does not acquire any of your personal information, nor does it track or use information on your device.';

  @override
  String get infoF => 'The historical information you register is not linked to you. There are no records of what you register or search for.';

  @override
  String get infoG => 'Information contrary to the purpose of the \"ChronoMap\" will be handled by the administrator as follows.\n1. Correction\n2. Viewing stop (may be made public in the future)\n3. Deletion';

  @override
  String get infoH => 'The historical information you register is treated as a public good, and you yourself cannot delete it. Please be careful not to write personal information. If you want to delete information registered by mistake or find information that should be deleted, please contact the following address.';

  @override
  String get infoI => 'We are looking for people to join us in developing the \"ChronoMap.\" If you are an engineer who can handle Flutter, AWS, PostgreSQL, Unity, etc., or can assist with data entry and correction, please contact us below.';

  @override
  String get scalableA => 'This page plots and displays maritime events registered in the database on an adjustable timeline. When you register data, it will be reflected in real-time.';

  @override
  String get scalableB => 'Step 1\nBe sure to press the Get button to obtain data.';

  @override
  String get scalableC => 'Step 2\nThe 7 options at the bottom allow you to select the initial display area. You can scroll through the entire timeline after the initial display.';

  @override
  String get scalableD => 'The logarithmic timeline is set with the year 2100 as the base, with time flowing from top to bottom. Events are fixed on the timeline, so events that occurred close in time are displayed near each other, while events that occurred over a longer span of time are displayed further apart. Zooming in will show details of events from the same era, while zooming out provides an overview of longer periods.';

  @override
  String get scalableE => 'If you find any events plotted in the wrong position, please contact us at the following.';

  @override
  String get addHintA => 'In the \"ChronoMap\" a historical event refers to a singular occurrence equipped with \"when\" and \"where\" information. For instance, \"Columbus\'s quest for a sea route to India\" is not considered a singular event. A proper entry would look like: \"October 12, 1492, Columbus reaches Guanahani Island in the West Indies, Bahamas, San Salvador Island.\"';

  @override
  String get addHintB => 'To associate events and perform searches effectively, make use of search tags. Tap \"Show Tags\" to view existing tags. You can select one or multiple tags.';

  @override
  String get addHintC => 'If you want to add a new search tag, type it into the \"Enter Tag\" field. Once you do so, the \"Add Tag\" button will appear. Tap it to add the new tag to the list of options, then select it.';

  @override
  String get addHintD => 'For the \"WHEN\" section, first choose the unit using the dropdown button, then enter the year, month, and day. If the month or day is unknown, enter 0. However, note that events with month and day set to 0 may not retain the correct chronological order with other events in the same year.';

  @override
  String get addHintE => 'For the \"WHERE\" section, start by selecting a country name or ocean name, then add a place name or sea area name. While country and ocean names cannot be added, place names and sea area names can be. When you enter a new name, the \"Add\" button will appear. Tap it to add the name to the list of options, then select it.';

  @override
  String get addHintF => 'Latitude and longitude should be entered in decimal format. There is no need to include a minus sign for southern latitude or western longitude. Events with latitude and longitude will be reflected immediately on all display screens. If latitude and longitude are not entered, the event will only be displayed on the Stretchable Timeline and CLASSIC view.';

  @override
  String get indexA => 'Register Events';

  @override
  String get indexB => 'Scalable Timeline';

  @override
  String get indexC => 'Search & View';

  @override
  String get name => 'Event(within 50 letters)';

  @override
  String get showOptions => 'Show Options';

  @override
  String get newWord => 'another port, island or sea';

  @override
  String get newTag => 'Enter the tag you want to add';

  @override
  String get addWord => 'add a new word';

  @override
  String get ifYouMayKnow => 'Please enter if you may know';

  @override
  String get searchA => 'Search';

  @override
  String get searchB => 'What narrows your search?';

  @override
  String get searchC => 'Confirm';

  @override
  String get searchHintA => 'Touch the \"Show Tags\" button and select one option from the list. Since cross-searching is not yet implemented, if you select multiple options, only the last one chosen will be valid.';

  @override
  String get searchHintB => 'If you touch the \"Show Results\" button without selecting a tag, an error will occur. To display all items, please select the \"All\" tag.';

  @override
  String get searchHintC => 'The \"Show Results\" screen offers four different display types. All show the same content.';

  @override
  String get searchHintD => 'CLASSIC: A traditional timeline where the date, event name, and location are displayed together.';

  @override
  String get searchHintE => 'Atlantic / Pacific: A 3D view with a world map on the XY plane and the passage of time represented along the Z-axis. The view is fully rotatable in 360°. It is recommended to use this display in landscape mode.';

  @override
  String get searchHintF => 'Globe: A 3D view displayed on a globe. The view is fully rotatable in 360°. Note that the passage of time is not displayed in this format. Please refer to the other formats for time progression.';
}
