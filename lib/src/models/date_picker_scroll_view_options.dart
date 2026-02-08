import 'package:flutter/material.dart';

/// Options that control the layout and appearance of the three date columns.
class DatePickerScrollViewOptions {
  /// Options for the year column.
  final ScrollViewDetailOptions year;

  /// Options for the month column.
  final ScrollViewDetailOptions month;

  /// Options for the day column.
  final ScrollViewDetailOptions day;

  /// How the columns are aligned along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// How the columns are aligned along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// Creates options for the three date scroll columns.
  const DatePickerScrollViewOptions({
    required this.year,
    required this.month,
    required this.day,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  /// Applies the given [ScrollViewDetailOptions] to all three columns.
  static DatePickerScrollViewOptions all(ScrollViewDetailOptions value) {
    return DatePickerScrollViewOptions(
      year: value,
      month: value,
      day: value,
    );
  }
}

/// Detailed options for a single scroll column (year, month or day).
class ScrollViewDetailOptions {
  /// Creates detail options for a scroll column.
  const ScrollViewDetailOptions({
    this.label = '',
    this.alignment = Alignment.centerLeft,
    this.margin,
    required this.selectedTextStyle,
    required this.textStyle,
    this.isLoop = true,
    this.textScaleFactor = 1,
  });

  /// The text printed next to the year, month, and day.
  final String label;

  /// The year, month, and day text alignment method.
  final Alignment alignment;

  /// The amount of space that can be added to the year, month, and day.
  final EdgeInsets? margin;

  /// An immutable style describing how to format and paint text.
  final TextStyle textStyle;

  /// An invariant style that specifies the selected text format and explains how to draw it.
  final TextStyle selectedTextStyle;

  /// Define for each ScrollView if it should loop
  final bool isLoop;

  /// The scaling factor for the text within this widget.
  final double textScaleFactor;
}
