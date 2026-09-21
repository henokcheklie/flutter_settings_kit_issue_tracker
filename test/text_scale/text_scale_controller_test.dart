import 'package:flutter_settings_kit/core.dart';
import 'package:flutter_settings_kit/text_scale.dart';
import 'package:flutter_test/flutter_test.dart';

import '../core/fake_setting_store.dart';

void main() {
  group('TextScaleController', () {
    test('defaults to 1.0', () {
      final controller = TextScaleController(store: FakeSettingStore<double>());

      expect(controller.textScale, 1.0);
    });

    test('is device-scoped', () {
      final controller = TextScaleController(store: FakeSettingStore<double>());

      expect(controller.scope, SettingScope.device);
    });

    test('setTextScale updates textScale within range', () async {
      final controller = TextScaleController(store: FakeSettingStore<double>());

      await controller.setTextScale(1.2);

      expect(controller.textScale, 1.2);
    });

    test('setTextScale clamps above maxScale', () async {
      final controller = TextScaleController(store: FakeSettingStore<double>());

      await controller.setTextScale(5);

      expect(controller.textScale, controller.maxScale);
    });

    test('setTextScale clamps below minScale', () async {
      final controller = TextScaleController(store: FakeSettingStore<double>());

      await controller.setTextScale(0.1);

      expect(controller.textScale, controller.minScale);
    });

    test('a defaultValue outside the custom range is clamped', () {
      final controller = TextScaleController(
        defaultValue: 3,
        minScale: 0.9,
        maxScale: 1.1,
        store: FakeSettingStore<double>(),
      );

      expect(controller.textScale, 1.1);
    });

    test('honors custom minScale/maxScale', () async {
      final controller = TextScaleController(
        minScale: 1,
        maxScale: 2,
        store: FakeSettingStore<double>(),
      );

      await controller.setTextScale(0.5);
      expect(controller.textScale, 1);

      await controller.setTextScale(10);
      expect(controller.textScale, 2);
    });

    test('asserts minScale <= maxScale', () {
      expect(
        () => TextScaleController(
          minScale: 2,
          maxScale: 1,
          store: FakeSettingStore<double>(),
        ),
        throwsAssertionError,
      );
    });

    test('a persisted out-of-range value is clamped on load', () async {
      final store = FakeSettingStore<double>(initialValue: 5);

      final controller = TextScaleController(store: store);
      await controller.ready;

      expect(controller.textScale, controller.maxScale);
    });
  });
}
