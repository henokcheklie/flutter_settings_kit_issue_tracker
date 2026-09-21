# 0.0.1

Initial release.

- `core`: the generic `SettingController<T>` / `SettingStore<T>` primitive, `SettingScope` (`device`/`session`), `SharedPrefsSettingStore<T>`, and `resetAll()` / `resetSession()`.
- `theme`: `ThemeController` (persisted `ThemeMode`, device-scoped), `ThemeController.lightTheme()`/`darkTheme()` Material 3 builders with optional `dynamic_color` interop, `ThemeScope`.
- `locale`: `LocaleController` (persisted `Locale?`, `null` = follow system, device-scoped), `LocaleScope`.
- `text_scale`: `TextScaleController` (persisted, clamped text-scale multiplier, device-scoped), `TextScaleScope` (applies the scale via `MediaQuery` automatically).
- `first_launch`: `FirstLaunchController` (device-scoped onboarding flag).
- `app_info`: `AppInfoController` (cached `AppInfo` snapshot via `package_info_plus`) and `AppPlatform` (resolved from `defaultTargetPlatform`/`kIsWeb`, no extra dependency).
