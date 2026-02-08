import 'package:flutter/material.dart';

import 'views/splash-elaf/splash_screen.dart';
import 'views/auth-elaf/start_screen.dart';
import 'views/auth-elaf/sign_in_screen.dart';
import 'views/auth-elaf/sign_up_screen.dart';
import 'views/bluetooth-asayel/bluetooth_search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        '/bluetooth': (context) => const PairWristbandScreen(),
      },
    );
  }
}
