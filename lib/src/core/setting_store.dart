/// Pluggable persistence for a single `SettingController` (see
/// `setting_controller.dart`) value.
///
/// The package's default implementation, `SharedPrefsSettingStore`, is
/// backed by `shared_preferences`. Implement this interface directly to
/// back a setting with different storage (Hive, Isar, a secure store, ...)
/// without touching the controller or widget layer.
abstract class SettingStore<T> {
  /// Reads the persisted value, or `null` if nothing has been saved yet.
  Future<T?> read();

  /// Persists [value].
  Future<void> write(T value);

  /// Removes the persisted value entirely, so a future [read] returns
  /// `null` again.
  Future<void> clear();
}
