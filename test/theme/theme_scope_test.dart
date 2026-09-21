import 'package:flutter/material.dart';
import 'package:flutter_settings_kit/theme.dart';
import 'package:flutter_test/flutter_test.dart';

import '../core/fake_setting_store.dart';

void main() {
  group('ThemeScope', () {
    testWidgets('of() returns the nearest controller', (tester) async {
      final controller = ThemeController(store: FakeSettingStore<ThemeMode>());
      ThemeController? found;

      await tester.pumpWidget(
        ThemeScope(
          controller: controller,
          child: Builder(
            builder: (context) {
              found = ThemeScope.of(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(found, same(controller));
    });

    testWidgets('maybeOf() returns null without a scope', (tester) async {
      ThemeController? found;

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            found = ThemeScope.maybeOf(context);
            return const SizedBox();
          },
        ),
      );

      expect(found, isNull);
    });

    testWidgets('rebuilds dependents when the controller changes', (
      tester,
    ) async {
      final controller = ThemeController(store: FakeSettingStore<ThemeMode>());
      var buildCount = 0;

      await tester.pumpWidget(
        ThemeScope(
          controller: controller,
          child: Builder(
            builder: (context) {
              ThemeScope.of(context);
              buildCount++;
              return const SizedBox();
            },
          ),
        ),
      );
      expect(buildCount, 1);

      await controller.setThemeMode(ThemeMode.dark);
      await tester.pump();

      expect(buildCount, 2);
    });
  });
}
