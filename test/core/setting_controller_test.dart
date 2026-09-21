import 'package:flutter_settings_kit/core.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_setting_store.dart';

void main() {
  group('SettingController', () {
    test('starts at defaultValue before the store loads', () {
      final controller = SettingController<bool>(
        defaultValue: false,
        store: FakeSettingStore<bool>(),
      );

      expect(controller.value, isFalse);
    });

    test('adopts the persisted value once loaded', () async {
      final controller = SettingController<bool>(
        defaultValue: false,
        store: FakeSettingStore<bool>(initialValue: true),
      );

      await controller.ready;

      expect(controller.value, isTrue);
    });

    test('leaves value untouched when nothing is persisted yet', () async {
      final controller = SettingController<bool>(
        defaultValue: false,
        store: FakeSettingStore<bool>(),
      );

      await controller.ready;

      expect(controller.value, isFalse);
    });

    test('update() changes value, notifies listeners, and persists', () async {
      final store = FakeSettingStore<bool>(initialValue: false);
      final controller = SettingController<bool>(
        defaultValue: false,
        store: store,
      );
      await controller.ready;

      var notified = false;
      controller.addListener(() => notified = true);

      await controller.update(true);

      expect(controller.value, isTrue);
      expect(notified, isTrue);
      expect(store.writeCount, 1);
    });

    test('update() with the current value is a no-op', () async {
      final store = FakeSettingStore<bool>(initialValue: false);
      final controller = SettingController<bool>(
        defaultValue: false,
        store: store,
      );
      await controller.ready;

      var notified = false;
      controller.addListener(() => notified = true);

      await controller.update(false);

      expect(notified, isFalse);
      expect(store.writeCount, 0);
    });

    test('resetToDefault() restores default and clears the store', () async {
      final store = FakeSettingStore<bool>(initialValue: true);
      final controller = SettingController<bool>(
        defaultValue: false,
        store: store,
      );
      await controller.ready;
      expect(controller.value, isTrue);

      var notified = false;
      controller.addListener(() => notified = true);

      await controller.resetToDefault();

      expect(controller.value, isFalse);
      expect(notified, isTrue);
      expect(store.clearCount, 1);
    });

    test('resetToDefault() is a no-op when already at the default', () async {
      final store = FakeSettingStore<bool>(initialValue: false);
      final controller = SettingController<bool>(
        defaultValue: false,
        store: store,
      );
      await controller.ready;

      var notified = false;
      controller.addListener(() => notified = true);

      await controller.resetToDefault();

      expect(notified, isFalse);
      expect(store.clearCount, 0);
    });

    test('defaults scope to SettingScope.device', () {
      final controller = SettingController<bool>(
        defaultValue: false,
        store: FakeSettingStore<bool>(),
      );

      expect(controller.scope, SettingScope.device);
    });

    test('scope can be set to SettingScope.session', () {
      final controller = SettingController<bool>(
        defaultValue: false,
        store: FakeSettingStore<bool>(),
        scope: SettingScope.session,
      );

      expect(controller.scope, SettingScope.session);
    });
  });
}
