library modal_date_picker;

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

void dateCustomModalBottomSheet({
  required BuildContext context,
  required TextEditingController controller,
  Color colorBackground = Colors.white,
  Color colorIndicator = Colors.indigoAccent,
  Locale locale = const Locale('en', 'US'),
  bool formatDate = false, // Nuevo parámetro opcional
  List<DatePickerViewType>? viewType,
  TextStyle selectedTextStyle = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
  TextStyle textStyle = const TextStyle(color: Colors.black),
  TextStyle styleConfirmText = const TextStyle(
      fontWeight: FontWeight.bold, height: 1.0, color: Colors.indigoAccent),
  void Function(DateTime)? onDateTimeChanged, // Nuevo parámetro opcional
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
            decoration: BoxDecoration(color: Colors.transparent),
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
                    minimumDate: DateTime(1900),
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (DateTime value) {
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
