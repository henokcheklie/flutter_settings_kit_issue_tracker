import 'package:flutter/widgets.dart';
import 'package:flutter_settings_kit/app_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';

AppInfoController _fakeController() => AppInfoController(
  fetch: () async => PackageInfo(
    appName: 'My App',
    packageName: 'com.example.my_app',
    version: '1.0.0',
    buildNumber: '1',
  ),
);

void main() {
  group('AppInfoScope', () {
    testWidgets('of() returns the nearest controller', (tester) async {
      final controller = _fakeController();
      AppInfoController? found;

      await tester.pumpWidget(
        AppInfoScope(
          controller: controller,
          child: Builder(
            builder: (context) {
              found = AppInfoScope.of(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(found, same(controller));
    });

    testWidgets('maybeOf() returns null without a scope', (tester) async {
      AppInfoController? found;

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            found = AppInfoScope.maybeOf(context);
            return const SizedBox();
          },
        ),
      );

      expect(found, isNull);
    });

    testWidgets('the exposed controller loads the expected AppInfo', (
      tester,
    ) async {
      final controller = _fakeController();
      AppInfoController? found;

      await tester.pumpWidget(
        AppInfoScope(
          controller: controller,
          child: Builder(
            builder: (context) {
              found = AppInfoScope.of(context);
              return const SizedBox();
            },
          ),
        ),
      );

      final info = await found!.load();
      expect(info.appName, 'My App');
      expect(info.version, '1.0.0');
    });
  });
}
