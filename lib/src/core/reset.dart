import 'package:flutter_settings_kit/src/core/setting_controller.dart';
import 'package:flutter_settings_kit/src/core/setting_scope.dart';

/// Resets every controller in [controllers] to its default value,
/// regardless of [SettingController.scope].
///
/// Wire this to a "Reset app" / factory-reset action. See [resetSession]
/// for the logout equivalent, which only clears
/// [SettingScope.session]-scoped controllers.
Future<void> resetAll(List<SettingController<Object?>> controllers) async {
  await Future.wait(
    controllers.map((controller) => controller.resetToDefault()),
  );
}

/// Resets only the controllers in [controllers] whose
/// [SettingController.scope] is [SettingScope.session].
///
/// Wire this to a logout action, so device-level preferences (theme,
/// locale, ...) survive signing out. Pass the same full controller list
/// you'd pass to [resetAll] — the scope filtering happens here.
Future<void> resetSession(List<SettingController<Object?>> controllers) async {
  final sessionControllers = controllers.where(
    (controller) => controller.scope == SettingScope.session,
  );
  await Future.wait(
    sessionControllers.map((controller) => controller.resetToDefault()),
  );
}
