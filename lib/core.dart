/// The generic, reusable persisted-setting primitive this package is
/// built on. Import this directly to define your own settings
/// (`SettingController<T>`) without pulling in the theme/locale/etc.
/// modules.
library;

export 'src/core/reset.dart';
export 'src/core/setting_controller.dart';
export 'src/core/setting_scope.dart';
export 'src/core/setting_store.dart';
export 'src/core/shared_prefs_setting_store.dart';
