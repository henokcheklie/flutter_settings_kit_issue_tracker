import 'package:flutter/widgets.dart';
import 'package:flutter_settings_kit/src/theme/theme_controller.dart';

/// Exposes a [ThemeController] to descendants, rebuilding whichever of
/// them call [ThemeScope.of] whenever the controller changes.
///
/// Place this above `MaterialApp`, and read it back inside a descendant's
/// `build` method (not the widget that creates this scope itself) via
/// [ThemeScope.of].
class ThemeScope extends StatelessWidget {
  /// Creates a scope exposing [controller] to [child] and its
  /// descendants.
  const ThemeScope({required this.controller, required this.child, super.key});

  /// The controller made available to descendants.
  final ThemeController controller;

  /// The subtree that can read [controller] via [ThemeScope.of].
  final Widget child;

  /// Reads the nearest [ThemeController] above [context], and subscribes
  /// to it so the calling widget rebuilds when it changes.
  ///
  /// Throws if there is no [ThemeScope] above [context] — wrap your app
  /// in one first. Use [maybeOf] if the absence of a scope is expected.
  static ThemeController of(BuildContext context) {
    final controller = maybeOf(context);
    assert(
      controller != null,
      'No ThemeScope found above this context. Wrap your app in a ThemeScope.',
    );
    return controller!;
  }

  /// Like [of], but returns `null` instead of throwing when there is no
  /// [ThemeScope] above [context].
  static ThemeController? maybeOf(BuildContext context) {
    final marker = context
        .dependOnInheritedWidgetOfExactType<_ThemeScopeMarker>();
    return marker?.notifier;
  }

  @override
  Widget build(BuildContext context) =>
      _ThemeScopeMarker(notifier: controller, child: child);
}

class _ThemeScopeMarker extends InheritedNotifier<ThemeController> {
  const _ThemeScopeMarker({
    required ThemeController super.notifier,
    required super.child,
  });
}
