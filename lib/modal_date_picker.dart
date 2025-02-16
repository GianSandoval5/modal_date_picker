
library modal_date_picker;

export 'src/models/date_picker_view_type.dart';
export 'src/scroll_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_date_picker/src/export.dart';

void dateCustomModalBottomSheet({
  required BuildContext context,
  required TextEditingController controller,
  Color colorBackground = Colors.white,
  Color colorIndicator = Colors.indigoAccent,
  Locale locale = const Locale('en', 'US'),
  bool formatDate = true, // Nuevo parámetro opcional
  final List<DatePickerViewType>? viewType,
  TextStyle selectedTextStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
  TextStyle textStyle = const TextStyle(color: Colors.black),
  TextStyle styleConfirmText = const TextStyle(fontWeight: FontWeight.bold, height: 1.0,color: Colors.indigoAccent),
}) {
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
                      day:  ScrollViewDetailOptions(selectedTextStyle: selectedTextStyle, textStyle: textStyle),
                      month:  ScrollViewDetailOptions(selectedTextStyle: selectedTextStyle, textStyle: textStyle),
                      year:  ScrollViewDetailOptions(selectedTextStyle: selectedTextStyle, textStyle: textStyle),
                    ),
                    viewType: viewType,
                    colorBackground: colorBackground,
                    colorIndicator: colorIndicator,
                    selectedDate: controller.text.isEmpty
                        ? DateTime(1980)
                        : formatDate
                            ? DateFormat('dd/MM/yyyy').parse(controller.text)
                            : DateTime.parse(controller.text),
                    locale: locale,
                    minimumDate: DateTime(1900),
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (DateTime value) {
                      setState(() {
                        if (formatDate) {
                          final DateFormat formatter = DateFormat('dd/MM/yyyy');
                          String formattedDate = formatter.format(value);
                          controller.text = formattedDate;
                        } else {
                          controller.text = value.toIso8601String();
                          print("controller.text: ${controller.text}");
                        }
                      });
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