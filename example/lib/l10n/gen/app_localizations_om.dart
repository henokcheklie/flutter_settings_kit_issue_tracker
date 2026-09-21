// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Oromo (`om`).
class AppLocalizationsOm extends AppLocalizations {
  AppLocalizationsOm([String locale = 'om']) : super(locale);

  @override
  String get appTitle => 'Fakkeenya Qindaa\'ina';

  @override
  String greeting(String name) {
    return 'Akkam, $name!';
  }

  @override
  String get themeSectionTitle => 'Bifa';

  @override
  String get themeSystem => 'Sirna';

  @override
  String get themeLight => 'Ifaa';

  @override
  String get themeDark => 'Dukkanaa\'aa';

  @override
  String get seedColorLabel => 'Halluu bu\'uuraa';

  @override
  String get languageSectionTitle => 'Afaan';

  @override
  String get languageSystemDefault => 'Sirna ittiin dhufe';

  @override
  String get textSizeSectionTitle => 'Guddina barruu';

  @override
  String get textSizePreview => 'Kun fakkeenya guddina barruu ti.';

  @override
  String get aboutSectionTitle => 'Waa\'ee';

  @override
  String appVersionLabel(String version, String buildNumber) {
    return 'Fooyya\'iinsa $version ($buildNumber)';
  }

  @override
  String platformLabel(String platform) {
    return 'Sarara: $platform';
  }

  @override
  String get privacySectionTitle => 'Dhuunfaa';

  @override
  String get analyticsToggleLabel => 'Ragaa maqaa hin qabne ergi';

  @override
  String get analyticsToggleHelper =>
      'Qindaa\'ina meeshaa — erga ba\'uu keetii boodas ni turtii.';

  @override
  String get hideBalancesToggleLabel => 'Hafteen herrega dhoksi';

  @override
  String get hideBalancesToggleHelper =>
      'Qindaa\'ina herregaa — yeroo ba\'uu keetii ni haqama.';

  @override
  String get accountSectionTitle => 'Herrega';

  @override
  String get logOutButton => 'Ba\'i';

  @override
  String get resetAppButton => 'Aappii haaromsi';

  @override
  String get firstLaunchWelcomeTitle => 'Baga nagaan dhuftan!';

  @override
  String get firstLaunchWelcomeBody =>
      'Ibsi kun kan mul\'atu yeroo jalqabaa qofa.';

  @override
  String get firstLaunchDismiss => 'Hubadheera';
}
