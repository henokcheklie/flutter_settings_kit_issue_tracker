import 'package:flutter_settings_kit/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

SharedPrefsSettingStore<int> _buildStore(String key) {
  SharedPreferencesAsyncPlatform.instance =
      InMemorySharedPreferencesAsync.empty();
  return SharedPrefsSettingStore<int>(
    key: key,
    encode: (value) => value.toString(),
    decode: int.parse,
  );
}

void main() {
  group('SharedPrefsSettingStore', () {
    test('read() returns null when nothing is persisted', () async {
      final store = _buildStore('count');
      expect(await store.read(), isNull);
    });

    test('write() then read() round-trips the value', () async {
      final store = _buildStore('count');

      await store.write(42);

      expect(await store.read(), 42);
    });

    test('clear() removes the persisted value', () async {
      final store = _buildStore('count');
      await store.write(42);

      await store.clear();

      expect(await store.read(), isNull);
    });

    test('different keys do not collide', () async {
      SharedPreferencesAsyncPlatform.instance =
          InMemorySharedPreferencesAsync.empty();
      final a = SharedPrefsSettingStore<int>(
        key: 'a',
        encode: (v) => '$v',
        decode: int.parse,
      );
      final b = SharedPrefsSettingStore<int>(
        key: 'b',
        encode: (v) => '$v',
        decode: int.parse,
      );

      await a.write(1);
      await b.write(2);

      expect(await a.read(), 1);
      expect(await b.read(), 2);
    });
  });
}
