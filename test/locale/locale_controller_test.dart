import 'package:flutter/widgets.dart';
import 'package:flutter_settings_kit/core.dart';
import 'package:flutter_settings_kit/locale.dart';
import 'package:flutter_test/flutter_test.dart';

import '../core/fake_setting_store.dart';

void main() {
  group('LocaleController', () {
    test('defaults to null (follow the system locale)', () {
      final controller = LocaleController(store: FakeSettingStore<Locale?>());

      expect(controller.locale, isNull);
    });

    test('is device-scoped', () {
      final controller = LocaleController(store: FakeSettingStore<Locale?>());

      expect(controller.scope, SettingScope.device);
    });

    test('setLocale sets an explicit override', () async {
      final controller = LocaleController(store: FakeSettingStore<Locale?>());

      await controller.setLocale(const Locale('fr'));

      expect(controller.locale, const Locale('fr'));
    });

    test('resetToSystemLocale clears back to null', () async {
      final controller = LocaleController(
        defaultValue: const Locale('en'),
        store: FakeSettingStore<Locale?>(initialValue: const Locale('fr')),
      );
      await controller.ready;
      expect(controller.locale, const Locale('fr'));

      await controller.resetToSystemLocale();

      expect(controller.locale, isNull);
    });
  });

  group('LocaleController persistence round-trip', () {
    Future<Locale?> roundTrip(Locale? locale) async {
      final store = FakeSettingStore<Locale?>();
      final writer = LocaleController(store: store);
      await writer.setLocale(locale);

      final reader = LocaleController(store: store);
      await reader.ready;
      return reader.locale;
    }

    test('round-trips a language-only locale', () async {
      expect(await roundTrip(const Locale('fr')), const Locale('fr'));
    });

    test('round-trips a language + country locale', () async {
      expect(
        await roundTrip(const Locale('en', 'US')),
        const Locale('en', 'US'),
      );
    });

    test('round-trips a language + script + country locale', () async {
      const locale = Locale.fromSubtags(
        languageCode: 'zh',
        scriptCode: 'Hans',
        countryCode: 'CN',
      );

      expect(await roundTrip(locale), locale);
    });

    test('round-trips null as null', () async {
      expect(await roundTrip(null), isNull);
    });
  });
}
