import 'package:flutter/material.dart';

extension StringExtension on String {
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
