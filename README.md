# flutter_settings_kit — Issue Tracker

This repository is used for filing issues, bugs, and feature requests for [`flutter_settings_kit`](https://pub.dev/packages/flutter_settings_kit).

# ✨ flutter_settings_kit

![Pub Version](https://img.shields.io/pub/v/flutter_settings_kit)
![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)

Persisted theme, locale, text scale, and app-settings primitives for Flutter — with **zero forced dependencies** on any state-management framework. Stop re-implementing theme/language switching by hand in every app.

## Table of contents

- [Features](#features)
- [Getting started](#getting-started)
- [Usage](#usage)
  - [Quick start](#quick-start)
  - [Theme](#theme)
  - [Locale](#locale)
  - [Text scale](#text-scale)
  - [First launch](#first-launch)
  - [App info](#app-info)
  - [Define your own setting](#define-your-own-setting)
  - [Resetting settings](#resetting-settings)
- [Additional information](#additional-information)
- [License](#license)
- [Contributions](#contributions)
- [Contact information](#contact-information)
- [Issues and feedback](#issues-and-feedback)

## 🌟 Features

- **Theme:** persisted `ThemeMode` (light/dark/system), Material 3 helpers, no-restart switching.
- **Locale:** persisted `Locale?` override (`null` = follow the system), standard `gen-l10n`/ARB workflow, automatic RTL.
- **Text scale:** a persisted, clamped accessibility text-scale multiplier, applied automatically via `MediaQuery`.
- **First launch:** a ready-made flag for driving an onboarding flow.
- **App info:** cached app name/version/build number (via `package_info_plus`) plus the current platform, with zero extra dependency for the platform part.
- **A generic `SettingController<T>` primitive:** every module above is a thin specialization of it, and it's public: define your *own* persisted settings (an analytics opt-in, a "hide balances" toggle, ...) with the same ergonomics, no extra plumbing.
- **`resetAll()` / `resetSession()`:** a factory-reset button and a logout button are different operations. Tag a setting `SettingScope.device` (the default — survives logout) or `SettingScope.session` (cleared on logout), and reset accordingly.
- **No state-management dependency:** Built on Flutter's own `ChangeNotifier` + `ListenableBuilder`/`InheritedNotifier`, so it works whether your app uses Provider, Riverpod, Bloc, or nothing.

## 🎖 Getting started

```yaml
dependencies:
  flutter_settings_kit: ^0.0.1
```

Import only what you need:

```dart
import 'package:flutter_settings_kit/theme.dart';        // theme only
import 'package:flutter_settings_kit/locale.dart';        // locale only
import 'package:flutter_settings_kit/text_scale.dart';    // text scale only
import 'package:flutter_settings_kit/first_launch.dart';  // first-launch flag only
import 'package:flutter_settings_kit/app_info.dart';      // app info only
import 'package:flutter_settings_kit/core.dart';           // the generic SettingController<T> primitive only

import 'package:flutter_settings_kit/flutter_settings_kit.dart'; // everything
```

## 🎮 Usage

### Quick start

Create your controllers once, wrap your app in the matching `Scope` widgets, and wire `MaterialApp` straight to them:

```dart
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _theme = ThemeController();
  final _locale = LocaleController();

  @override
  void dispose() {
    _theme.dispose();
    _locale.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([_theme, _locale]),
      builder: (context, _) => MaterialApp(
        themeMode: _theme.themeMode,
        theme: ThemeController.lightTheme(seedColor: Colors.teal),
        darkTheme: ThemeController.darkTheme(seedColor: Colors.teal),
        locale: _locale.locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: ThemeScope(
          controller: _theme,
          child: LocaleScope(controller: _locale, child: const HomeScreen()),
        ),
      ),
    );
  }
}
```

Any descendant can then read (and react to) a controller without prop-drilling:

```dart
final theme = ThemeScope.of(context);
ElevatedButton(onPressed: theme.toggleTheme, child: const Text('Toggle theme'));
```

See `/example` for a complete settings screen wiring every module together, including a 7-language `gen-l10n` setup (with RTL via Arabic).

### Theme

```dart
final theme = ThemeController(); // defaults to ThemeMode.system
await theme.setThemeMode(ThemeMode.dark);
await theme.toggleTheme(); // resolves `system` against real platform brightness first
```

### Locale

```dart
final locale = LocaleController(); // null = follow the system locale
await locale.setLocale(const Locale('fr'));
await locale.resetToSystemLocale();
```

`MaterialApp`'s own locale resolution (matched against `supportedLocales`) and RTL handling take over for free — this controller only tracks which locale the user picked.

### Text scale

```dart
final textScale = TextScaleController(); // 1.0 by default, clamped 0.8–1.6
await textScale.setTextScale(1.2);
```

Wrap with `TextScaleScope` and the scale applies to the whole subtree automatically — no manual `MediaQuery` wiring:

```dart
TextScaleScope(controller: textScale, child: MaterialApp(...));
```

### First launch

```dart
final firstLaunch = FirstLaunchController(); // true until markLaunched() is called
if (firstLaunch.isFirstLaunch) {
  await firstLaunch.markLaunched();
  // show onboarding
}
```

### App info

```dart
final appInfo = AppInfoController();
final info = await appInfo.load(); // cached — only reads the platform once
print('${info.appName} ${info.version} (${info.buildNumber})');
print(appInfo.platform); // AppPlatform.android / .ios / .web / ...
```

### Define your own setting

Every controller above is a thin wrapper over the same public primitive:

```dart
final analyticsOptIn = SettingController<bool>(
  defaultValue: true,
  store: SharedPrefsSettingStore<bool>(
    key: 'analytics_opt_in',
    encode: (v) => v.toString(),
    decode: (raw) => raw == 'true',
  ),
);

await analyticsOptIn.update(false);
```

### Resetting settings

```dart
final settings = [theme, locale, textScale, analyticsOptIn, hideBalances];

// Factory reset — everything, regardless of scope.
await resetAll(settings);

// Logout — only SettingScope.session-scoped settings. Theme/locale/text
// scale stay untouched, since they default to SettingScope.device.
await resetSession(settings);
```

Tag your own settings `scope: SettingScope.session` if they should clear on logout instead of surviving it.

## 🔹 Additional information

- `/example` is a full demo app: theme + seed-color picker, a 7-language dropdown (English, French, Arabic, Amharic, Tigrinya, Afaan Oromo, Somali — proving RTL via Arabic), a text-scale slider, an About section, and a "Log out" / "Reset app" pair demonstrating the `resetSession()` / `resetAll()` distinction.

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

## 🤝 Contributions

This is a private project maintained by Henok Cheklie. Contributions are currently not accepted.

## 📬 Contact Information

- **Author**: Henok Cheklie
- **Email**: <henokcheklie@gmail.com>
- **Package**: flutter_settings_kit

## 🐞 Issues and Feedback

Please file issues, bugs, or feature requests in our [issue tracker](https://github.com/henokcheklie/flutter_settings_kit_issue_tracker).

