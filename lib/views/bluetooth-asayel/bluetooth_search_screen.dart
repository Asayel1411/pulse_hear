

// ...existing code...
import 'package:flutter/material.dart';

class BluetoothScreen extends StatelessWidget {
  const BluetoothScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff191834),
      appBar: AppBar(
        title: const Text('Bluetooth Search', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: const Icon(Icons.arrow_back),
        backgroundColor: const Color(0xff191834),
      ),


      // Add a body or other widgets here
    );
  }
}
// ...existing code...