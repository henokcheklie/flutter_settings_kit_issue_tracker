// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tigrinya (`ti`).
class AppLocalizationsTi extends AppLocalizations {
  AppLocalizationsTi([String locale = 'ti']) : super(locale);

  @override
  String get appTitle => 'ናይ ቅጥዕታት ምርኢት';

  @override
  String greeting(String name) {
    return 'ሰላም፣ $name!';
  }

  @override
  String get themeSectionTitle => 'ትርኢት';

  @override
  String get themeSystem => 'ስርዓት';

  @override
  String get themeLight => 'ብሩህ';

  @override
  String get themeDark => 'ጸልማት';

  @override
  String get seedColorLabel => 'መሰረታዊ ሕብሪ';

  @override
  String get languageSectionTitle => 'ቋንቋ';

  @override
  String get languageSystemDefault => 'ናይ ስርዓት ነባሪ';

  @override
  String get textSizeSectionTitle => 'መጠን ጽሑፍ';

  @override
  String get textSizePreview => 'እዚ ናይ ጽሑፍ መጠን ኣብነት እዩ።';

  @override
  String get aboutSectionTitle => 'ብዛዕባ';

  @override
  String appVersionLabel(String version, String buildNumber) {
    return 'ስሪት $version ($buildNumber)';
  }

  @override
  String platformLabel(String platform) {
    return 'መድረኽ፦ $platform';
  }

  @override
  String get privacySectionTitle => 'ውልቃዊነት';

  @override
  String get analyticsToggleLabel => 'ስም-ኣልቦ ስታትስቲክስ ስደድ';

  @override
  String get analyticsToggleHelper => 'ናይ መሳርሒ ቅጥዕ — ድሕሪ ምውጻእካ ይቕጽል።';

  @override
  String get hideBalancesToggleLabel => 'ተረፍ ሒሳብ ሕባእ';

  @override
  String get hideBalancesToggleHelper => 'ናይ መለያ ቅጥዕ — ክትወጽእ ከለኻ ይድምሰስ።';

  @override
  String get accountSectionTitle => 'መለያ';

  @override
  String get logOutButton => 'ውጻእ';

  @override
  String get resetAppButton => 'መተግበሪ ዳግማይ ኣጀምር';

  @override
  String get firstLaunchWelcomeTitle => 'እንቋዕ ብደሓን መጻእካ!';

  @override
  String get firstLaunchWelcomeBody => 'እዚ መልእኽቲ እዚ ንመጀመርታ ግዜ ጥራይ ይረአ።';

  @override
  String get firstLaunchDismiss => 'ተረዲኡኒ';
}
