import 'package:flutter/widgets.dart';
import 'package:flutter_settings_kit/text_scale.dart';
import 'package:flutter_test/flutter_test.dart';

import '../core/fake_setting_store.dart';

void main() {
  group('TextScaleScope', () {
    testWidgets('of() returns the nearest controller', (tester) async {
      final controller = TextScaleController(store: FakeSettingStore<double>());
      TextScaleController? found;

      await tester.pumpWidget(
        TextScaleScope(
          controller: controller,
          child: Builder(
            builder: (context) {
              found = TextScaleScope.of(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(found, same(controller));
    });

    testWidgets('maybeOf() returns null without a scope', (tester) async {
      TextScaleController? found;

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            found = TextScaleScope.maybeOf(context);
            return const SizedBox();
          },
        ),
      );

      expect(found, isNull);
    });

    testWidgets('applies the controller scale via MediaQuery', (tester) async {
      final controller = TextScaleController(
        defaultValue: 1.3,
        store: FakeSettingStore<double>(),
      );
      late TextScaler scaler;

      await tester.pumpWidget(
        TextScaleScope(
          controller: controller,
          child: Builder(
            builder: (context) {
              scaler = MediaQuery.textScalerOf(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(scaler.scale(10), const TextScaler.linear(1.3).scale(10));
    });

    testWidgets('updates MediaQuery when the controller changes', (
      tester,
    ) async {
      final controller = TextScaleController(store: FakeSettingStore<double>());
      late TextScaler scaler;

      await tester.pumpWidget(
        TextScaleScope(
          controller: controller,
          child: Builder(
            builder: (context) {
              scaler = MediaQuery.textScalerOf(context);
              return const SizedBox();
            },
          ),
        ),
      );
      expect(scaler.scale(10), TextScaler.noScaling.scale(10));

      await controller.setTextScale(1.5);
      await tester.pump();

      expect(scaler.scale(10), const TextScaler.linear(1.5).scale(10));
    });
  });
}
