// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Démo de paramètres';

  @override
  String greeting(String name) {
    return 'Bonjour, $name !';
  }

  @override
  String get themeSectionTitle => 'Thème';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get seedColorLabel => 'Couleur de base';

  @override
  String get languageSectionTitle => 'Langue';

  @override
  String get languageSystemDefault => 'Par défaut du système';

  @override
  String get textSizeSectionTitle => 'Taille du texte';

  @override
  String get textSizePreview =>
      'Portez ce vieux whisky au juge blond qui fume.';

  @override
  String get aboutSectionTitle => 'À propos';

  @override
  String appVersionLabel(String version, String buildNumber) {
    return 'Version $version ($buildNumber)';
  }

  @override
  String platformLabel(String platform) {
    return 'Plateforme : $platform';
  }

  @override
  String get privacySectionTitle => 'Confidentialité';

  @override
  String get analyticsToggleLabel => 'Envoyer des statistiques anonymes';

  @override
  String get analyticsToggleHelper =>
      'Paramètre de l\'appareil — conservé après déconnexion.';

  @override
  String get hideBalancesToggleLabel => 'Masquer les soldes du compte';

  @override
  String get hideBalancesToggleHelper =>
      'Paramètre du compte — effacé à la déconnexion.';

  @override
  String get accountSectionTitle => 'Compte';

  @override
  String get logOutButton => 'Se déconnecter';

  @override
  String get resetAppButton => 'Réinitialiser l\'application';

  @override
  String get firstLaunchWelcomeTitle => 'Bienvenue !';

  @override
  String get firstLaunchWelcomeBody =>
      'Cette bannière ne s\'affiche qu\'au premier lancement.';

  @override
  String get firstLaunchDismiss => 'Compris';
}
