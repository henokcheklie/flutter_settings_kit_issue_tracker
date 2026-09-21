import 'package:flutter/foundation.dart';
import 'package:flutter_settings_kit/src/core/setting_scope.dart';
import 'package:flutter_settings_kit/src/core/setting_store.dart';

/// A single persisted, observable setting.
///
/// This is the primitive every controller in this package (theme, locale,
/// text scale, first-launch flag) is built on, and it's public so
/// consumers can use it for their own settings too — e.g.
/// `SettingController<bool>` for "send anonymous analytics" — without
/// hand-rolling `SharedPreferences` calls or a second `ChangeNotifier`.
///
/// The constructor-provided [defaultValue] is returned by [value] until a
/// persisted value finishes loading from `store`; await [ready] first if
/// the UI must not show a flash of the default before the real value is
/// known.
class SettingController<T> extends ChangeNotifier
    implements ValueListenable<T> {
  /// Creates a controller starting at [defaultValue], persisted through
  /// `store`, and tagged with [scope] (defaults to [SettingScope.device]).
  SettingController({
    required this.defaultValue,
    required SettingStore<T> store,
    this.scope = SettingScope.device,
  }) : _value = defaultValue,
       _store = store {
    _ready = _load();
  }

  /// The value this controller starts at, and returns to on
  /// [resetToDefault].
  final T defaultValue;

  /// Whether this setting is tied to the device or to the signed-in
  /// account. See [SettingScope].
  final SettingScope scope;

  final SettingStore<T> _store;
  T _value;
  late final Future<void> _ready;

  /// Completes once the persisted value, if any, has been loaded from
  /// [SettingStore.read] and applied.
  Future<void> get ready => _ready;

  @override
  T get value => _value;

  Future<void> _load() async {
    final stored = await _store.read();
    if (stored != null && stored != _value) {
      _value = stored;
      notifyListeners();
    }
  }

  /// Updates the value, notifies listeners, and persists it via `store`.
  ///
  /// A no-op if [newValue] equals the current [value].
  Future<void> update(T newValue) async {
    if (newValue == _value) {
      return;
    }
    _value = newValue;
    notifyListeners();
    await _store.write(newValue);
  }

  /// Resets to [defaultValue] and clears whatever is persisted, so a
  /// future app start sees the default again.
  ///
  /// A no-op if [value] already equals [defaultValue].
  Future<void> resetToDefault() async {
    if (_value == defaultValue) {
      return;
    }
    _value = defaultValue;
    notifyListeners();
    await _store.clear();
  }
}
