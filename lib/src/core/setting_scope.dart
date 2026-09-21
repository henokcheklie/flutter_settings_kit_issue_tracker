/// Where a persisted setting belongs, and therefore when it should be
/// cleared.
enum SettingScope {
  /// Tied to the physical device, not any particular signed-in account.
  ///
  /// Survives `resetSession()` (e.g. logging out) so the next person to use
  /// this device keeps the same theme, language, and other device-level UX
  /// preferences. Cleared only by `resetAll()`.
  device,

  /// Tied to the currently signed-in account.
  ///
  /// Cleared by both `resetSession()` (logout) and `resetAll()`.
  session,
}
