import 'dart:async';

import 'package:flutter_settings_kit/src/core/setting_controller.dart';
import 'package:flutter_settings_kit/src/core/setting_store.dart';
import 'package:flutter_settings_kit/src/core/shared_prefs_setting_store.dart';

const _storeKey = 'flutter_settings_kit.text_scale';

/// A persisted text-scale multiplier, clamped to [minScale]–[maxScale] —
/// including a value loaded from `store` that falls outside the current
/// range (e.g. after [minScale]/[maxScale] changed between app
/// versions).
///
/// Device-scoped: survives logging out. Pair with `TextScaleScope`,
/// which applies the current scale to its subtree automatically via
/// `MediaQuery` — no manual `MediaQuery` wiring needed.
class TextScaleController extends SettingController<double> {
  /// Creates a text-scale controller starting at [defaultValue] (`1.0` —
  /// unscaled — by default), clamped to [minScale]–[maxScale].
  ///
  /// Pass [store] to persist through something other than
  /// `shared_preferences`.
  TextScaleController({
    double defaultValue = 1,
    this.minScale = 0.8,
    this.maxScale = 1.6,
    SettingStore<double>? store,
  }) : assert(minScale <= maxScale, 'minScale must be <= maxScale'),
       super(
         defaultValue: defaultValue.clamp(minScale, maxScale),
         store:
             store ??
             SharedPrefsSettingStore<double>(
               key: _storeKey,
               encode: (scale) => scale.toString(),
               decode: (raw) => double.parse(raw).clamp(minScale, maxScale),
             ),
       ) {
    unawaited(_clampAfterLoad());
  }

  /// The smallest scale [setTextScale] will accept.
  final double minScale;

  /// The largest scale [setTextScale] will accept.
  final double maxScale;

  /// The current scale multiplier. Alias for [value].
  double get textScale => value;

  /// Sets the scale multiplier, clamped to [minScale]–[maxScale].
  Future<void> setTextScale(double scale) =>
      update(scale.clamp(minScale, maxScale));

  Future<void> _clampAfterLoad() async {
    await ready;
    if (value < minScale || value > maxScale) {
      await setTextScale(value);
    }
  }
}
