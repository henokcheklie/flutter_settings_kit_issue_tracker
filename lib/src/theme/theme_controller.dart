import 'package:flutter/material.dart';
import 'package:flutter_settings_kit/src/core/setting_controller.dart';
import 'package:flutter_settings_kit/src/core/setting_store.dart';
import 'package:flutter_settings_kit/src/core/shared_prefs_setting_store.dart';

const _storeKey = 'flutter_settings_kit.theme_mode';

/// A persisted [ThemeMode], with Material 3 theme-building helpers.
///
/// Device-scoped: survives logging out, since the next person using this
/// device likely wants the same light/dark preference. `MaterialApp`
/// already animates `themeMode` changes on its own (via its internal
/// `AnimatedTheme`), so switching through this controller is never a
/// hard cut.
class ThemeController extends SettingController<ThemeMode> {
  /// Creates a theme controller starting at [defaultValue] (defaults to
  /// following the system setting).
  ///
  /// Pass [store] to persist through something other than
  /// `shared_preferences`.
  ThemeController({
    super.defaultValue = ThemeMode.system,
    SettingStore<ThemeMode>? store,
  }) : super(
         store:
             store ??
             SharedPrefsSettingStore<ThemeMode>(
               key: _storeKey,
               encode: (mode) => mode.name,
               decode: ThemeMode.values.byName,
             ),
       );

  /// The current theme mode. Alias for [value].
  ThemeMode get themeMode => value;

  /// Sets the theme mode. Alias for [update].
  Future<void> setThemeMode(ThemeMode mode) => update(mode);

  /// Switches decisively between light and dark, resolving
  /// [ThemeMode.system] against the current platform brightness first.
  ///
  /// Use [setThemeMode] directly for a three-way light/dark/system
  /// control instead of a two-way switch.
  Future<void> toggleTheme() {
    final platformBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final isCurrentlyDark =
        themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            platformBrightness == Brightness.dark);
    return setThemeMode(isCurrentlyDark ? ThemeMode.light : ThemeMode.dark);
  }

  /// Builds a Material 3 light [ThemeData].
  ///
  /// Pass [dynamicScheme] (e.g. from `dynamic_color`'s
  /// `DynamicColorBuilder`) for Material You support — this package does
  /// not depend on `dynamic_color` itself, so wire it up in your own app
  /// if you want it; otherwise a scheme is derived from [seedColor].
  static ThemeData lightTheme({
    Color seedColor = Colors.deepPurple,
    ColorScheme? dynamicScheme,
  }) => _buildTheme(
    brightness: Brightness.light,
    seedColor: seedColor,
    dynamicScheme: dynamicScheme,
  );

  /// The dark counterpart of [lightTheme].
  static ThemeData darkTheme({
    Color seedColor = Colors.deepPurple,
    ColorScheme? dynamicScheme,
  }) => _buildTheme(
    brightness: Brightness.dark,
    seedColor: seedColor,
    dynamicScheme: dynamicScheme,
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color seedColor,
    required ColorScheme? dynamicScheme,
  }) {
    final colorScheme =
        dynamicScheme ??
        ColorScheme.fromSeed(seedColor: seedColor, brightness: brightness);
    return ThemeData(colorScheme: colorScheme);
  }
}
