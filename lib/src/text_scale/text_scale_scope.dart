import 'package:flutter/widgets.dart';
import 'package:flutter_settings_kit/src/text_scale/text_scale_controller.dart';

/// Applies a [TextScaleController]'s current scale to [child] via
/// `MediaQuery`, and exposes the controller to descendants via
/// [TextScaleScope.of].
///
/// Place this above `MaterialApp` (or anywhere above the content that
/// should scale) — no manual `MediaQuery` wiring needed; this widget
/// keeps the effective text scale in sync with the controller on its
/// own.
class TextScaleScope extends StatelessWidget {
  /// Creates a scope applying [controller]'s scale to [child] and
  /// exposing [controller] to its descendants.
  const TextScaleScope({
    required this.controller,
    required this.child,
    super.key,
  });

  /// The controller whose scale is applied, and made available to
  /// descendants.
  final TextScaleController controller;

  /// The subtree the scale is applied to, and that can read
  /// [controller] via [TextScaleScope.of].
  final Widget child;

  /// Reads the nearest [TextScaleController] above [context], and
  /// subscribes to it so the calling widget rebuilds when it changes.
  ///
  /// Throws if there is no [TextScaleScope] above [context] — wrap your
  /// app in one first. Use [maybeOf] if the absence of a scope is
  /// expected.
  static TextScaleController of(BuildContext context) {
    final controller = maybeOf(context);
    assert(
      controller != null,
      'No TextScaleScope found above this context. Wrap your app in a '
      'TextScaleScope.',
    );
    return controller!;
  }

  /// Like [of], but returns `null` instead of throwing when there is no
  /// [TextScaleScope] above [context].
  static TextScaleController? maybeOf(BuildContext context) {
    final marker = context
        .dependOnInheritedWidgetOfExactType<_TextScaleScopeMarker>();
    return marker?.notifier;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final ambient =
            MediaQuery.maybeOf(context) ??
            MediaQueryData.fromView(View.of(context));
        return _TextScaleScopeMarker(
          notifier: controller,
          child: MediaQuery(
            data: ambient.copyWith(
              textScaler: TextScaler.linear(controller.textScale),
            ),
            child: child,
          ),
        );
      },
    );
  }
}

class _TextScaleScopeMarker extends InheritedNotifier<TextScaleController> {
  const _TextScaleScopeMarker({
    required TextScaleController super.notifier,
    required super.child,
  });
}
