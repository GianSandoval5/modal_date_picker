import 'package:flutter/material.dart';

class DatePickerScrollViewOptions {
  final ScrollViewDetailOptions year;
  final ScrollViewDetailOptions month;
  final ScrollViewDetailOptions day;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const DatePickerScrollViewOptions({
    required this.year,
    required this.month,
    required this.day,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
 
  });



  // Applies the given [ScrollViewDetailOptions] to all three options ie. year, month and day.
  static DatePickerScrollViewOptions all(ScrollViewDetailOptions value) {
    return DatePickerScrollViewOptions(
      year: value,
      month: value,
      day: value,
    );
  }
}

class ScrollViewDetailOptions {
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
