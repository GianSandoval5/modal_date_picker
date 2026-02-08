// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_date_picker/src/export.dart';

class DateScrollView extends StatefulWidget {
  const DateScrollView({
    super.key,
    required this.onChanged,
    required this.dates,
    required this.controller,
    required this.options,
    required this.scrollViewOptions,
    required this.selectedIndex,
    required this.locale,
    required this.onTap,
  });

  /// A controller for scroll views whose items have the same size.
  final FixedExtentScrollController controller;

  /// On optional listener that's called when the centered item changes.
  final ValueChanged<int> onChanged;

  /// This is a list of dates.
  final List dates;

  /// A set that allows you to specify options related to ListWheelScrollView.
  final DatePickerOptions options;

  /// A set that allows you to specify options related to ScrollView.
  final ScrollViewDetailOptions scrollViewOptions;

  /// The currently selected date index.
  final int selectedIndex;

  /// Set calendar language
  final Locale locale;

  /// Adds the onTap property to enable clicking to navigate dates.
  ///
  /// The onTap property allows users to navigate dates by clicking on them.
  final ValueChanged<int> onTap;

  @override
  _DateScrollViewState createState() => _DateScrollViewState();
}

class _DateScrollViewState extends State<DateScrollView> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(covariant DateScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      setState(() {
        _selectedIndex = widget.selectedIndex;
      });
    }
  }

  double _getScrollViewWidth(BuildContext context) {
    String longestText =
        widget.dates.longestString + widget.scrollViewOptions.label;
    double textWidth = longestText.width(
      context,
      style: widget.scrollViewOptions.selectedTextStyle,
    );

    if (widget.locale.languageCode == ar) {
      return textWidth + 40;
    }

    return textWidth + 8;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int maximumCount = constraints.maxHeight ~/ widget.options.itemExtent;
        return Container(
          margin: widget.scrollViewOptions.margin,
          width: _getScrollViewWidth(context),
          child: ListWheelScrollView.useDelegate(
            itemExtent: widget.options.itemExtent,
            diameterRatio: widget.options.diameterRatio,
            controller: widget.controller,
            physics: const FixedExtentScrollPhysics(),
            perspective: widget.options.perspective,
            onSelectedItemChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
              widget.onChanged(index);
            },
            childDelegate: widget.options.isLoop ??
                    widget.scrollViewOptions.isLoop &&
                        widget.dates.length > maximumCount
                ? ListWheelChildLoopingListDelegate(
                    children: List<Widget>.generate(
                      widget.dates.length,
                      (index) => _buildDateView(index: index),
                    ),
                  )
                : ListWheelChildListDelegate(
                    children: List<Widget>.generate(
                      widget.dates.length,
                      (index) => _buildDateView(index: index),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildDateView({required int index}) {
    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: Container(
        alignment: widget.scrollViewOptions.alignment,
        child: Text(
          '${widget.dates[index]}${widget.scrollViewOptions.label}',
          style: _selectedIndex == index
              ? widget.scrollViewOptions.selectedTextStyle
              : widget.scrollViewOptions.textStyle,
          textScaler:
              TextScaler.linear(widget.scrollViewOptions.textScaleFactor),
        ),
      ),
    );
  }
}
