// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Amharic (`am`).
class AppLocalizationsAm extends AppLocalizations {
  AppLocalizationsAm([String locale = 'am']) : super(locale);

  @override
  String get appTitle => 'ቅንብሮች ማሳያ';

  @override
  String greeting(String name) {
    return 'ሰላም፣ $name!';
  }

  @override
  String get themeSectionTitle => 'ገጽታ';

  @override
  String get themeSystem => 'ስርዓት';

  @override
  String get themeLight => 'ብሩህ';

  @override
  String get themeDark => 'ጥቁር';

  @override
  String get seedColorLabel => 'መሰረታዊ ቀለም';

  @override
  String get languageSectionTitle => 'ቋንቋ';

  @override
  String get languageSystemDefault => 'የስርዓት ነባሪ';

  @override
  String get textSizeSectionTitle => 'የጽሑፍ መጠን';

  @override
  String get textSizePreview => 'ይህ የጽሑፍ መጠን ማሳያ ነው።';

  @override
  String get aboutSectionTitle => 'ስለ መተግበሪያው';

  @override
  String appVersionLabel(String version, String buildNumber) {
    return 'ስሪት $version ($buildNumber)';
  }

  @override
  String platformLabel(String platform) {
    return 'መድረክ፦ $platform';
  }

  @override
  String get privacySectionTitle => 'ግላዊነት';

  @override
  String get analyticsToggleLabel => 'ስም-አልባ ስታትስቲክስ ላክ';

  @override
  String get analyticsToggleHelper => 'የመሳሪያ ቅንብር — ከወጣህ በኋላም ይቆያል።';

  @override
  String get hideBalancesToggleLabel => 'የመለያ ቀሪ ሂሳብ ደብቅ';

  @override
  String get hideBalancesToggleHelper => 'የመለያ ቅንብር — ስትወጣ ይሰረዛል።';

  @override
  String get accountSectionTitle => 'መለያ';

  @override
  String get logOutButton => 'ውጣ';

  @override
  String get resetAppButton => 'መተግበሪያውን ዳግም አስጀምር';

  @override
  String get firstLaunchWelcomeTitle => 'እንኳን ደህና መጣህ!';

  @override
  String get firstLaunchWelcomeBody => 'ይህ ማሳወቂያ የሚታየው ለመጀመሪያ ጊዜ ብቻ ነው።';

  @override
  String get firstLaunchDismiss => 'ገባኝ';
}
