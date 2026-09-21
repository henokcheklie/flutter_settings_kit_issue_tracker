import 'package:flutter/foundation.dart';

/// A snapshot of the running app's package metadata.
@immutable
class AppInfo {
  /// Creates an app info snapshot.
  const AppInfo({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
  });

  /// The app's display name, e.g. "My App".
  final String appName;

  /// The app's package/bundle identifier, e.g. "com.example.myApp".
  final String packageName;

  /// The app's version string, e.g. "1.2.3".
  final String version;

  /// The app's build number, e.g. "42".
  final String buildNumber;

  @override
  String toString() =>
      'AppInfo(appName: $appName, packageName: $packageName, '
      'version: $version, buildNumber: $buildNumber)';

  @override
  bool operator ==(Object other) =>
      other is AppInfo &&
      other.appName == appName &&
      other.packageName == packageName &&
      other.version == version &&
      other.buildNumber == buildNumber;

  @override
  int get hashCode => Object.hash(appName, packageName, version, buildNumber);
}
