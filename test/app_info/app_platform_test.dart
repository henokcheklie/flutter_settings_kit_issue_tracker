import 'package:flutter/foundation.dart';
import 'package:flutter_settings_kit/app_info.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppPlatform.resolve', () {
    test('isWeb: true resolves to web regardless of targetPlatform', () {
      final platform = AppPlatform.resolve(
        isWeb: true,
        targetPlatform: TargetPlatform.android,
      );

      expect(platform, AppPlatform.web);
    });

    test('maps each TargetPlatform to the matching AppPlatform', () {
      const expected = {
        TargetPlatform.android: AppPlatform.android,
        TargetPlatform.iOS: AppPlatform.ios,
        TargetPlatform.linux: AppPlatform.linux,
        TargetPlatform.macOS: AppPlatform.macos,
        TargetPlatform.windows: AppPlatform.windows,
        TargetPlatform.fuchsia: AppPlatform.fuchsia,
      };

      for (final entry in expected.entries) {
        final resolved = AppPlatform.resolve(
          isWeb: false,
          targetPlatform: entry.key,
        );
        expect(resolved, entry.value, reason: 'for ${entry.key}');
      }
    });

    test('falls back to the real kIsWeb/defaultTargetPlatform', () {
      // On the VM (where `flutter test` runs), kIsWeb is false and
      // defaultTargetPlatform reflects the host OS — just check it
      // resolves to *something* without throwing.
      expect(AppPlatform.resolve(), isA<AppPlatform>());
    });
  });
}
