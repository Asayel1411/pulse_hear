import 'package:flutter/material.dart';
 HEAD
import 'splash_screen.dart';
import 'start_screen.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

import 'package:pulse_hear/views/bluetooth-asayel/bluetooth_search_screen.dart';
 f272aee36f2acde65ec4caeabf33588e7a071a50

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

 HEAD
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PulseHear',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const SplashScreen(),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/start': (context) => const StartScreen(),
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
    );
  }

 


@override 
Widget build(BuildContext context) {
  return MaterialApp(
   
    home: PairWristbandScreen(), debugShowCheckedModeBanner: false,
  );
}
>>>>>>> f272aee36f2acde65ec4caeabf33588e7a071a50
}