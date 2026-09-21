import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// `flutter_localizations`'s `GlobalMaterialLocalizations`,
/// `GlobalCupertinoLocalizations`, and `GlobalWidgetsLocalizations` only
/// ship translations for the languages the Flutter team maintains —
/// Afaan Oromo, Somali, and Tigrinya aren't among them, even though this
/// app's own `AppLocalizations` (generated from `lib/l10n/*.arb`) does
/// support all seven of this app's languages.
///
/// Without a fallback, picking one of those three crashes every Material
/// widget that looks up `MaterialLocalizations.of(context)` internally
/// (which is most of them, even for widgets with no visible text). These
/// three delegates fill that specific gap with English framework
/// strings — this app's *own* text still renders in the picked language
/// via `AppLocalizations`, which is unaffected since it's a separate
/// delegate.
///
/// Append these after `AppLocalizations.localizationsDelegates` so the
/// real, properly-translated delegates are always tried first.
const List<LocalizationsDelegate<Object?>> fallbackLocaleDelegates = [
  _FallbackMaterialLocalizationsDelegate(),
  _FallbackCupertinoLocalizationsDelegate(),
  _FallbackWidgetsLocalizationsDelegate(),
];

class _FallbackMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _FallbackMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      !GlobalMaterialLocalizations.delegate.isSupported(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      GlobalMaterialLocalizations.delegate.load(const Locale('en'));

  @override
  bool shouldReload(_FallbackMaterialLocalizationsDelegate old) => false;
}

class _FallbackCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _FallbackCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      !GlobalCupertinoLocalizations.delegate.isSupported(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      GlobalCupertinoLocalizations.delegate.load(const Locale('en'));

  @override
  bool shouldReload(_FallbackCupertinoLocalizationsDelegate old) => false;
}

class _FallbackWidgetsLocalizationsDelegate
    extends LocalizationsDelegate<WidgetsLocalizations> {
  const _FallbackWidgetsLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      !GlobalWidgetsLocalizations.delegate.isSupported(locale);

  @override
  Future<WidgetsLocalizations> load(Locale locale) =>
      GlobalWidgetsLocalizations.delegate.load(const Locale('en'));

  @override
  bool shouldReload(_FallbackWidgetsLocalizationsDelegate old) => false;
}
