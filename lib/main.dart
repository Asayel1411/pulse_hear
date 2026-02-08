import 'package:flutter/material.dart';
import 'package:pulse_hear/views/bluetooth-asayel/bluetooth_search_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

 


@override 
Widget build(BuildContext context) {
  return MaterialApp(
   
    home: BluetoothScreen(), debugShowCheckedModeBanner: false,
  );
}
}