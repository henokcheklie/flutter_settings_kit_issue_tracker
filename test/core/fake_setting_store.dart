import 'package:flutter_settings_kit/core.dart';

/// An in-memory [SettingStore] test double, with call counters so tests
/// can assert *when* persistence happens, not just the end value.
class FakeSettingStore<T> implements SettingStore<T> {
  FakeSettingStore({T? initialValue}) : _value = initialValue;

  T? _value;
  int readCount = 0;
  int writeCount = 0;
  int clearCount = 0;

  @override
  Future<T?> read() async {
    readCount++;
    return _value;
  }

  @override
  Future<void> write(T value) async {
    writeCount++;
    _value = value;
  }

  @override
  Future<void> clear() async {
    clearCount++;
    _value = null;
  }
}
