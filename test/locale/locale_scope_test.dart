import 'package:flutter/widgets.dart';
import 'package:flutter_settings_kit/locale.dart';
import 'package:flutter_test/flutter_test.dart';

import '../core/fake_setting_store.dart';

void main() {
  group('LocaleScope', () {
    testWidgets('of() returns the nearest controller', (tester) async {
      final controller = LocaleController(store: FakeSettingStore<Locale?>());
      LocaleController? found;

      await tester.pumpWidget(
        LocaleScope(
          controller: controller,
          child: Builder(
            builder: (context) {
              found = LocaleScope.of(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(found, same(controller));
    });

    testWidgets('maybeOf() returns null without a scope', (tester) async {
      LocaleController? found;

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            found = LocaleScope.maybeOf(context);
            return const SizedBox();
          },
        ),
      );

      expect(found, isNull);
    });

    testWidgets('rebuilds dependents when the controller changes', (
      tester,
    ) async {
      final controller = LocaleController(store: FakeSettingStore<Locale?>());
      var buildCount = 0;

      await tester.pumpWidget(
        LocaleScope(
          controller: controller,
          child: Builder(
            builder: (context) {
              LocaleScope.of(context);
              buildCount++;
              return const SizedBox();
            },
          ),
        ),
      );
      expect(buildCount, 1);

      await controller.setLocale(const Locale('fr'));
      await tester.pump();

      expect(buildCount, 2);
    });
  });
}
