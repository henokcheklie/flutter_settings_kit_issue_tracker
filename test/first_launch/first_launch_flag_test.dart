import 'package:flutter_settings_kit/core.dart';
import 'package:flutter_settings_kit/first_launch.dart';
import 'package:flutter_test/flutter_test.dart';

import '../core/fake_setting_store.dart';

void main() {
  group('FirstLaunchController', () {
    test('defaults to true', () {
      final controller = FirstLaunchController(store: FakeSettingStore<bool>());

      expect(controller.isFirstLaunch, isTrue);
    });

    test('is device-scoped', () {
      final controller = FirstLaunchController(store: FakeSettingStore<bool>());

      expect(controller.scope, SettingScope.device);
    });

    test('markLaunched sets isFirstLaunch to false', () async {
      final controller = FirstLaunchController(store: FakeSettingStore<bool>());

      await controller.markLaunched();

      expect(controller.isFirstLaunch, isFalse);
    });

    test('a persisted false value is honored on load', () async {
      final store = FakeSettingStore<bool>(initialValue: false);

      final controller = FirstLaunchController(store: store);
      await controller.ready;

      expect(controller.isFirstLaunch, isFalse);
    });

    test('resetToDefault() reverts to first-launch again', () async {
      final controller = FirstLaunchController(store: FakeSettingStore<bool>());
      await controller.markLaunched();
      expect(controller.isFirstLaunch, isFalse);

      await controller.resetToDefault();

      expect(controller.isFirstLaunch, isTrue);
    });
  });
}
