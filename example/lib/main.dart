import 'package:flutter/material.dart';
import 'package:modal_date_picker/modal_date_picker.dart';

void main() => runApp(const MyApp());

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
                  //POR DEFECTO dd/MM/yyyy - asi puedes cambiar el orden
                  viewType: [
                    DatePickerViewType.day,
                    DatePickerViewType.month,
                    DatePickerViewType.year
                  ],
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
            //ejemplo al cambiar los colores
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
                  locale: Locale('en', 'US'),
                  //POR DEFECTO dd/MM/yyyy - asi puedes cambiar el orden
                  viewType: [
                    DatePickerViewType.day,
                    DatePickerViewType.month,
                    DatePickerViewType.year
                  ],
                  selectedTextStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  textStyle: const TextStyle(color: Colors.white),
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
