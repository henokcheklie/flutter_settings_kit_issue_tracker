import 'package:flutter/widgets.dart';
import 'package:flutter_settings_kit/src/locale/locale_controller.dart';

/// Exposes a [LocaleController] to descendants, rebuilding whichever of
/// them call [LocaleScope.of] whenever the controller changes.
///
/// Place this above `MaterialApp`, and read it back inside a
/// descendant's `build` method (not the widget that creates this scope
/// itself) via [LocaleScope.of].
class LocaleScope extends StatelessWidget {
  /// Creates a scope exposing [controller] to [child] and its
  /// descendants.
  const LocaleScope({required this.controller, required this.child, super.key});

  /// The controller made available to descendants.
  final LocaleController controller;

  /// The subtree that can read [controller] via [LocaleScope.of].
  final Widget child;

  /// Reads the nearest [LocaleController] above [context], and
  /// subscribes to it so the calling widget rebuilds when it changes.
  ///
  /// Throws if there is no [LocaleScope] above [context] — wrap your app
  /// in one first. Use [maybeOf] if the absence of a scope is expected.
  static LocaleController of(BuildContext context) {
    final controller = maybeOf(context);
    assert(
      controller != null,
      'No LocaleScope found above this context. Wrap your app in a '
      'LocaleScope.',
    );
    return controller!;
  }

  /// Like [of], but returns `null` instead of throwing when there is no
  /// [LocaleScope] above [context].
  static LocaleController? maybeOf(BuildContext context) {
    final marker = context
        .dependOnInheritedWidgetOfExactType<_LocaleScopeMarker>();
    return marker?.notifier;
  }

  @override
  Widget build(BuildContext context) =>
      _LocaleScopeMarker(notifier: controller, child: child);
}

class _LocaleScopeMarker extends InheritedNotifier<LocaleController> {
  const _LocaleScopeMarker({
    required LocaleController super.notifier,
    required super.child,
  });
}
