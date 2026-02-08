# Modal Date Picker

A modal-based date picker for Flutter that provides an intuitive and customizable way to select dates. Designed for seamless integration on Android, iOS, Windows and Web. 🎉

Compatible with Android, iOS, Windows & Web. :heart_eyes:

[![pub](https://img.shields.io/pub/v/modal_date_picker)](https://pub.dev/packages/modal_date_picker)

## Versión 0.0.9

- 🐛 Fixed: date no longer resets when switching between day, month, and year columns
- 🐛 Fixed: scrolling now updates the `TextEditingController` immediately (same as tapping)
- ♻️ Complete internal rewrite for stability and reliability
- Adds `minimumDate` and `maximumDate` support
- Default `Locale('es', 'ES')`

## ✨ Features

- 📅 Fully customizable modal date picker
- 🌍 Supports multiple locales (English, Spanish, French, German, and more)
- 🔄 Smooth scroll-based selection for year, month, and day
- 🎯 Day is preserved when changing month or year (adjusts only if invalid, e.g., Feb 31 → Feb 28)
- 📝 Real-time `TextEditingController` update on both scroll and tap
- 🎨 Customizable colors, text styles, and indicator
- 📐 Configurable date format (`dd/MM/yyyy` or `yyyy/MM/dd`)
- 📱 Works seamlessly with Flutter's `TextFormField`
- 🖥️ Compatible with Android, iOS, Windows & Web

<br>

## 📸 Showcase

<img src = "https://giansandoval.com/vid/1.gif" width = 220> <img src = "https://giansandoval.com/vid/2.gif" width = 220>

<br>

## 🚀 Installation

Add the dependency to your pubspec.yaml:

```yaml
dependencies:
  modal_date_picker: "^lastest_version"
```

Then, run:

```sh
flutter pub get
```

<br>

## 🔥 Usage

Import the package:

```dart
import 'package:modal_date_picker/modal_date_picker.dart';
```

<br>

## 📌 Example

```dart
import 'package:flutter/material.dart';
import 'package:modal_date_picker/modal_date_picker.dart';

void main() {
  runApp(MaterialApp(home: const MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
       home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();

  void _onDateTimeChanged(DateTime value) {
    setState(() {
      _controller3.text =
          "${value.year}/${value.month.toString().padLeft(2, '0')}/${value.day.toString().padLeft(2, '0')}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        title: const Text('Modal Date Picker',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 40),
            //ejemplo de usar en español
            TextFormField(
              readOnly: true,
              controller: _controller,
              decoration: InputDecoration(
                label: const Text('Selecciona una fecha'),
                hintText: 'Selecciona una fecha',
                suffixIcon: Icon(Icons.calendar_month_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onTap: () {
                dateCustomModalBottomSheet(
                  context: context,
                  controller: _controller,
                  //OPCIONALES
                  locale: Locale('es', 'ES'),
                );
              },
            ),
            SizedBox(height: 20),
            //ejemplo de usar en ingles
            TextFormField(
              readOnly: true,
              controller: _controller2,
              decoration: InputDecoration(
                label: const Text('Select a date'),
                hintText: 'Select a date',
                suffixIcon: Icon(Icons.calendar_month_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onTap: () {
                dateCustomModalBottomSheet(
                  context: context,
                  controller: _controller2,
                );
              },
            ),
            SizedBox(height: 20),
            //ejemplo al cambiar varios datos
            TextFormField(
              readOnly: true,
              controller: _controller3,
              decoration: InputDecoration(
                label: const Text('Select a date'),
                hintText: 'Select a date',
                suffixIcon: Icon(Icons.calendar_month_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onTap: () {
                dateCustomModalBottomSheet(
                  //por defecto DateTime(1980)
                  minimumDate: DateTime(1990),
                  //por defecto DateTime.now()
                  maximumDate: DateTime(2100),
                  //si desea formatear la fecha a yyyy/MM/dd
                  formatDate: true,
                  context: context,
                  controller: _controller3,
                  styleConfirmText: const TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                      color: Colors.white),
                  //OPCIONALES
                  //cambiar colores
                  colorBackground: Colors.blue,
                  colorIndicator: Colors.white,
                  //Por defecto Locale('es','ES')
                  locale: Locale('en', 'US'),
                  //POR DEFECTO dd/MM/yyyy - asi puedes cambiar el orden
                  viewType: [
                    DatePickerViewType.year,
                    DatePickerViewType.month,
                    DatePickerViewType.day
                  ],
                  selectedTextStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  textStyle: const TextStyle(color: Colors.white),
                  onDateTimeChanged: _onDateTimeChanged,
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
```

## 🎨 Customization

### Basic usage

```dart
dateCustomModalBottomSheet(
  context: context,
  controller: _controller,
);
```

### All available parameters

```dart
dateCustomModalBottomSheet(
  context: context,
  controller: _controller,
  // Date range
  minimumDate: DateTime(1990),        // default: DateTime(1980)
  maximumDate: DateTime(2100),        // default: DateTime.now()
  // Locale
  locale: Locale('es', 'ES'),        // default: Locale('es', 'ES')
  // Date format
  formatDate: true,                   // true = yyyy/MM/dd, false = dd/MM/yyyy (default)
  // Column order
  viewType: [
    DatePickerViewType.day,
    DatePickerViewType.month,
    DatePickerViewType.year,
  ],
  // Colors
  colorBackground: Colors.white,
  colorIndicator: Colors.indigoAccent,
  colorConfirmButton: Colors.indigoAccent,
  // Text styles
  selectedTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
  textStyle: TextStyle(color: Colors.black),
  styleConfirmText: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  // Button
  borderRadiusButton: BorderRadius.circular(10),
  heightButtom: 25.0,
  // Custom callback (overrides default TextEditingController update)
  onDateTimeChanged: (DateTime value) {
    print('Selected: $value');
  },
);
```

## 📜 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Gian Sandoval**

[![GitHub](https://img.shields.io/badge/GitHub-GianSandoval5-181717?style=flat&logo=github)](https://github.com/GianSandoval5)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-giansandoval-0A66C2?style=flat&logo=linkedin)](https://linkedin.com/in/giansandoval)
[![Email](https://img.shields.io/badge/Email-giansando2022%40gmail.com-EA4335?style=flat&logo=gmail)](mailto:giansando2022@gmail.com)
