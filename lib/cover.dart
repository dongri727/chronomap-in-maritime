import 'package:acorn_client/acorn_client.dart';
import 'package:chronomap_in_maritime/fetch/fetch_japanese.dart';
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';
import 'hints/info_page.dart';
import 'index.dart';
import 'serverpod_client.dart';
import 'utils/language_button.dart';
import 'utils/shadowed_container.dart';

class CoverPage extends StatefulWidget {
  const CoverPage({super.key});

  @override
  CoverPageState createState() => CoverPageState();
}

class CoverPageState extends State<CoverPage> {
  static const _shownAnnouncementsKey = 'shown_announcements';
  static const _legacyLastAnnouncementKey = 'last_shown_announcement';

  bool _checkedRemoteConfig = false;
  bool _announcementShownThisRun = false;

  @override
  void initState() {
    super.initState();

    // build() 完了後に context が安全に使えるタイミングで実行
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUpdateAndAnnouncements();
    });
  }

  String _platformString() {
    if (kIsWeb) return 'web';
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return 'ios';
      case TargetPlatform.android:
        return 'android';
      default:
        return 'other';
    }
  }

  Future<void> _checkUpdateAndAnnouncements() async {
    if (!mounted || _checkedRemoteConfig) return;
    _checkedRemoteConfig = true;

    int? currentBuild;
    try {
      final info = await PackageInfo.fromPlatform();
      currentBuild = int.tryParse(info.buildNumber);
    } catch (error) {
      debugPrint('PackageInfo fetch failed: $error');
    }

    if (!mounted) return;
    final platform = _platformString();
    final locale = Localizations.localeOf(context).languageCode;

    try {
      final cfg =
          await client.appConfig.get(platform: platform, locale: locale);
      if (!mounted) return;

      if (cfg.maintenance) {
        await _showMaintenanceDialog(cfg.message, locale);
        return;
      }

      if (currentBuild != null && currentBuild < cfg.minBuild) {
        await _showForceUpdateDialog(cfg, platform, locale);
        return;
      }

      if (currentBuild != null && currentBuild < cfg.latestBuild) {
        await _showOptionalUpdateDialog(cfg, platform, locale);
      }
    } catch (error) {
      // 通信障害時は通常起動を妨げない。
      debugPrint('AppConfig fetch failed: $error');
    }

    if (!mounted || _announcementShownThisRun) return;

    try {
      final list = await client.announcement.listLatest(
        platform: platform,
        locale: locale,
        limit: 10,
      );
      if (!mounted) return;

      final now = DateTime.now().toUtc();
      final eligible = list.where((announcement) {
        final published = announcement.isPublished ?? false;
        final hasStarted = !announcement.publishedAt.toUtc().isAfter(now);
        final supportsBuild = announcement.minBuild == null ||
            (currentBuild != null && currentBuild >= announcement.minBuild!);
        return published && hasStarted && supportsBuild;
      });

      final preferences = await SharedPreferences.getInstance();
      final shownAnnouncements = <String>{
        ...?preferences.getStringList(_shownAnnouncementsKey),
        ...?switch (preferences.get(_legacyLastAnnouncementKey)) {
          final String token => [token],
          _ => null,
        },
      };
      Announcement? announcement;
      for (final candidate in eligible) {
        if (!shownAnnouncements.contains(_announcementToken(candidate))) {
          announcement = candidate;
          break;
        }
      }

      if (!mounted || announcement == null) return;
      _announcementShownThisRun = true;
      await _showAnnouncementDialog(announcement, locale);
      shownAnnouncements.add(_announcementToken(announcement));
      await preferences.setStringList(
        _shownAnnouncementsKey,
        shownAnnouncements.toList().reversed.take(50).toList(),
      );
    } catch (error) {
      debugPrint('Announcement fetch failed: $error');
    }
  }

  String _announcementToken(Announcement announcement) =>
      announcement.id?.toString() ?? announcement.publishedAt.toIso8601String();

  String? _updateUrl(AppConfigResponse cfg, String platform) {
    final value = switch (platform) {
      'ios' => cfg.storeUrlIos,
      'android' => cfg.storeUrlAndroid,
      _ => cfg.webUrl,
    };
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }

  Uri? _validExternalUri(String? value) {
    if (value == null) return null;
    final uri = Uri.tryParse(value);
    if (uri == null || !uri.hasScheme) return null;
    if (!const {'https', 'http', 'market'}.contains(uri.scheme)) return null;
    return uri;
  }

  Future<bool> _openUpdateUrl(String? value) async {
    final uri = _validExternalUri(value);
    if (uri == null) return false;
    try {
      return await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );
    } catch (error) {
      debugPrint('Update URL launch failed: $error');
      return false;
    }
  }

  bool _isJapanese(String locale) => locale.toLowerCase().startsWith('ja');

  Future<void> _showMaintenanceDialog(String message, String locale) async {
    final japanese = _isJapanese(locale);
    final retry = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: Text(japanese ? 'メンテナンス中' : 'Maintenance'),
          content: Text(message.isNotEmpty
              ? message
              : (japanese
                  ? '現在、サービスを一時停止しています。'
                  : 'The app is temporarily unavailable.')),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(japanese ? '再確認' : 'Retry'),
            ),
          ],
        ),
      ),
    );

    if (retry == true && mounted) {
      _checkedRemoteConfig = false;
      await _checkUpdateAndAnnouncements();
    }
  }

  Future<void> _showForceUpdateDialog(
    AppConfigResponse cfg,
    String platform,
    String locale,
  ) async {
    final japanese = _isJapanese(locale);
    final url = _updateUrl(cfg, platform);
    final hasValidUrl = _validExternalUri(url) != null;

    await showDialog<void>(
      context: context,
      barrierDismissible: !hasValidUrl,
      builder: (dialogContext) {
        return PopScope(
          canPop: !hasValidUrl,
          child: AlertDialog(
            title: Text(japanese ? 'アップデートが必要です' : 'Update required'),
            content: Text(cfg.message.isNotEmpty
                ? cfg.message
                : (japanese
                    ? '新しいバージョンへアップデートしてください。'
                    : 'A new version is required. Please update.')),
            actions: <Widget>[
              if (!hasValidUrl)
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: Text(japanese ? '閉じる' : 'Close'),
                ),
              TextButton(
                onPressed: hasValidUrl
                    ? () async {
                        final opened = await _openUpdateUrl(url);
                        if (!opened && mounted) _showUrlError(locale);
                      }
                    : null,
                child: Text(japanese ? 'アップデート' : 'Update'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showOptionalUpdateDialog(
    AppConfigResponse cfg,
    String platform,
    String locale,
  ) async {
    final japanese = _isJapanese(locale);
    final url = _updateUrl(cfg, platform);
    final hasValidUrl = _validExternalUri(url) != null;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(japanese ? 'アップデートのお知らせ' : 'Update available'),
          content: Text(cfg.message.isNotEmpty
              ? cfg.message
              : (japanese
                  ? '新しいバージョンを利用できます。'
                  : 'A new version is available.')),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(japanese ? 'あとで' : 'Later'),
            ),
            if (hasValidUrl)
              TextButton(
                onPressed: () async {
                  final opened = await _openUpdateUrl(url);
                  if (!dialogContext.mounted) return;
                  if (opened) {
                    Navigator.pop(dialogContext);
                  } else {
                    _showUrlError(locale);
                  }
                },
                child: Text(japanese ? 'アップデート' : 'Update'),
              ),
          ],
        );
      },
    );
  }

  Future<void> _showAnnouncementDialog(
    Announcement announcement,
    String locale,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(announcement.title),
        content: SingleChildScrollView(child: Text(announcement.body)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(_isJapanese(locale) ? '確認' : 'OK'),
          ),
        ],
      ),
    );
  }

  void _showUrlError(String locale) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isJapanese(locale)
            ? 'ストアを開けませんでした。時間をおいて再度お試しください。'
            : 'Could not open the store. Please try again later.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FetchJapaneseRepository(),
      child: Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppLocalizations.of(context)!.cover),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 50, 30, 30),
                child: ShadowedContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          child: const Text(
                            "Start",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.blueAccent,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push<String>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const IndexPage(),
                              ),
                            );
                          }),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: LanguageDropdownButton(),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const InfoPage()));
                          },
                          icon: const Icon(
                            Icons.info_outline,
                            size: 32.0,
                            color: Colors.blue,
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
