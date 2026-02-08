/// A customizable modal date picker for Flutter.
///
/// Provides a scroll-based date selection with support for multiple locales,
/// date ranges, and real-time [TextEditingController] updates.
library;

export 'src/models/date_picker_view_type.dart';
export 'src/scroll_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:modal_date_picker/src/export.dart';

DateTime? _parseDate(String date, {String format = 'dd/MM/yyyy'}) {
  try {
    final parts = date.split('/');
    if (parts.length == 3) {
      final day =
          format == 'yyyy/MM/dd' ? int.parse(parts[2]) : int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year =
          format == 'yyyy/MM/dd' ? int.parse(parts[0]) : int.parse(parts[2]);
      return DateTime(year, month, day);
    }
  } catch (e) {
    //print('Invalid date format: $date');
  }
  return null;
}

/// Shows a modal bottom sheet containing a [ScrollDatePicker].
///
/// The selected date is written to the [controller] in the specified format.
///
/// {@tool snippet}
/// ```dart
/// dateCustomModalBottomSheet(
///   context: context,
///   controller: _controller,
///   locale: const Locale('es', 'ES'),
/// );
/// ```
/// {@end-tool}
void dateCustomModalBottomSheet({
  /// The build context used to display the modal.
  required BuildContext context,

  /// The text editing controller that will receive the selected date.
  required TextEditingController controller,

  /// Background color of the date picker. Defaults to [Colors.white].
  Color colorBackground = Colors.white,

  /// Color of the selection indicator. Defaults to [Colors.indigoAccent].
  Color colorIndicator = Colors.indigoAccent,

  /// Locale for month names and confirm button text. Defaults to `Locale('es', 'ES')`.
  Locale locale = const Locale('es', 'ES'),

  /// If `true`, uses `yyyy/MM/dd` format; otherwise `dd/MM/yyyy`.
  bool formatDate = false,

  /// Custom column order. Defaults to `[day, month, year]`.
  List<DatePickerViewType>? viewType,

  /// Text style for the selected (centered) item.
  TextStyle selectedTextStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),

  /// Text style for non-selected items.
  TextStyle textStyle = const TextStyle(color: Colors.black),

  /// Text style for the confirm button label.
  TextStyle styleConfirmText = const TextStyle(
      fontWeight: FontWeight.bold, height: 1.0, color: Colors.white),

  /// Optional callback invoked when the date changes. When provided,
  /// the [controller] text is **not** updated automatically.
  void Function(DateTime)? onDateTimeChanged,

  /// Earliest selectable date. Defaults to `DateTime(1980)`.
  DateTime? minimumDate,

  /// Latest selectable date. Defaults to `DateTime.now()`.
  DateTime? maximumDate,

  /// Background color of the confirm button. Defaults to [Colors.indigoAccent].
  Color colorConfirmButton = Colors.indigoAccent,

  /// Border radius of the confirm button.
  BorderRadius? borderRadiusButton,

  /// Height of the confirm button. Defaults to `25.0`.
  double heightButtom = 25.0,
}) {
  DateTime? selectedDate = controller.text.isNotEmpty
      ? _parseDate(controller.text,
          format: formatDate ? 'yyyy/MM/dd' : 'dd/MM/yyyy')
      : null;

  // Establecer el viewType por defecto si no se proporciona
  viewType ??= [
    DatePickerViewType.day,
    DatePickerViewType.month,
    DatePickerViewType.year
  ];

  showModalBottomSheet(
    barrierColor: Colors.transparent,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            height: 320,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ScrollDatePicker(
                    styleConfirmText: styleConfirmText,
                    scrollViewOptions: DatePickerScrollViewOptions(
                      day: ScrollViewDetailOptions(
                          selectedTextStyle: selectedTextStyle,
                          textStyle: textStyle),
                      month: ScrollViewDetailOptions(
                          selectedTextStyle: selectedTextStyle,
                          textStyle: textStyle),
                      year: ScrollViewDetailOptions(
                          selectedTextStyle: selectedTextStyle,
                          textStyle: textStyle),
                    ),
                    viewType: viewType,
                    colorBackground: colorBackground,
                    colorIndicator: colorIndicator,
                    selectedDate: selectedDate ?? DateTime(1980),
                    locale: locale,
                    minimumDate: minimumDate ?? DateTime(1980),
                    maximumDate: maximumDate ?? DateTime.now(),
                    onDateTimeChanged: (DateTime value) {
                      selectedDate = value;
                      if (onDateTimeChanged != null) {
                        onDateTimeChanged(value);
                      } else {
                        if (formatDate) {
                          controller.text =
                              "${value.year}/${value.month.toString().padLeft(2, '0')}/${value.day.toString().padLeft(2, '0')}";
                        } else {
                          controller.text =
                              "${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year}";
                        }
                      }
                    },
                    colorConfirmButton: colorConfirmButton,
                    borderRadiusButton: borderRadiusButton ??
                        const BorderRadius.all(Radius.circular(10)),
                    heightButtom: heightButtom,
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
