import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sign_in_screen.dart'; 
import 'sign_up_screen.dart'; 

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191834),
      body: Stack(
        children: [
          // تم تصحيح المسار ليتوافق مع مجلداتك
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/waves.png', // تعديل المسار والصيغة
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 60),
                // تم تصحيح المسار ليتوافق مع مجلداتك
                Image.asset(
                  'assets/images/logo.png', // تعديل المسار والصيغة
                  width: 200,
                  height: 200,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signin'); // استخدام الـ Routes أفضل
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4F4D78),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.sarala(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFEFF0F7),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup'); // استخدام الـ Routes أفضل
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEFF0F7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.sarala(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF4F4D78),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
