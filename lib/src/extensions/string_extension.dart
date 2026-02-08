import 'package:flutter/material.dart';

/// Extension on [String] for measuring rendered text width.
extension StringExtension on String {
  /// Returns the rendered width of this string using the given [style].
  double width(
    BuildContext context, {
    required TextStyle style,
  }) {
    final TextPainter painter = TextPainter(
      text: TextSpan(
        style: style,
        text: this,
      ),
      textDirection: Directionality.of(context),
    );
    painter.layout();

    return painter.size.width;
  }
}
