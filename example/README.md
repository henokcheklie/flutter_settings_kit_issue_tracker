# flutter_settings_kit example

A single settings screen wiring every module of `flutter_settings_kit` together: theme (mode + seed color), locale, text scale, first launch, app info, and two custom settings built directly on the generic `SettingController<T>` primitive — one device-scoped, one session-scoped — to demonstrate the `resetSession()` (Log out) / `resetAll()` (Reset app) distinction.

## Running it

```bash
flutter pub get
flutter run
```

## Languages

The language picker offers 7 languages via a real `gen-l10n`/ARB setup (`lib/l10n/*.arb`, configured in `l10n.yaml`): English, French, Arabic (proves RTL support), Amharic, Tigrinya, Afaan Oromo, and Somali. The Amharic/Tigrinya/Afaan Oromo/Somali translations are AI best-effort, not reviewed by a native speaker.

### Why `lib/l10n/fallback_locale_delegates.dart` exists

Flutter's own `flutter_localizations` package (`GlobalMaterialLocalizations`, `GlobalCupertinoLocalizations`, `GlobalWidgetsLocalizations`) only ships translations for the languages the Flutter team maintains — **Afaan Oromo, Somali, and Tigrinya aren't among them**, even though this app's own ARB-based `AppLocalizations` supports all 7. Without a fallback, picking one of those three crashes with "No MaterialLocalizations found" (most Material widgets look this up internally, even ones with no visible text).

`fallback_locale_delegates.dart` adds a second delegate per type (Material/Cupertino/Widgets) that only activates when the real one doesn't support the locale, falling back to English for Flutter's own framework strings (OK/Cancel, date pickers, ...) while this app's own text still renders correctly in the picked language via `AppLocalizations`. `test/widget_test.dart`'s "switching to every supported language does not throw" test is a regression guard for this.
