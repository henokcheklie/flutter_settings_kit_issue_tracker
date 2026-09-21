import 'package:flutter/material.dart';
import 'package:flutter_settings_kit/flutter_settings_kit.dart';

import 'l10n/fallback_locale_delegates.dart';
import 'l10n/gen/app_localizations.dart';
import 'settings_screen.dart';

void main() {
  runApp(const SettingsDemoApp());
}

/// Demonstrates every module of `flutter_settings_kit` wired into one
/// real settings screen: theme, locale, text scale, first-launch, app
/// info, and two custom settings built directly on the generic
/// `SettingController<T>` primitive — one device-scoped, one
/// session-scoped — to show the `resetAll()` / `resetSession()`
/// distinction from a "Reset app" button and a mock "Log out" button.
class SettingsDemoApp extends StatefulWidget {
  const SettingsDemoApp({super.key});

  @override
  State<SettingsDemoApp> createState() => _SettingsDemoAppState();
}

class _SettingsDemoAppState extends State<SettingsDemoApp> {
  final _theme = ThemeController();
  final _locale = LocaleController();
  final _textScale = TextScaleController();
  final _firstLaunch = FirstLaunchController();
  final _appInfo = AppInfoController();

  // A third type (Color) built directly on the generic primitive, same
  // as the two below — proving SettingController<T> isn't limited to
  // bool. Device-scoped (the default), since a seed color is a visual
  // preference like theme mode, not account data.
  final _seedColor = SettingController<Color>(
    defaultValue: Colors.teal,
    store: SharedPrefsSettingStore<Color>(
      key: 'example.seed_color',
      encode: (color) => color.toARGB32().toString(),
      decode: (raw) => Color(int.parse(raw)),
    ),
  );

  // Two custom settings demonstrating SettingController<T> directly,
  // one of each SettingScope — see SettingsScreen's account section for
  // where the scope distinction actually matters.
  final _analyticsOptIn = SettingController<bool>(
    defaultValue: true,
    store: SharedPrefsSettingStore<bool>(
      key: 'example.analytics_opt_in',
      encode: (isOptedIn) => isOptedIn.toString(),
      decode: (raw) => raw == 'true',
    ),
  );
  final _hideBalances = SettingController<bool>(
    defaultValue: false,
    store: SharedPrefsSettingStore<bool>(
      key: 'example.hide_balances',
      encode: (isHidden) => isHidden.toString(),
      decode: (raw) => raw == 'true',
    ),
    scope: SettingScope.session,
  );

  late final Listenable _appConfig = Listenable.merge([
    _theme,
    _locale,
    _seedColor,
  ]);

  @override
  void initState() {
    super.initState();
    _appConfig.addListener(_rebuild);
  }

  void _rebuild() => setState(() {});

  @override
  void dispose() {
    _appConfig.removeListener(_rebuild);
    _theme.dispose();
    _locale.dispose();
    _textScale.dispose();
    _firstLaunch.dispose();
    _seedColor.dispose();
    _analyticsOptIn.dispose();
    _hideBalances.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_settings_kit example',
      debugShowCheckedModeBanner: false,
      themeMode: _theme.themeMode,
      theme: ThemeController.lightTheme(seedColor: _seedColor.value),
      darkTheme: ThemeController.darkTheme(seedColor: _seedColor.value),
      locale: _locale.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: [
        ...AppLocalizations.localizationsDelegates,
        ...fallbackLocaleDelegates,
      ],
      home: ThemeScope(
        controller: _theme,
        child: LocaleScope(
          controller: _locale,
          child: TextScaleScope(
            controller: _textScale,
            child: AppInfoScope(
              controller: _appInfo,
              child: SettingsScreen(
                seedColor: _seedColor,
                firstLaunch: _firstLaunch,
                analyticsOptIn: _analyticsOptIn,
                hideBalances: _hideBalances,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
