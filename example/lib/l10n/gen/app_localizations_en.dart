// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Settings Demo';

  @override
  String greeting(String name) {
    return 'Hello, $name!';
  }

  @override
  String get themeSectionTitle => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get seedColorLabel => 'Seed color';

  @override
  String get languageSectionTitle => 'Language';

  @override
  String get languageSystemDefault => 'System default';

  @override
  String get textSizeSectionTitle => 'Text size';

  @override
  String get textSizePreview => 'The quick brown fox jumps over the lazy dog.';

  @override
  String get aboutSectionTitle => 'About';

  @override
  String appVersionLabel(String version, String buildNumber) {
    return 'Version $version ($buildNumber)';
  }

  @override
  String platformLabel(String platform) {
    return 'Platform: $platform';
  }

  @override
  String get privacySectionTitle => 'Privacy';

  @override
  String get analyticsToggleLabel => 'Send anonymous analytics';

  @override
  String get analyticsToggleHelper => 'Device setting — survives logging out.';

  @override
  String get hideBalancesToggleLabel => 'Hide account balances';

  @override
  String get hideBalancesToggleHelper =>
      'Account setting — cleared when you log out.';

  @override
  String get accountSectionTitle => 'Account';

  @override
  String get logOutButton => 'Log out';

  @override
  String get resetAppButton => 'Reset app to defaults';

  @override
  String get firstLaunchWelcomeTitle => 'Welcome!';

  @override
  String get firstLaunchWelcomeBody =>
      'This banner only shows on the first launch.';

  @override
  String get firstLaunchDismiss => 'Got it';
}
