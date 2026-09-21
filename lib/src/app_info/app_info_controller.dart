import 'package:flutter_settings_kit/src/app_info/app_info.dart';
import 'package:flutter_settings_kit/src/app_info/app_platform.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// A cached snapshot of the running app's package metadata (name,
/// package id, version, build number), plus the current [platform].
///
/// Unlike the other controllers in this package, this isn't a
/// persisted, user-editable setting — it's read-only data about the
/// build itself. The package metadata is fetched once via
/// `package_info_plus` (the maintained, federated-plugin standard for
/// this — reimplementing its native platform channel code per platform
/// isn't worth it) and cached in memory for the life of the app, so
/// repeated reads never repeat the platform-channel call. [platform] is
/// resolved synchronously from Flutter's own `defaultTargetPlatform` /
/// `kIsWeb` — no extra dependency or async wait needed for that part.
class AppInfoController {
  /// Creates an app info controller.
  ///
  /// Pass [fetch] to read from something other than the real platform
  /// channel — e.g. in tests, or if your app already has this data
  /// another way.
  AppInfoController({Future<PackageInfo> Function()? fetch})
    : _fetch = fetch ?? PackageInfo.fromPlatform;

  final Future<PackageInfo> Function() _fetch;
  Future<AppInfo>? _cached;

  /// The platform this app is currently running on.
  AppPlatform get platform => AppPlatform.resolve();

  /// The app's package metadata. The underlying platform read happens
  /// once — this call, and every concurrent or later call, returns the
  /// same cached [Future].
  Future<AppInfo> load() => _cached ??= _load();

  Future<AppInfo> _load() async {
    final info = await _fetch();
    return AppInfo(
      appName: info.appName,
      packageName: info.packageName,
      version: info.version,
      buildNumber: info.buildNumber,
    );
  }
}
