import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
    PackageInfo.setMockInitialValues(
      appName: 'Example',
      packageName: 'com.odooethiopia.example',
      version: '1.0.0',
      buildNumber: '1',
      buildSignature: '',
    );
  });

  // Tall enough that every settings card is built and findable without
  // needing to scroll the ListView during these tests.
  Future<void> pumpTallApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 4000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const SettingsDemoApp());
    await tester.pumpAndSettle();
  }

  testWidgets('renders the settings screen with every section', (tester) async {
    await pumpTallApp(tester);

    expect(find.byType(SegmentedButton<ThemeMode>), findsOneWidget);
    expect(find.byType(DropdownButton<Locale?>), findsOneWidget);
    expect(find.byType(Slider), findsOneWidget);
    expect(find.byType(SwitchListTile), findsNWidgets(2));
    expect(find.byType(OutlinedButton), findsOneWidget);
    expect(find.byType(FilledButton), findsOneWidget);
  });

  testWidgets('the first-launch banner dismisses on tap', (tester) async {
    await pumpTallApp(tester);

    expect(find.text('Got it'), findsOneWidget);

    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();

    expect(find.text('Got it'), findsNothing);
  });

  testWidgets('switching theme mode does not throw', (tester) async {
    await pumpTallApp(tester);

    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('switching to every supported language does not throw', (
    tester,
  ) async {
    // Regression test: flutter_localizations' Global*Localizations
    // delegates don't cover every language this app supports (Afaan
    // Oromo, Somali, and Tigrinya are missing) — without the fallback
    // delegates in fallback_locale_delegates.dart, picking one of these
    // crashes every Material widget that looks up
    // MaterialLocalizations.of(context) internally.
    await pumpTallApp(tester);

    const languageNames = [
      'English',
      'Français',
      'العربية',
      'አማርኛ',
      'ትግርኛ',
      'Afaan Oromoo',
      'Soomaali',
    ];

    for (final name in languageNames) {
      await tester.tap(find.byType(DropdownButton<Locale?>));
      await tester.pumpAndSettle();

      await tester.tap(find.text(name).last);
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull, reason: 'switching to $name');
    }
  });
}
