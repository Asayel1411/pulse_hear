import 'package:flutter/material.dart';
import 'views/splash-elaf/splash_screen.dart';
import 'views/auth-elaf/start_screen.dart';
import 'views/auth-elaf/sign_in_screen.dart';
import 'views/auth-elaf/sign_up_screen.dart';
import 'views/bluetooth-asayel/bluetooth_search_screen.dart';
import 'views/dashboard-asayel/dashboard_screen.dart';
import 'views/soundlibrary-asayel/sound_library_screen.dart';
import 'views/keywords-elaf/add_keywords_screen.dart';
import 'views/speech-to-text/speech_to_text_screen.dart';
import 'views/text-to-speech/text_to_speech_screen.dart';
import 'views/text-to-speech/quick_phrases_screen.dart';
import 'views/select-mode/select_mode_screen.dart'; // ← ADD THIS

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
      // ── Initial screen ────────────────────────────────────────────────────
      initialRoute: '/splash',
      // ── Named routes ──────────────────────────────────────────────────────
      routes: {
        '/splash':         (context) => const SplashScreen(),
        '/start':          (context) => const StartScreen(),
        '/signin':         (context) => const SignInScreen(),
        '/signup':         (context) => const SignUpScreen(),
        '/bluetooth':      (context) => const PairWristbandScreen(),
        '/dashboard':      (context) => const DashboardScreen(),
        '/sounds':         (context) => const SoundLibraryScreen(),
        '/keywords':       (context) => const KeywordsScreen(),
        '/speech-to-text': (context) => const SpeechToTextScreen(),
        '/text-to-speech': (context) => const TextToSpeechScreen(),
        '/quick-phrases':  (context) => const QuickPhrasesScreen(),
        '/select-mode':    (context) => const SelectModeScreen(), // ← ADD THIS
      },
    );
  }
}