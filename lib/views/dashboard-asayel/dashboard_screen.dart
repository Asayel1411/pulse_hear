import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pulse_hear/views/bluetooth-asayel/bluetooth_search_screen.dart';
import 'package:pulse_hear/views/soundlibrary-asayel/sound_library_screen.dart';
import 'package:pulse_hear/views/setting-elaf/setting_screen.dart';
import 'package:pulse_hear/views/emergency-contacts/emergency_contacts_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  // Tab screens
  final List<Widget> _screens = [
    const _HomeTab(),
    const EmergencyContactsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8ECF4),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        height: 75,
        margin: const EdgeInsets.only(bottom: 25, left: 20, right: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF1D1B3F),
          borderRadius: BorderRadius.circular(35),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: Icons.home,
              index: 0,
              label: 'Home',
            ),
            _buildNavItem(
              icon: Icons.contact_phone_rounded,
              index: 1,
              label: 'Contacts',
            ),
            _buildNavItem(
              icon: Icons.settings,
              index: 2,
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
    required String label,
  }) {
    final isSelected = _currentIndex == index;

    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? Colors.white : Colors.white54,
        size: 28,
      ),
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
      },
      splashRadius: 24,
    );
  }
}

// Home Tab Widget (your original dashboard content)
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. Header Section
        Container(
          width: double.infinity,
          height: 150,
          decoration: const BoxDecoration(
            color: Color(0xFF1D1B3F),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/smallwaves.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: -50,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 260,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 25),

        // 2. Connection Status Card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/bluetooth');
            },
            borderRadius: BorderRadius.circular(40),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 63, 61, 91),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: const Color.fromARGB(255, 16, 16, 40),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Image.asset('assets/images/watch.png',
                          width: 110, height: 110),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.white70, width: 1.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.power_settings_new,
                            color: Colors.white, size: 20),
                      )
                    ],
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Connected',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'Your Wristband is ready to alert you',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Battery level ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10)),
                              Text('100%',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.battery_full,
                                  color: Colors.greenAccent, size: 18),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // 3. Features Grid
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: GridView.count(
              padding: const EdgeInsets.only(top: 0),
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                _buildIconCard(
                  context,
                  'Sound Library',
                  'assets/images/sound_library.png',
                  () => Navigator.pushNamed(context, '/sounds'),
                ),
                _buildIconCard(
                  context,
                  'Keywords',
                  'assets/images/keyword-2 1.png',
                  () => Navigator.pushNamed(context, '/keywords'),
                ),
                _buildIconCard(
                  context,
                  'Speech-To-Text',
                  'assets/images/speech_to_text.png',
                  () => Navigator.pushNamed(context, '/speech-to-text'),
                ),
                _buildIconCard(
                  context,
                  'Text-To-Speech',
                  'assets/images/text_to_speech.png',
                  () => Navigator.pushNamed(context, '/text-to-speech'),
                ),
                _buildIconCard(
                  context,
                  'Modes',
                  'assets/images/modes.png',
                  () => print("Navigate to Modes"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconCard(
      BuildContext context, String title, String imagePath, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color.fromARGB(255, 175, 175, 215),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 30,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 60, height: 60),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
