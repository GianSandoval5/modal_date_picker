import 'package:flutter/material.dart';
import 'package:modal_date_picker/src/export.dart';

/// A scroll-based date picker widget.
///
/// Displays three scrollable columns (year, month, day) and a confirm button.
/// The selected date is emitted through [onDateTimeChanged].
class ScrollDatePicker extends StatefulWidget {
  /// Creates a [ScrollDatePicker].
  ScrollDatePicker({
    super.key,
    this.viewType,
    DateTime? minimumDate,
    DateTime? maximumDate,
    required this.selectedDate,
    required this.onDateTimeChanged,
    Locale? locale,
    DatePickerOptions? options,
    this.indicator,
    this.colorBackground = Colors.white,
    this.colorIndicator = Colors.indigoAccent,
    required this.scrollViewOptions,
    required this.styleConfirmText,
    required this.colorConfirmButton,
    this.borderRadiusButton = const BorderRadius.all(Radius.circular(10)),
    this.heightButtom = 25,
  })  : minimumDate = minimumDate ?? DateTime(1960, 1, 1),
        maximumDate = maximumDate ?? DateTime.now(),
        locale = locale ?? const Locale('en', 'US'),
        options = options ?? const DatePickerOptions();

  /// The order and selection of date columns to display.
  final List<DatePickerViewType>? viewType;

  /// The initially selected date.
  final DateTime selectedDate;

  /// The earliest selectable date.
  final DateTime minimumDate;

  /// The latest selectable date.
  final DateTime maximumDate;

  /// Called whenever the user changes the date.
  final ValueChanged<DateTime> onDateTimeChanged;

  /// Options for the scroll wheel appearance (item extent, diameter, etc.).
  final DatePickerOptions options;

  /// The locale used for month names and button labels.
  final Locale locale;

  /// Options for each scroll column (year, month, day).
  final DatePickerScrollViewOptions scrollViewOptions;

  /// Custom indicator widget displayed behind the selected row.
  final Widget? indicator;

  /// Background color of the picker container.
  final Color colorBackground;

  /// Color of the default selection indicator.
  final Color colorIndicator;

  /// Text style for the confirm button.
  final TextStyle styleConfirmText;

  /// Background color of the confirm button.
  final Color colorConfirmButton;

  /// Border radius of the confirm button.
  final BorderRadius borderRadiusButton;

  /// Height of the confirm button.
  final double heightButtom;

  @override
  State<ScrollDatePicker> createState() => _ScrollDatePickerState();
}

class _ScrollDatePickerState extends State<ScrollDatePicker> {
  late FixedExtentScrollController _yearController;
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _dayController;

  late DateTime _currentDate;
  late List<int> _years;
  late List<int> _months;
  late List<int> _days;

  /// When true, onSelectedItemChanged callbacks are ignored.
  bool _silent = false;

  // ───────── Lifecycle ─────────

  @override
  void initState() {
    super.initState();
    _currentDate = _clamp(widget.selectedDate);
    _years = _buildYears();
    _months = _buildMonths(_currentDate.year);
    _days = _buildDays(_currentDate.year, _currentDate.month);

    _yearController = FixedExtentScrollController(
      initialItem: _indexOf(_years, _currentDate.year),
    );
    _monthController = FixedExtentScrollController(
      initialItem: _indexOf(_months, _currentDate.month),
    );
    _dayController = FixedExtentScrollController(
      initialItem: _indexOf(_days, _currentDate.day),
    );
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    super.dispose();
  }

  // ───────── Data helpers ─────────

  DateTime _clamp(DateTime d) {
    if (d.isBefore(widget.minimumDate)) return widget.minimumDate;
    if (d.isAfter(widget.maximumDate)) return widget.maximumDate;
    return d;
  }

  int _indexOf(List<int> list, int value) {
    final i = list.indexOf(value);
    return i >= 0 ? i : 0;
  }

  List<int> _buildYears() => [
        for (int i = widget.minimumDate.year; i <= widget.maximumDate.year; i++)
          i
      ];

  List<int> _buildMonths(int year) {
    int first = 1, last = 12;
    if (year == widget.minimumDate.year) first = widget.minimumDate.month;
    if (year == widget.maximumDate.year) last = widget.maximumDate.month;
    return [for (int i = first; i <= last; i++) i];
  }

  List<int> _buildDays(int year, int month) {
    final maxDay = getMonthlyDate(year: year, month: month);
    int first = 1, last = maxDay;
    if (year == widget.minimumDate.year && month == widget.minimumDate.month) {
      first = widget.minimumDate.day;
    }
    if (year == widget.maximumDate.year && month == widget.maximumDate.month) {
      last = widget.maximumDate.day;
    }
    return [for (int i = first; i <= last; i++) i];
  }

  int _safeValue(FixedExtentScrollController c, List<int> list, int fallback) {
    if (!c.hasClients || list.isEmpty) return fallback;
    final idx = c.selectedItem;
    return (idx >= 0 && idx < list.length) ? list[idx] : fallback;
  }

  // ───────── Core update logic ─────────

  /// Called whenever ANY column changes (scroll or tap).
  /// Reads the current value from the changed column, preserves the others,
  /// recalculates dependent lists, and emits the new date.
  void _onYearChanged(int yearIdx) {
    if (_silent) return;
    if (yearIdx < 0 || yearIdx >= _years.length) return;

    final year = _years[yearIdx];
    final wantMonth = _safeValue(_monthController, _months, _currentDate.month);
    final wantDay = _safeValue(_dayController, _days, _currentDate.day);

    _months = _buildMonths(year);
    final month = _months.contains(wantMonth) ? wantMonth : _months.last;

    _days = _buildDays(year, month);
    final day = _days.contains(wantDay) ? wantDay : _days.last;

    _currentDate = DateTime(year, month, day);
    widget.onDateTimeChanged(_currentDate);

    _silent = true;
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_monthController.hasClients) {
        _monthController.jumpToItem(_indexOf(_months, month));
      }
      if (_dayController.hasClients) {
        _dayController.jumpToItem(_indexOf(_days, day));
      }
      _silent = false;
    });
  }

  void _onMonthChanged(int monthIdx) {
    if (_silent) return;
    if (monthIdx < 0 || monthIdx >= _months.length) return;

    final month = _months[monthIdx];
    final wantDay = _safeValue(_dayController, _days, _currentDate.day);

    _days = _buildDays(_currentDate.year, month);
    final day = _days.contains(wantDay) ? wantDay : _days.last;

    _currentDate = DateTime(_currentDate.year, month, day);
    widget.onDateTimeChanged(_currentDate);

    _silent = true;
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_dayController.hasClients) {
        _dayController.jumpToItem(_indexOf(_days, day));
      }
      _silent = false;
    });
  }

  void _onDayChanged(int dayIdx) {
    if (_silent) return;
    if (dayIdx < 0 || dayIdx >= _days.length) return;

    final day = _days[dayIdx];
    final newDate = DateTime(_currentDate.year, _currentDate.month, day);
    if (newDate == _currentDate) return;

    _currentDate = newDate;
    widget.onDateTimeChanged(_currentDate);
  }

  // ───────── Build column widgets ─────────

  Widget _buildYearColumn() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
      child: DateScrollView(
        key: const Key('year'),
        dates: _years,
        controller: _yearController,
        options: widget.options,
        scrollViewOptions: widget.scrollViewOptions.year,
        selectedIndex: _indexOf(_years, _currentDate.year),
        locale: widget.locale,
        onChanged: _onYearChanged,
        onTap: (int index) {
          _yearController.jumpToItem(index);
          _onYearChanged(index);
        },
      ),
    );
  }

  Widget _buildMonthColumn() {
    final monthNames = <String>[];
    for (final m in _months) {
      final all = widget.locale.months;
      monthNames.add((m - 1 < all.length) ? all[m - 1] : '$m');
    }
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
      child: DateScrollView(
        key: const Key('month'),
        dates: monthNames,
        controller: _monthController,
        options: widget.options,
        scrollViewOptions: widget.scrollViewOptions.month,
        selectedIndex: _indexOf(_months, _currentDate.month),
        locale: widget.locale,
        onChanged: _onMonthChanged,
        onTap: (int index) {
          _monthController.jumpToItem(index);
          _onMonthChanged(index);
        },
      ),
    );
  }

  Widget _buildDayColumn() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
      child: DateScrollView(
        key: const Key('day'),
        dates: _days,
        controller: _dayController,
        options: widget.options,
        scrollViewOptions: widget.scrollViewOptions.day,
        selectedIndex: _indexOf(_days, _currentDate.day),
        locale: widget.locale,
        onChanged: _onDayChanged,
        onTap: (int index) {
          _dayController.jumpToItem(index);
          _onDayChanged(index);
        },
      ),
    );
  }

  List<Widget> _orderedColumns() {
    if (widget.viewType?.isNotEmpty ?? false) {
      return widget.viewType!.map((v) {
        switch (v) {
          case DatePickerViewType.year:
            return _buildYearColumn();
          case DatePickerViewType.month:
            return _buildMonthColumn();
          case DatePickerViewType.day:
            return _buildDayColumn();
        }
      }).toList();
    }
    return [_buildYearColumn(), _buildMonthColumn(), _buildDayColumn()];
  }

  // ───────── Build ─────────

  @override
  Widget build(BuildContext context) {
    final confirmTexts = {
      'en': 'Confirm',
      'es': 'Confirmar',
      'fr': 'Confirmer',
      'de': 'Bestätigen',
    };
    final confirmText = confirmTexts[widget.locale.languageCode] ?? 'Confirm';

    return Container(
      color: widget.colorBackground,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: widget.indicator ??
                  Container(
                    height: widget.options.itemExtent,
                    decoration: BoxDecoration(color: widget.colorIndicator),
                  ),
            ),
          ),
          Row(
            mainAxisAlignment: widget.scrollViewOptions.mainAxisAlignment,
            crossAxisAlignment: widget.scrollViewOptions.crossAxisAlignment,
            children: _orderedColumns(),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: MaterialButton(
                height: widget.heightButtom,
                color: widget.colorConfirmButton,
                shape: RoundedRectangleBorder(
                  borderRadius: widget.borderRadiusButton,
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  confirmText,
                  textAlign: TextAlign.end,
                  style: widget.styleConfirmText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
