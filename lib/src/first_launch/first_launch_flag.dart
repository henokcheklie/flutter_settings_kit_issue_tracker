import 'package:flutter_settings_kit/src/core/setting_controller.dart';
import 'package:flutter_settings_kit/src/core/setting_store.dart';
import 'package:flutter_settings_kit/src/core/shared_prefs_setting_store.dart';

const _storeKey = 'flutter_settings_kit.first_launch';

/// Tracks whether the app has completed its first launch on this
/// device — the single most common one-off flag every app needs to
/// drive an onboarding flow.
///
/// Device-scoped: "has this device seen onboarding" isn't tied to which
/// account is currently logged in. This is otherwise just a
/// `SettingController<bool>` with two friendlier names for its two
/// states.
class FirstLaunchController extends SettingController<bool> {
  /// Creates a first-launch flag, `true` until [markLaunched] is called.
  ///
  /// Pass `store` to persist through something other than
  /// `shared_preferences`.
  FirstLaunchController({SettingStore<bool>? store})
    : super(
        defaultValue: true,
        store:
            store ??
            SharedPrefsSettingStore<bool>(
              key: _storeKey,
              encode: (isFirstLaunch) => isFirstLaunch.toString(),
              decode: (raw) => raw == 'true',
            ),
      );

  /// Whether this is the first launch on this device. Alias for
  /// [value].
  bool get isFirstLaunch => value;

  /// Marks the first launch as complete (sets [isFirstLaunch] to
  /// `false`).
  Future<void> markLaunched() => update(false);
}
