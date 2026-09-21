import 'package:flutter/foundation.dart';

/// The platform the app is currently running on.
enum AppPlatform {
  /// Running on Android.
  android,

  /// Running on iOS.
  ios,

  /// Running on Linux.
  linux,

  /// Running on macOS.
  macos,

  /// Running on Windows.
  windows,

  /// Running on Fuchsia.
  fuchsia,

  /// Running in a web browser.
  web;

  /// Resolves the current platform from Flutter's own
  /// `defaultTargetPlatform` and `kIsWeb` — no extra dependency needed.
  ///
  /// Pass [isWeb]/[targetPlatform] to resolve against specific values
  /// (e.g. in a test) instead of the real ones.
  ///
  /// [isWeb] takes precedence: `defaultTargetPlatform` reports the
  /// underlying OS a browser is sniffed as when running on web, which
  /// isn't what a consumer displaying "Platform: Web" wants to see.
  static AppPlatform resolve({bool? isWeb, TargetPlatform? targetPlatform}) {
    if (isWeb ?? kIsWeb) {
      return AppPlatform.web;
    }
    return switch (targetPlatform ?? defaultTargetPlatform) {
      TargetPlatform.android => AppPlatform.android,
      TargetPlatform.iOS => AppPlatform.ios,
      TargetPlatform.linux => AppPlatform.linux,
      TargetPlatform.macOS => AppPlatform.macos,
      TargetPlatform.windows => AppPlatform.windows,
      TargetPlatform.fuchsia => AppPlatform.fuchsia,
    };
  }
}
