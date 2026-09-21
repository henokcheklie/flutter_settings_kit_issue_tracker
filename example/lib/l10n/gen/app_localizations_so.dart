// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Somali (`so`).
class AppLocalizationsSo extends AppLocalizations {
  AppLocalizationsSo([String locale = 'so']) : super(locale);

  @override
  String get appTitle => 'Tusaalaha Dejinta';

  @override
  String greeting(String name) {
    return 'Salaan, $name!';
  }

  @override
  String get themeSectionTitle => 'Muuqaalka';

  @override
  String get themeSystem => 'Nidaamka';

  @override
  String get themeLight => 'Iftiin';

  @override
  String get themeDark => 'Madow';

  @override
  String get seedColorLabel => 'Midabka aasaasiga ah';

  @override
  String get languageSectionTitle => 'Luqadda';

  @override
  String get languageSystemDefault => 'Ka caadiga ah ee nidaamka';

  @override
  String get textSizeSectionTitle => 'Cabbirka qoraalka';

  @override
  String get textSizePreview => 'Kani waa tusaale cabbirka qoraalka.';

  @override
  String get aboutSectionTitle => 'Ku saabsan';

  @override
  String appVersionLabel(String version, String buildNumber) {
    return 'Nooca $version ($buildNumber)';
  }

  @override
  String platformLabel(String platform) {
    return 'Madasha: $platform';
  }

  @override
  String get privacySectionTitle => 'Asturnaanta';

  @override
  String get analyticsToggleLabel => 'Dir tirakoob la\'aan magac';

  @override
  String get analyticsToggleHelper =>
      'Dejinta qalabka — way sii jirtaa kadib markaad ka baxdo.';

  @override
  String get hideBalancesToggleLabel => 'Qari hadhaaga koontada';

  @override
  String get hideBalancesToggleHelper =>
      'Dejinta koontada — waa la tirtiraa marka aad ka baxdo.';

  @override
  String get accountSectionTitle => 'Koontada';

  @override
  String get logOutButton => 'Ka bax';

  @override
  String get resetAppButton => 'Dib u deji app-ka';

  @override
  String get firstLaunchWelcomeTitle => 'Soo dhowow!';

  @override
  String get firstLaunchWelcomeBody =>
      'Ogeysiiskan wuxuu muuqdaa markii ugu horreysa oo keliya.';

  @override
  String get firstLaunchDismiss => 'Waan fahmay';
}
