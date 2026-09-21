import 'package:flutter/widgets.dart';
import 'package:flutter_settings_kit/src/app_info/app_info_controller.dart';

/// Exposes an [AppInfoController] to descendants via [AppInfoScope.of].
///
/// Unlike [AppInfoController]'s data, there's nothing to react to here —
/// package metadata never changes during the app's life — so this is a
/// plain [InheritedWidget], not an [InheritedNotifier].
class AppInfoScope extends InheritedWidget {
  /// Creates a scope exposing [controller] to [child] and its
  /// descendants.
  const AppInfoScope({
    required this.controller,
    required super.child,
    super.key,
  });

  /// The controller made available to descendants.
  final AppInfoController controller;

  /// Reads the nearest [AppInfoController] above [context].
  ///
  /// Throws if there is no [AppInfoScope] above [context] — wrap your
  /// app in one first. Use [maybeOf] if the absence of a scope is
  /// expected.
  static AppInfoController of(BuildContext context) {
    final controller = maybeOf(context);
    assert(
      controller != null,
      'No AppInfoScope found above this context. Wrap your app in an '
      'AppInfoScope.',
    );
    return controller!;
  }

  /// Like [of], but returns `null` instead of throwing when there is no
  /// [AppInfoScope] above [context].
  static AppInfoController? maybeOf(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppInfoScope>();
    return scope?.controller;
  }

  @override
  bool updateShouldNotify(AppInfoScope oldWidget) =>
      controller != oldWidget.controller;
}
