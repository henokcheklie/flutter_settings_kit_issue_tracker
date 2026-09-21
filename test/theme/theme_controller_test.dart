import 'package:flutter/material.dart';
import 'package:flutter_settings_kit/core.dart';
import 'package:flutter_settings_kit/theme.dart';
import 'package:flutter_test/flutter_test.dart';

import '../core/fake_setting_store.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() {
    TestWidgetsFlutterBinding.instance.platformDispatcher.clearAllTestValues();
  });

  group('ThemeController', () {
    test('defaults to ThemeMode.system', () {
      final controller = ThemeController(store: FakeSettingStore<ThemeMode>());

      expect(controller.themeMode, ThemeMode.system);
    });

    test('is device-scoped', () {
      final controller = ThemeController(store: FakeSettingStore<ThemeMode>());

      expect(controller.scope, SettingScope.device);
    });

    test('setThemeMode updates themeMode', () async {
      final controller = ThemeController(store: FakeSettingStore<ThemeMode>());

      await controller.setThemeMode(ThemeMode.dark);

      expect(controller.themeMode, ThemeMode.dark);
    });

    test('toggleTheme flips light to dark', () async {
      final controller = ThemeController(
        defaultValue: ThemeMode.light,
        store: FakeSettingStore<ThemeMode>(),
      );

      await controller.toggleTheme();

      expect(controller.themeMode, ThemeMode.dark);
    });

    test('toggleTheme flips dark to light', () async {
      final controller = ThemeController(
        defaultValue: ThemeMode.dark,
        store: FakeSettingStore<ThemeMode>(),
      );

      await controller.toggleTheme();

      expect(controller.themeMode, ThemeMode.light);
    });

    test('toggleTheme resolves system-light to dark', () async {
      TestWidgetsFlutterBinding
              .instance
              .platformDispatcher
              .platformBrightnessTestValue =
          Brightness.light;
      final controller = ThemeController(store: FakeSettingStore<ThemeMode>());

      await controller.toggleTheme();

      expect(controller.themeMode, ThemeMode.dark);
    });

    test('toggleTheme resolves system-dark to light', () async {
      TestWidgetsFlutterBinding
              .instance
              .platformDispatcher
              .platformBrightnessTestValue =
          Brightness.dark;
      final controller = ThemeController(store: FakeSettingStore<ThemeMode>());

      await controller.toggleTheme();

      expect(controller.themeMode, ThemeMode.light);
    });
  });

  group('ThemeController.lightTheme / darkTheme', () {
    test('lightTheme derives a light ColorScheme from seedColor', () {
      final theme = ThemeController.lightTheme(seedColor: Colors.teal);

      expect(theme.colorScheme.brightness, Brightness.light);
    });

    test('darkTheme derives a dark ColorScheme from seedColor', () {
      final theme = ThemeController.darkTheme(seedColor: Colors.teal);

      expect(theme.colorScheme.brightness, Brightness.dark);
    });

    test('a provided dynamicScheme takes precedence over seedColor', () {
      const dynamicScheme = ColorScheme.light(primary: Colors.pink);

      final theme = ThemeController.lightTheme(dynamicScheme: dynamicScheme);

      expect(theme.colorScheme, dynamicScheme);
    });
  });
}
