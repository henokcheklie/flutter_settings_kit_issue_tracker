import 'package:flutter/foundation.dart';
import 'package:flutter_settings_kit/app_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

PackageInfo _fakePackageInfo() => PackageInfo(
  appName: 'My App',
  packageName: 'com.example.my_app',
  version: '1.2.3',
  buildNumber: '42',
);

void main() {
  group('AppInfoController', () {
    test('load() maps PackageInfo fields onto AppInfo', () async {
      final controller = AppInfoController(
        fetch: () async => _fakePackageInfo(),
      );

      final info = await controller.load();

      expect(
        info,
        const AppInfo(
          appName: 'My App',
          packageName: 'com.example.my_app',
          version: '1.2.3',
          buildNumber: '42',
        ),
      );
    });

    test('load() only calls fetch once, even for concurrent calls', () async {
      var fetchCount = 0;
      final controller = AppInfoController(
        fetch: () async {
          fetchCount++;
          return _fakePackageInfo();
        },
      );

      await Future.wait([
        controller.load(),
        controller.load(),
        controller.load(),
      ]);
      await controller.load();

      expect(fetchCount, 1);
    });

    test('load() returns the same cached Future instance', () {
      final controller = AppInfoController(
        fetch: () async => _fakePackageInfo(),
      );

      expect(controller.load(), same(controller.load()));
    });

    test('platform reflects defaultTargetPlatform', () {
      final controller = AppInfoController(
        fetch: () async => _fakePackageInfo(),
      );
      final previous = debugDefaultTargetPlatformOverride;
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      addTearDown(() => debugDefaultTargetPlatformOverride = previous);

      expect(controller.platform, AppPlatform.ios);
    });
  });

  group('AppInfo', () {
    test('equal snapshots compare equal', () {
      const a = AppInfo(
        appName: 'App',
        packageName: 'com.example.app',
        version: '1.0.0',
        buildNumber: '1',
      );
      const b = AppInfo(
        appName: 'App',
        packageName: 'com.example.app',
        version: '1.0.0',
        buildNumber: '1',
      );

      expect(a, b);
      expect(a.hashCode, b.hashCode);
    });
  });
}
