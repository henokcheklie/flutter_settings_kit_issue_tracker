import 'package:flutter/widgets.dart';
import 'package:flutter_settings_kit/src/core/setting_controller.dart';
import 'package:flutter_settings_kit/src/core/setting_store.dart';
import 'package:flutter_settings_kit/src/core/shared_prefs_setting_store.dart';

const _storeKey = 'flutter_settings_kit.locale';

/// A persisted, optional [Locale] override.
///
/// `null` means "follow the system locale" — pass [locale] straight
/// through to `MaterialApp(locale: ...)`: when it's `null`, Flutter's own
/// locale resolution (matching the system locale against
/// `supportedLocales`) takes over, and `MaterialApp` also derives
/// RTL/LTR text direction automatically from whichever locale ends up
/// resolved. This controller only tracks *which* locale the user picked
/// — nothing else needs reimplementing.
///
/// Device-scoped: survives logging out, since the next person using this
/// device likely wants the same language.
class LocaleController extends SettingController<Locale?> {
  /// Creates a locale controller starting at [defaultValue] (`null` by
  /// default, meaning "follow the system locale").
  ///
  /// Pass [store] to persist through something other than
  /// `shared_preferences`.
  // A super parameter here would need an explicit `= null` default to go
  // from required to optional, which avoid_init_to_null then flags as
  // redundant — so this stays a manually forwarded parameter.
  // ignore: use_super_parameters
  LocaleController({Locale? defaultValue, SettingStore<Locale?>? store})
    : super(
        defaultValue: defaultValue,
        store:
            store ??
            SharedPrefsSettingStore<Locale?>(
              key: _storeKey,
              encode: (locale) => locale?.toLanguageTag() ?? '',
              decode: (raw) => raw.isEmpty ? null : _localeFromLanguageTag(raw),
            ),
      );

  /// The current locale override, or `null` to follow the system locale.
  /// Alias for [value].
  Locale? get locale => value;

  /// Sets an explicit locale override. Alias for [update].
  Future<void> setLocale(Locale? locale) => update(locale);

  /// Clears any explicit override, going back to following the system
  /// locale.
  Future<void> resetToSystemLocale() => update(null);
}

Locale _localeFromLanguageTag(String tag) {
  final subtags = tag.split('-');
  final languageCode = subtags.first;
  String? scriptCode;
  String? countryCode;
  for (final subtag in subtags.skip(1)) {
    if (subtag.length == 4) {
      scriptCode = subtag;
    } else {
      countryCode = subtag;
    }
  }
  return Locale.fromSubtags(
    languageCode: languageCode,
    scriptCode: scriptCode,
    countryCode: countryCode,
  );
}
