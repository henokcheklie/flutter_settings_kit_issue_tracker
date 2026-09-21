import 'package:flutter/material.dart';
import 'package:flutter_settings_kit/core.dart';
import 'package:flutter_settings_kit/first_launch.dart';
import 'package:flutter_settings_kit/locale.dart';
import 'package:flutter_settings_kit/text_scale.dart';
import 'package:flutter_settings_kit/theme.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_setting_store.dart';

void main() {
  group('resetAll / resetSession with a real mix of controllers', () {
    test('resetAll reverts every built-in and custom controller', () async {
      final theme = ThemeController(store: FakeSettingStore<ThemeMode>());
      final locale = LocaleController(store: FakeSettingStore<Locale?>());
      final textScale = TextScaleController(store: FakeSettingStore<double>());
      final firstLaunch = FirstLaunchController(
        store: FakeSettingStore<bool>(),
      );
      final hideBalances = SettingController<bool>(
        defaultValue: false,
        store: FakeSettingStore<bool>(),
        scope: SettingScope.session,
      );

      await theme.setThemeMode(ThemeMode.dark);
      await locale.setLocale(const Locale('fr'));
      await textScale.setTextScale(1.4);
      await firstLaunch.markLaunched();
      await hideBalances.update(true);

      await resetAll([theme, locale, textScale, firstLaunch, hideBalances]);

      expect(theme.themeMode, ThemeMode.system);
      expect(locale.locale, isNull);
      expect(textScale.textScale, 1.0);
      expect(firstLaunch.isFirstLaunch, isTrue);
      expect(hideBalances.value, isFalse);
    });

    test(
      'resetSession only clears session-scoped settings, on logout',
      () async {
        final theme = ThemeController(store: FakeSettingStore<ThemeMode>());
        final locale = LocaleController(store: FakeSettingStore<Locale?>());
        final hideBalances = SettingController<bool>(
          defaultValue: false,
          store: FakeSettingStore<bool>(),
          scope: SettingScope.session,
        );

        await theme.setThemeMode(ThemeMode.dark);
        await locale.setLocale(const Locale('fr'));
        await hideBalances.update(true);

        await resetSession([theme, locale, hideBalances]);

        expect(theme.themeMode, ThemeMode.dark, reason: 'device-scoped');
        expect(locale.locale, const Locale('fr'), reason: 'device-scoped');
        expect(hideBalances.value, isFalse, reason: 'session-scoped');
      },
    );
  });
}
