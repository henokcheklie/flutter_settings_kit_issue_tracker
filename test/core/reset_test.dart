import 'package:flutter_settings_kit/core.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_setting_store.dart';

void main() {
  group('resetAll', () {
    test('resets every controller regardless of scope', () async {
      final device = SettingController<bool>(
        defaultValue: false,
        store: FakeSettingStore<bool>(initialValue: true),
      );
      final session = SettingController<bool>(
        defaultValue: false,
        store: FakeSettingStore<bool>(initialValue: true),
        scope: SettingScope.session,
      );
      await device.ready;
      await session.ready;

      await resetAll([device, session]);

      expect(device.value, isFalse);
      expect(session.value, isFalse);
    });
  });

  group('resetSession', () {
    test('resets only session-scoped controllers', () async {
      final device = SettingController<bool>(
        defaultValue: false,
        store: FakeSettingStore<bool>(initialValue: true),
      );
      final session = SettingController<bool>(
        defaultValue: false,
        store: FakeSettingStore<bool>(initialValue: true),
        scope: SettingScope.session,
      );
      await device.ready;
      await session.ready;

      await resetSession([device, session]);

      expect(
        device.value,
        isTrue,
        reason: 'device-scoped settings must survive logout',
      );
      expect(session.value, isFalse);
    });

    test('is a no-op given only device-scoped controllers', () async {
      final device = SettingController<bool>(
        defaultValue: false,
        store: FakeSettingStore<bool>(initialValue: true),
      );
      await device.ready;

      await resetSession([device]);

      expect(device.value, isTrue);
    });
  });
}
