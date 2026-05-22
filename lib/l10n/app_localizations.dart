import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/l10n/translations.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static const supportedLocales = [
    Locale('en'),
    Locale('hi'),
    Locale('es'),
    Locale('pt'),
    Locale('ar'),
  ];

  static const languageCodes = ['en', 'hi', 'es', 'pt', 'ar'];

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  String _get(String key) {
    final lang = locale.languageCode;
    return translations[lang]?[key] ?? translations['en']![key]!;
  }

  String get appName => _get('appName');
  String get appNamePro => _get('appNamePro');
  String get splashTagline => _get('splashTagline');

  String get pasteLinkHint => _get('pasteLinkHint');
  String get pasteLinkTitle => _get('pasteLinkTitle');
  String get pasteLinkEmpty => _get('pasteLinkEmpty');
  String get openLink => _get('openLink');
  String get searchHint => _get('searchHint');

  String get videoPlayerCardTitle => _get('videoPlayerCardTitle');
  String get videoPlayerCardSubtitle => _get('videoPlayerCardSubtitle');
  String get videoDownloaderTitle => _get('videoDownloaderTitle');
  String get videoDownloaderSubtitle => _get('videoDownloaderSubtitle');

  String get tabHome => _get('tabHome');
  String get tabBrowser => _get('tabBrowser');
  String get tabDownloads => _get('tabDownloads');
  String get tabSettings => _get('tabSettings');

  String get historyTitle => _get('historyTitle');
  String get clearAll => _get('clearAll');
  String get noBrowsingHistory => _get('noBrowsingHistory');

  String get downloadsTitle => _get('downloadsTitle');
  String get processingTab => _get('processingTab');
  String get downloadedTab => _get('downloadedTab');
  String get emptyProcessing => _get('emptyProcessing');
  String get emptyDownloaded => _get('emptyDownloaded');

  String get settingsTitle => _get('settingsTitle');
  String get sectionShortcuts => _get('sectionShortcuts');
  String get sectionGeneral => _get('sectionGeneral');
  String get sectionMore => _get('sectionMore');

  String get ongoingNotification => _get('ongoingNotification');
  String get wifiOnly => _get('wifiOnly');
  String get syncGallery => _get('syncGallery');
  String get disclaimer => _get('disclaimer');
  String get howToDownload => _get('howToDownload');
  String get setupPasscode => _get('setupPasscode');
  String get language => _get('language');
  String get sendFeedback => _get('sendFeedback');
  String get rateUs => _get('rateUs');
  String get shareApp => _get('shareApp');
  String get privacyPolicy => _get('privacyPolicy');

  String get chooseLanguage => _get('chooseLanguage');
  String get langEnglish => _get('langEnglish');
  String get langHindi => _get('langHindi');
  String get langSpanish => _get('langSpanish');
  String get langPortuguese => _get('langPortuguese');
  String get langArabic => _get('langArabic');

  String languageNameFor(String code) => switch (code) {
        'hi' => langHindi,
        'es' => langSpanish,
        'pt' => langPortuguese,
        'ar' => langArabic,
        _ => langEnglish,
      };

  String get proBadge => _get('proBadge');
  String get benefitAdFree => _get('benefitAdFree');
  String get benefitDownloadAll => _get('benefitDownloadAll');
  String get benefitPlayer => _get('benefitPlayer');
  String get benefitHd => _get('benefitHd');
  String get noPaymentNow => _get('noPaymentNow');
  String get startFreeTrial => _get('startFreeTrial');
  String get renewNote => _get('renewNote');

  String get planWeekly => _get('planWeekly');
  String get planMonthly => _get('planMonthly');
  String get planYearly => _get('planYearly');
  String get planTrialSubtitle => _get('planTrialSubtitle');
  String get planWeeklyPrice => _get('planWeeklyPrice');
  String get planMonthlyPrice => _get('planMonthlyPrice');
  String get planYearlyPrice => _get('planYearlyPrice');
  String get bestValueTag => _get('bestValueTag');

  String get howToDownloadIntro => _get('howToDownloadIntro');
  String get disclaimerBody => _get('disclaimerBody');
  String get gotIt => _get('gotIt');
  String get method1 => _get('method1');
  String get method2 => _get('method2');
  String get htdMethod1Step => _get('htdMethod1Step');
  String get htdMethod2Step => _get('htdMethod2Step');
  String get mockAppTitle => _get('mockAppTitle');

  List<String> get howToDownloadSteps => [
        _get('howToStep1'),
        _get('howToStep2'),
        _get('howToStep3'),
        _get('howToStep4'),
      ];

  String get couldNotOpenLink => _get('couldNotOpenLink');
  String get passcodeComingSoon => _get('passcodeComingSoon');
  String get feedbackComingSoon => _get('feedbackComingSoon');
  String get shareAppMessage => _get('shareAppMessage');
  String selectedFile(String name) => _get('selectedFile').replaceAll('{name}', name);
  String get player => _get('player');
  String get missingVideoArgs => _get('missingVideoArgs');
  String unknownRoute(String? name) =>
      _get('unknownRoute').replaceAll('{route}', name ?? 'null');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.languageCodes.contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
