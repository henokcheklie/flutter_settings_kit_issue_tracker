import 'package:flutter_settings_kit/src/core/setting_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The default [SettingStore], backed by [SharedPreferencesAsync].
///
/// Stores `T` as a single `String` entry under `key`, via `encode`/`decode`
/// — this keeps one implementation generic over every value type this
/// package persists (an enum, a `Locale`, a `double`, a `bool`) instead of
/// one store class per type.
class SharedPrefsSettingStore<T> implements SettingStore<T> {
  /// Creates a store for [key], using [encode]/[decode] to convert [T] to
  /// and from the [String] `shared_preferences` actually stores.
  ///
  /// Pass a custom [preferences] instance in tests to avoid touching the
  /// real platform channel.
  SharedPrefsSettingStore({
    required String key,
    required String Function(T value) encode,
    required T Function(String raw) decode,
    SharedPreferencesAsync? preferences,
  }) : _key = key,
       _encode = encode,
       _decode = decode,
       _preferences = preferences ?? SharedPreferencesAsync();

  final String _key;
  final String Function(T value) _encode;
  final T Function(String raw) _decode;
  final SharedPreferencesAsync _preferences;

  @override
  Future<T?> read() async {
    final raw = await _preferences.getString(_key);
    if (raw == null) {
      return null;
    }
    return _decode(raw);
  }

  @override
  Future<void> write(T value) => _preferences.setString(_key, _encode(value));

  @override
  Future<void> clear() => _preferences.remove(_key);
}
