// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get cover => 'assets/images/cover_ja.png';

  @override
  String get infoA => 'これは『四次元年表』のうち、海事に関連するデータの入・出力に特化したアプリです。『四次元年表』とは宇宙の始原から終わりなき「今」に至る、全ての歴史的事象を、分野にかかわらず網羅するデータベースです。「いつ」だけでなく、｢どこで｣を必須項目とし、時間的距離、空間的距離を正しく表示することを目指します。';

  @override
  String get infoB => 'web版『四次元年表』';

  @override
  String get infoC => 'web版三次元・四次元表示';

  @override
  String get infoD => '『四次元年表』の使い方';

  @override
  String get infoE => 'このアプリは、あなたのどんな個人情報も一切取得しませんし、あなたのデバイス中の情報を追跡、利用することもありません。';

  @override
  String get infoF => 'あなたが登録してくださった歴史情報があなたと紐付けられることはありません。あなたがなにを登録し、なにを検索したかはについて、記録は一切残りません。';

  @override
  String get infoG => '『四次元年表』の趣旨に反する情報は、運営者によって以下の対応を取ります。\n１、修正\n２、閲覧停止（将来公開される可能性あり）\n３、削除';

  @override
  String get infoH => '登録いただいた歴史情報は公共財として扱われ、登録したあなた自身でも削除することはできません。個人情報等を書き込まないようご注意ください。誤って登録した情報を削除したい場合、また、削除すべきと思われる情報を見つけた場合は、下記までご連絡ください。';

  @override
  String get infoI => '『四次元年表』開発をともにする方を求めています。Flutter、AWS、PostgreSQL, Unity等を扱えるエンジニアほか、データ入力やデータ修正等にご協力いただける方は、下記までご連絡ください。';

  @override
  String get scalableA => 'これは、データベースに登録されている海事関連の事象を伸縮可能な時間軸にプロットして表示するページです。データを登録すると、リアルタイムで反映されます。';

  @override
  String get scalableB => '手順１\nデータ取得のために、必ずGetボタンを押してください。';

  @override
  String get scalableC => '手順２\n下部の七つの選択肢は、初期表示の領域を選択します。いずれを選んでも、表示後にスクロールで全領域を見ることができます。';

  @override
  String get scalableD => '2100年を基点とする対数時間軸を設定し、上から下に時代が流れます。事象は時間軸に固定されているので、近接して起こった事象は近くに、時間を経て起こった事象は遠くに表示されます。ズームインすると、同時代の詳細が表示され、ズームアウトすると、長い時代を概観することができます。';

  @override
  String get scalableE => 'プロット位置が間違っている事象を見つけた場合は、以下にご連絡ください。';

  @override
  String get addHintA => '『四次元年表』における歴史的事象とは、「いつ、どこで」の情報を備えた、単一のできごとを指します。例えば「コロンブスによるインド航路探索」は単一のできごととはみなされません。登録は　「1492年10月12日、コロンブス、西インド諸島グァナハニ島に到達、バハマ、サン・サルバドル島」のようになります。';

  @override
  String get addHintB => '各事象を関連付けて検索するために、検索タグを活用してください。「タグを表示」にタッチすると、既存のタグが表示されます。一つでも、複数でも、選択できます。';

  @override
  String get addHintC => '検索タグを追加したいときは、「タグを記入」に記入してください。記入すると「タグを追加」ボタンが現れますので、タッチしてください。新しいタグが選択肢に加わりますので、改めて選択してください。';

  @override
  String get addHintD => 'WHENについては、ドロップダウンボタンで単位を選択してから、年月日を入力してください。月日がわからない場合は、０を記入してください。ただし、月日が０の事象については、同年内の他の事象との時間関係が前後する場合があります。';

  @override
  String get addHintE => 'WHEREについては、まず国名か大洋名を選択し、その後に地名、海域名を追加してください。国名、大洋名は追加できませんが、地名、海域名は追加できます。記入すると「追加」ボタンが現れますので、タッチしてください。新しい地名、海域名が選択肢に加わりますので、改めて選択してください。';

  @override
  String get addHintF => '緯度、経度は十進法で入力してください。南緯、西経にマイナス記号をつける必要はありません。緯度経度が入力されている事象は、表示画面全てに即時反映されます。緯度経度が未記入の場合は、伸縮時間軸とCLASSIC表示にのみ反映されます。';

  @override
  String get indexA => '事象登録';

  @override
  String get indexB => '伸縮時間軸';

  @override
  String get indexC => '検索と表示';

  @override
  String get name => '事象名（50文字以内）';

  @override
  String get showOptions => '選択肢を表示';

  @override
  String get newWord => '追加したい港名、島名、海域名を記入';

  @override
  String get newTag => '追加したいタグを記入';

  @override
  String get addWord => '記入した名称を追加';

  @override
  String get ifYouMayKnow => '可能なら以下もご記入ください';

  @override
  String get searchA => '検索';

  @override
  String get searchB => 'なにで絞り込みますか';

  @override
  String get searchC => '確定';

  @override
  String get searchHintA => '「タグを表示」ボタンに触れてください。選択肢を一つ選んでください。クロス検索未実装のため、複数選ぶと、最後に選んだ一つのみが有効になります。';

  @override
  String get searchHintB => 'タグを選択せずに「結果を表示」ボタンに触れるとエラーになります。全件を表示したい場合は、タグの「All」を選んでください。';

  @override
  String get searchHintC => '「結果を表示」画面には、次の４種類があります。全て同じ内容が表示されます。';

  @override
  String get searchHintD => 'CLASSIC  年月日、事象名、地名が併記されたふつうの年表です。';

  @override
  String get searchHintE => 'Atlantic / Pacific   XY平面に世界地図、Z軸に沿って時間経過を示す三次元表示です。360°回転できます。横位置の画面でご利用になることを推奨します。';

  @override
  String get searchHintF => 'Globe  地球儀上に表示する三次元表示です。360°回転できます。時間経過は表示されませんので、他の形式でご確認ください。';
}
